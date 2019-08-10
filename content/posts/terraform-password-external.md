+++
title = "Hashing passwords on Terraform machine"
date = 2019-01-05T17:58:48+01:00
description = "How to stay sane and secure when handling passwords in Terraform"
categories = ["security", "terraform"]
tags = []
+++

## Preface

Hello, internet! Did you know that there are some problems you cannot tackle by simply heading to Stack Overflow?

I was doing a Terraform setup for an analytics system. And with big data comes mighty visualization tool - Kibana. Because of networking, I’ve already had a proxy set up to forward traffic from the world to Kibana, yet some kind of security measure was required to ensure only our client has access to it. Long story short… passwords!

I've been given some code to start with and my job was to make it production grade, here's an excerpt from one of the original `.tf` files:

{{< highlight sh >}}
  provisioner "remote-exec" {
    inline = [
      "...",
      "printf '${var.kibana_credentials["username"]}:$(openssl passwd -crypt ${var.kibana_credentials["password"]})\n' | sudo tee /etc/nginx/htpasswd",
      "...",
    ]

  ...
}
{{< /highlight >}}

## What's wrong with that

The overall code was fine, but the following part posed a lot of security issues:

{{< highlight bash >}}
$(openssl passwd -crypt ${var.kibana_credentials["password"]})
{{< /highlight >}}

- the password is limited to 8 chars ![](/8digits.png)
- it uses `DES` under the hood, which can be brute-forced swiftly and at a sensible price; using consumer-grade hardware [(details)](https://en.wikipedia.org/wiki/Data_Encryption_Standard#Chronology)
- sending the password in plaintext to the internet - the hashing occurs on the proxy machine

### Note

Some tutorials on the internet recommend using `htpasswd [-c]` which in terms of security is roughly the equivalent of the code above.

### Low-hanging fruit

The obvious fix for the first issue was using a more suitable hashing algorithm - I've chosen `SHA-512` because it's the strongest of algorithm supported by `crypt(3)` from `glibc`, which is [used by nginx to verify passwords](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html). I'm using `mkpasswd` from `whois` package as a frontend to `crypt(3)`.

{{< highlight bash >}}
$(echo '${var.kibana_credentials["password"]}' | mkpasswd -m sha-512 -s )
{{< /highlight >}}

The second issue can be addressed by hashing more than once. How many times then? [It depends](https://security.stackexchange.com/questions/3959/recommended-of-iterations-when-using-pkbdf2-sha256/3993#3993)...

{{< highlight bash >}}
$(echo '${var.kibana_credentials["password"]}' | mkpasswd -m sha-512 -s -R 100000)
{{< /highlight >}}

## The problem

The password is still sent in plaintext and Terraform doesn't offer an obvious solution to hashing the password locally neither via interpolation syntax nor plugins.

## The attempts

### Generating the digest inside Terraform

I've tried crafting my own crypt-compatible function using only Terraform. This seemed possible as Terraform interpolation syntax has `base64sha512(string)` and `sha512(string)` functions. **I failed.** On one hand the digest-digest's format (part of crypt's digest corresponding to the hashed password) is not only **not** base64, I couldn't find a specification for it, so reimplementing this would require reading and understanding relevant part of `glibc` (not something I wanted to do for this particular thing), on the other hand I've had no idea how to implement multiple function application in Terraform.

### Using `external` provider

Using the [external data source](https://www.terraform.io/docs/providers/external/data_source.html), which executes an arbitrary program, feeding the input via stdin and capturing stdout for usage inside Terraform, I can declare an interface to my hashing script.

{{< highlight tf >}}
data "external" "kibana_password_crypt" {
  program = ["python3", "${path.module}/terraform_crypt.py"]

  query = {
    salt             = "${random_string.salt.result}"
    raw_password     = "${var.kibana_credentials["password"]}"
    round_exponent   = 6
    round_multiplier = 2
    # rounds = multiplier * 10^exponent 
  }
}
{{< /highlight >}}

And the usage is as follows:

{{< highlight bash >}}
${data.external.kibana_password_crypt.result["phc_string_password_hash"]}
{{< /highlight >}}

Now the only thing left is the implementation. Luckily python has [crypt(3) binding](https://docs.python.org/3/library/crypt.html) as a part of its standard library. Since both input and output should be JSON, I'm utilizing `json` package as well.

{{< highlight py >}}
# terraform_crypt.py
import sys
import json
import crypt

tf_raw_input = sys.stdin.read()
tf_parsed_input = json.loads(tf_raw_input)

raw_password = tf_parsed_input["raw_password"]
round_multiplier = int(tf_parsed_input["round_multiplier"])
round_exponent = int(tf_parsed_input["round_exponent"])
salt = tf_parsed_input["salt"]

round_count = round_multiplier * 10 ** round_exponent

hash_parameters = {
    "hash_id": crypt.METHOD_SHA512.ident,
    "round_count": round_count,
    "salt": salt,
}
crypt_parameter_string = "${hash_id}$rounds={round_count}${salt}".format(**hash_parameters)

result = {"phc_string_password_hash": crypt.crypt(raw_password, crypt_parameter_string)}
print(json.dumps(result))
{{< /highlight >}}

## Finally
This is definitely more code and tinkering than naive approach. All in all, I think it's worth the effort, given the improved security.

Few tips regarding `external` provider (which you can also obtain by carefully reading the docs):

- external programs should be treated as pure functions - they should only depend on arguments provided via stdin, otherwise Terraform might plan some actions even though nothing has been changed by you; that's why I've moved the salt generation inside Terraform
- the external program is executed every time Terraform traverses the dependency graph - this should be taken into account if your program takes significant time to run
- a Terraform-only solution is always prefered if possible
