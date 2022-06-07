+++
title = "Computer Aided"
date = 2022-05-28T02:35:41+02:00
description = ""
draft = true
+++

> All right, I've been thinking, when life gives you lemons, don't make lemonade! Make life take the lemons back! I don't want your damn lemons! What am I supposed to do with these?

—  <cite>Cave Johnson</cite>

> I've purchased the devices with my own money. Tentacle Sync GmbH has not compoensated me for saying anything about their product. But like... it would be nice if they did.

## Get Mad!

A new, shiny [timcode](https://en.wikipedia.org/wiki/Timecode) piece. It's literally what it sounds like - an expensive clock that goes beep-boop. There are many like it, but those ones are mine... 

Anyhow, before a shoot I'd like to mount [Tentacle Sync E](https://tentaclesync.com/sync-e) on top of a camera. Yeah, this [shoe mount](https://en.wikipedia.org/wiki/Hot_shoe) thing looks great for that and it's readily avaible on many DSLRs! Surely there is a nice accessory that does just that, right? Erm... right?

Well... certailny not [this one](https://shop.tentaclesync.com/product/sync-e-bracket-withcold-shoe-mount/). And that's one of the official "solutions". In fact that's the only official solution for mounting tentacle on a female shoe mount (I refuse to call it a cold shoe).

And it's a bit overpriced and overengineered for my taste. See, how I've described it without saying it's flat-out retarded?

Some rationalle to back up the above:
- the inbuilt velcro works just fine for various scenarios (mounting on the botom of a Zoom H5 attached to my belt, directly camera in various configurations, etc.)
- why so many moving pieces?
- why use a tool for something that can be operated successfully by hand?
- like seriously, what's wrong with velcro to justify a 2-piece modular system?
- all of that adds to the price and can fail when you least expect it

There was one thought going through my head, the most important words a man can say:
> I will do better

## Proof of Concept

Ok, back to first principles. What I need is an adapter between a female shoemount and a velcro pad. At some point in life I was 2 years and a lot of self-respect away from graduating as an electrical engineer. I can certainly do this!

So, I've drawn something, and asked my friend, [Rasskabak](https://arasaka.pl/) to create a 3D model in Blender.

![](/tentacle-first-draft-project.jpg)

I've had no idea what the dimesions for a shoe mount are, so I found a [cold shoe extender on thingiverse](https://www.thingiverse.com/thing:3742926) and just asked him to copy from that.

![](/rass-blender-project.png)

He exported the STL and yet another friend printed a few instances for me.

![](/tentacle-1st-prototype.jpg)

At this point I've notied that the cuboid to which the velcro is attached to (further reffered to as "table") is waaay too small. Also it was warped as fuck. But with a bit of sanding it fit comfortably (and by that I mean it could be reliably inserted and removed without tools, not that it was a nice process) on top of the camera and worked well through 5 shooting days.

![](/tentacle-1st-prototype-on-camera.jpg)
![](/tentacle-1st-prototype-on-camera-detail.jpg)

So... it was invented by technical university dropout, mis-designed, mis-printed and it still does the job well!

## Let's get serious!

Lessons learned:
- Warping is a thing
- PLA would be a better fit for the project as it's easier to work with using comodity printers and I don't need the ABS's "far superior snap tension impact resistance" (where "snap" is a fourth derivative of position with regards to time)
- I need to be doing the designing
- Blender is not an approperiate tool for precision CAD work

### Design

[OpenSCAD](https://openscad.org/) was suggested to me, and oh boy is it wonderfull! After initial confusion (yup, you need to thing in terms of basic shapes and geometric translations) I find it actually very intuitive and fun to work with!

```js
module cold_shoe_insert() {
    cube([18.6, 18, 2], center=true);

    translate([0,0,(2 + 1.5) / 2]) {
        cube([12.5, 18, 1.5], center=true);
    }
}
```

The code above corresponds to the blue cold shoe insert visible below

![](/tentacle-2nd-design.jpg)

TODO:
- I've learened the scad language better and parametrized the shit out of the code
- Added a velcro pad dip and rounded corners
- Realized that if the table would be too long the locking connector couldn't fit in place... fortunately before printing the 2gen mark 1

### Precision

The first iteration used a self-measured dimensions, which kindof worked ok, but I've leared so far that the cold shoe mount is (somewhat) [standardized](https://en.wikipedia.org/wiki/Hot_shoe#Design) under [ISO-518](https://cdn.standards.iteh.ai/samples/36330/0f7a221b5b7647cc972f7403f522191a/ISO-518-2006.pdf), relevant part of which is available for a free preview.

Also: Tentacle openly states the dimensions of the device on [their website](https://tentaclesync.com/sync-e) (You'll have to scroll to the bottom, unfortunately there is no css id I could anchor to :c)

The design contains arbitrary margin anyhow, but at least they're with relation to the actual thing! At this point the only self-measured thing is the inbuilt velcro pad (for the dip, which has a margin anyhow). I've contated Tentacle with the request to specify the exact dimensions, we'll see what happens.

### Slicing

Now comes the "M" part of CAM! [Bartek's](https://banachewicz.pl/) help was instrumental in getting this one right. My first instinct was to turn the model upside down (so that there's more surface touching the bed). I was informed that it doesn't work that way and Bartek suggested rotating the model 90 degrees towards the narrower end (see picture) and adding supports. Otherwise I've used the predefined "0.1mm-fine" print profile.

![](/img/computer-aided/gen2mk1-slicing-1.png)
![](/img/computer-aided/gen2mk1-slicing-2.png)

### Real deal
I've printed gen2mk1 on a work printer, here's how it looks off and on set:

![](/img/computer-aided/gen2mk1-upside.jpg)
![](/img/computer-aided/gen2mk1-mission.jpg)

It worked even better than gen1! Aside from holding the Tentacle just as fine as the previous generation the mounting experiance if by far improved. The holder fit's the shoe like a glove and it's pleaseant to work with.

### Iterations
TODO:
- parameter experiments [if any]

## 3rd gen

TODO:
- locking screw

- assembly instruction

- photos + field report

- R&D breakdown (so far: 2-4 hours and had tons of fun!, a bit of ABS, little more of PLA, neglegible amounts of velcro)
- overall production cost

TOOD: upload to thingiverse (both 2nd gen and 3rd gen)

TODO: other fun stuff
https://www.thingiverse.com/thing:5258556
https://www.thingiverse.com/thing:4666836

TODO: spelling xD
TODO: proofread

## Sauce

- [Designs](https://github.com/allgreed/things)
- [Local copy of ISO-518 preview](/ISO-518-2006.pdf)
