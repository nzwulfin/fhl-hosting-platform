FROM quay.io/hummingbird-community/bootc-os:latest

# Install packages needed for containers, virtual machines, cockpit
RUN dnf5 -y install qemu-kvm libvirt virt-install virt-viewer podman buildah skopeo cockpit cockpit-machines cockpit-podman cockpit-storaged cockpit-networkmanager cockpit-files NetworkManager-wifi mkpasswd firewalld vim libvirt-nss guestfs-tools pcp python3-pcp && dnf clean all 

# Passwordless sudo for admins
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo

# Enable some default services
RUN systemctl enable podman.socket cockpit.socket fstrim.timer pmlogger.service

# Mask the auto timer so we can control this in a downstream image or host
RUN systemctl mask bootc-fetch-apply-updates.timer

# Enable nss support for virtdomain name resolution
RUN sed -i 's/hosts:\s\+ files/& libvirt libvirt_guest/' /etc/nsswitch.conf

# Remove some targeted build leftovers we won't need in var
RUN rm /var/{cache,lib}/dnf /var/lib/rhsm /var/cache/ldconfig -rf

# For good measure, lint the container
RUN bootc container lint
