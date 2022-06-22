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
- like seriously, what's **so** wrong with velcro to justify a 2-piece modular system?
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

Turns out that the OpenSCAD's vernacualr is particullary usefull once you take the time to actually learn it. I've parametrized everything that could be sensibly parametrized. My curiosity only grew and I've learned about `minkowski` sum, which yielded nice, rounded corners. I've also realized that including the dip for velcro would be a nice idea as well as that if the table would be too long the locking connector couldn't fit in place. Fortunately it all happened before printing the first prototype of gen2.

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

#### Design
TODO:
- czy Tomek chce credits? xD

I've learned some more about the OpenSCAD language (like the `if` statemetns), did some reminiscing about geometry (up to the level of `arctangent`) and finally managed to add chamfered edges to the velcro dip, as well as the cold shoe (negating the need for supports at that point and further reinforcing the design). 

For mark 2 I've reduced the table margin to 3mm [-2] and increased the velcro dip to 1mm [+0.5]. This and the added chamfers allowed to reduce the priting time by over 35% (down to 1:10h) and get rid of the annoying supports on the back. I was affraid that without the supports the accessory would fall during printing, fortunately that wasn't the case.

Turns out the velcro dip is still a litlle off, I've corrected it when designing mark 3. I've also neglected one of the paramterer experiments, so I've altered the table height to 2mm [-1].

Finally, I've doubled the angle of the top edge chamfer, since it doesn't look unifrom with the slope of the left and right edges (I guess due to the manufacturing process) and crafted fancy corners that'd would support that.

I needed a bit of prototyping on the side, as well as [yanking some excellent support functions](https://gusmith.wordpress.com/2015/09/18/simple-tool-for-creating-polyhedrons-in-openscad/).

![](/img/computer-aided/designing-fancy-corener.png)

But I think overall it was worth it!

![](/img/computer-aided/fancy-corners-comparison.png)

After printing mark 6 I've solved the most pressing issue, namely the pad not maching the stock velcro that comes with the Tentacles. I've also verified that my ideas about corners and increased slope were splendid.

I gotta stop somewhere. Though I had ideas like using somthing called "adapter reporterski" [a cold shoe adapter, if that term wasn't overloaded enough] for even better fit. There are no annoying and pressing problems left with the current design. I'll leave you something to imagine.

One last thing (which isn't strictly design-related) was that I've rotated the model, so that the exported STL is slice-ready.

#### Manufacturing

Yup, I know. The timeline drifted a bit. I wanted to include manufacturing and desing experiments in one mark. That obviously backfired and messed up my counting.

The thinner table (and threfore less layer 1 surface) caused a print to shift during the process (I've added a straight red line to ilustrate the drift), therefore warping everything to a molten synthetic hell.

![](/img/computer-aided/mk3.jpg)

For mk4 I've reverted to the original table thickness, however tried the fast printing settings and the print failed as well. 

![](/img/computer-aided/mk4.jpg)

As you can see there wasn't any noticible difference in quality between normal (0.15mm) and fine (0.1mm [layer height]) and the former print in 0:34h, so ~50% less then previously and overall 1/3 of the initial printing time. However brim adhesion was neccessary, no idea why it worked before so well (it's all about the surface touching the build plate, but I don't think that has changed much between mk5 and earlier designs...).

![](/img/computer-aided/fine-vs-normal.jpg)

For mk7 I've tried printing without supports, but that's not really helping. Everything warps and though still usable it's actually more of a problem to print and sand correctly - missing the entire point of the experiment. I wanted to remove the supports so that the holder can be made without any tools beside 3d printer. That has failed, so I'm settling on the manufacturing process the led me to mk6.

![](/img/computer-aided/mk6-vs-mk7.jpg)

The final manufacturing settings used for the following "mass" production were:
- normal profile
- 20% infill
- supports enabled with angle set to 46°
- z-hop when retracting

![](/img/computer-aided/mass.jpg)

## Conclusions

The R&D expenses so far where:
- ~10-20 hours of my time, which is by far the biggest expense, but it was offsetted by the fact that I just loved it every step along the way (and that'd be much less if I knew how to design and 3d print in the first place)! Let the rought estimate be a proof of that.
- less than 10g of ABS filament
- less than 48g of PLA filament
- neglegible amounts of velcro

and I've managed to produce 4 working prototypes (out of 7 prints). The resulting produc prints in less than about half an hour and costs less than 10 cents in raw material. I my book that's a whooping success!

![](/img/computer-aided/aczomplit.png)

Btw. if you happen to be in Poland and lack a 3d printer you can buy the holder here! At a far more reasonable price.

TODO: change repo name, update source link
TODO: add rudamentary README to repo, and like... Makefile maybe? / nix
TOOD: upload to thingiverse

TODO: Tomek
TODO: link do sprzedaży Rasskabakowi

TODO: publish
TODO: spelling xD
TODO: fix issues + publish
TODO: proofread
TODO: fix issues + publish

## Sauce and prior art

- [Designs](https://github.com/allgreed/things)
- [Local copy of ISO-518 preview](/ISO-518-2006.pdf)
- [The other way around xD](https://www.thingiverse.com/thing:4666836)
- [Almost! Too complex for my taste](https://www.thingiverse.com/thing:5258556)
