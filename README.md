## Dockerfile for fast apt/deb installs with nala

I've used deb/ubuntu for more than twenty years now. For most of the first decade, I never imagined having enough
bandwidth to saturate a mirror connection. For most of the past decade, I've used that apt install delay as an excuse to
multi-task or make a coffee.

It's been a good run, but with nala, that's all over.  At least, if you're saturating single conn downstream on one mirror...

For larger orgs or heavier users, you should also think about a local mirror or at least a caching proxy. But nala can
speed up even those use cases if your internal network is fast enough.

You can learn more about nala here:
https://gitlab.com/volian/nala