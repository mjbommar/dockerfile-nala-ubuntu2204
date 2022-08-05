# Dockerfile for fast apt/deb installs with nala

## Motivation
I've used deb/ubuntu for more than twenty years now. For most of the first decade, I never imagined having enough
bandwidth to saturate a mirror connection. For most of the past decade, I've used that apt install delay as an excuse to
multi-task or make a coffee.

It's been a good run, but with nala, that's all over.  At least, if you're saturating single conn downstream on one mirror...

## Details
This is a demo Dockerfile for Ubuntu 22.04 that includes basic setup for the nala "wrapper" around libapt, which
can substantially speed up build processes involving large numbers of apt/deb package installs.

N.B.: There's an overhead to installing nala.  If you only have a few packages, you may not get much benefit.
If you maintain your own "base" image for ubuntu, bake it in there for maximum downstream impact across your
images and combine with a local mirror or apt proxy cache.

P.S.: You won't see the pretty nala output unless you have buildkit enabled (e.g., DOCKER_BUILDKIT=1 ...)

You can learn more about nala here:
https://gitlab.com/volian/nala

## License
MIT