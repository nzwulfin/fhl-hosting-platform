# fhl-hosting-platform
A personal hosting platform for containers and VMs based on Fedora Hummingbird Linux

Starting with the bootc FHL image, what minimally would I need to run VMs and containers on a single sysmtem with some level of ergonmics?

* Libvirt is obvious, NSS support makes things easy from the host
* Container tools are mostly already there, add buildah to complete the set
* Cockpit proved useful as the interface to do this for my existing bootc based setup
* Vim or cockpit-files can work as a basic editor
