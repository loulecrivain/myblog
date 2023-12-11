---
title: Improved Huawei NE40E in GNS3
date: 10/12/2023
author: kouett

hero_classes: text-light title-h1h2 overlay-dark-gradient
show_sidebar: true

taxonomy:
    category: blog
    tag: [gns3, routing, huawei]
---

Here we delve into the story of misnumbered interfaces on a GNS3 template, or how LLDP became my friend.

===

# In the beginning

For reasons™, I had to set up a lab comprising of virtual Huawei routers. I had no particular restrictions as for which model exactly, from the moment it ran a fairly recent version of VRP software (Huawei's Versatile Router Platform).

Since Huawei's eNSP simulation platform [is now discontinued](https://forum.huawei.com/enterprise/en/ensp/thread/667283910159122432-667213872060313600), the next best choice was to use GNS3.

Browsing the [GNS3 appliances repository](https://gns3.com/marketplace/appliances) revealed that indeed, there was an existing template for a virtual Huawei NE40E.

After a little bit of digging, the correct image for the template was found [on the vendor forum](https://forum.huawei.com/enterprise/en/ne40e-image-for-the-eve-ng/thread/667246427329413121-667213852955258880).

## Lab structure

As for the lab, the goal was to reproduce a typical ISP backbone with MPLS transport and BGP-free core configuration. So we have the following structure:
![typical ISP network with MPLS core, ASBR / PE](lab1.png)

## Where things go wrong

Once the lab was set up as above, I started configuring the IGP protocol on the first two leftmost routers.
However, they weren't able to ping each other:

```sh
<HUAWEI>ping 172.31.223.30
  PING 172.31.223.30: 56  data bytes, press CTRL_C to break
    Request time out
	Request time out
	Request time out
	Request time out
	Request time out

  --- 172.31.223.30 ping statistics ---
    5 packet(s) transmitted
	0 packet(s) received
	100.0% packet loss
```

From there I was a bit puzzled. Did I made a mistake in my configuration ? After triple checking, apparently, no. So the problem was somewhere else...


# The culprit

First, after looking at the corresponding NE40E template for EVE-NG, I suspected some drivers issues, since this one uses ```vmxnet3``` NICs instead of ```e1000```.

So, I tinkered with the official template to move all VM NICs to ```vmxnet3```. But no luck, same problem !

After some more tests, I found that only ```eth0``` (```GigabitEthernet 0/0/0``` on the NE40E) were working, when put face-to-face.

Since the rest of the interfaces were named FastEthernet, I thought it may be some classical full-duplex / half-duplex configuration issue.

However, the collision/error counters weren't matching this hypothesis. If it was the case, I should have *some* packet loss, not packet loss
*all the goddamn time*.

## LLDP to the rescue

It was time to resort to Wireshark. 

how did you found the error
eth0 test
lldp debugging -> what commands did you use ?
how you found numbering was shit

## a small irc discussion
don't forget to credit ! -> ask on irc

1. change on GNS3 ui
2. where you found gns3 redefined interfaces template (.local)
3. hurra :) what's left: rewriting to new template



## fixing it

the new template
link github pull request

# bonus track
link the original NE40E image on www files
for better availability
