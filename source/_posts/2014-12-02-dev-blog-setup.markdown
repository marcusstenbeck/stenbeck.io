---
layout: post
title: "Dev Blog Setup: VPS, nginx, .io domain"
date: 2014-12-02 11:47:14 +0100
comments: true
categories: 
---

I've been considering taking the leap and learning how to run a server for quite some time. After all, there are many reasons I can think of for why it's a good idea. Then again, I'm bound to suffer some pain down that road. At the moment I feel a soothing ignorance while contemplating it, so I've decided to ride that feeling for as long as it stays.

For obvious reasons I'll document the process. There's so much I don't know. So very much.

<!-- more -->

## .io Domain

I've been looking at these for quite some time. They're the trendy thing right now, and I was happy to find out that [stenbeck.io](http://stenbeck.io/) was available (there are some wealthy Stenbecks in Sweden that could have bought it before me). The .io domains are a bit more expensive than what I'm used that a domain costs, but all in all I think it's worth it.

I remember looking here and there for where to register .io domains, and I think it was some Quora answer that put the on the path to [iwantmyname.com](http://www.shareasale.com/r.cfm?b=210738&u=1039469&m=25581&urllink=&afftrack=). I've been using an "old world" hosting provider to handle my domains, and I'm very happy to say that [iwantmyname.com](http://www.shareasale.com/r.cfm?b=210738&u=1039469&m=25581&urllink=&afftrack=) is a breath of fresh air. Their control panel is modern, more akin to something you'd run into in 2014.


## Hosting

Honestly, my only requirements for the hosting was that I wanted root access to a VPS, and access to a massive lump of resources for learning. That's it. I don't know enough to have any other requirements.

I only looked at two options for where I should host; Linode and [DigitalOcean](https://www.digitalocean.com/?refcode=0b7ca2503b1c). Both let me have root access to any VPS i create with them. Any of those would have fulfilled my needs perfectly. However, after stumbling upon [a very humble and balanced Quora answer by Moisey Uretsky](http://www.quora.com/Which-is-a-better-host-for-personal-work-Linode-or-Digital-Ocean), cofounder of [DigitalOcean](https://www.digitalocean.com/?refcode=0b7ca2503b1c), I decided to go with them. I figure I can always switch if I don't like it, and the honest answer scored some browney points in my book.

*Note: The discount code in the Quora reply is expired, but if you click any of the [DigitalOcean](https://www.digitalocean.com/?refcode=0b7ca2503b1c) links in this post you get a $10 credit.*


## Server Setup

While setting up the [DigitalOcean](https://www.digitalocean.com/?refcode=0b7ca2503b1c) Droplet (which is their word for a VPS) I was very helped by their excellent learning resources. They're exactly at the right technical level for me.


## Base Setup

Most of what I did was standard stuff. I've listed the steps I took below.

1. Register my domain name.
2. Register a [DigitalOcean](https://www.digitalocean.com/?refcode=0b7ca2503b1c) account.
3. Set up hostname.
4. Set up a Droplet (VPS).
5. Set up SSH keys.
6. Set up Nginx web server.
7. Celebrate!

## Next Up

I modified the Nginx configuration file to serve a particular folder as the web root. That's what you're seeing right now. There's [an article on how to use Nginx server blocks](https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-14-04-lts) that I'll check out tomorrow. For now, serving it up like this looks good enough to me.

I have to say that editing HTML straight in `nano` on my remote VPS does have its nerdy charm. However, I am so extremely happy I don't have to do this for every single site.