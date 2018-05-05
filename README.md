# open-semantic-desktop-search
 Open Semantic Desktop Search (VM)


# Dependecies

- Debian package Open Semantic Search Server open-semantic-search_xx.xx.xx.deb

- Virtual Box guest additions ISO

- vmdebootstrap ("apt-get install vmdebootstrap")


# Build

- Download / copy Open Semantic Search Server Debian package open-semantic-search_xx.xx.xx.deb to the path src/packages.chroot

- Run the build script as root

- Add an Virtual Box setup for the VM image

- Config VM system settings like RAM and how many CPUs to use

- Config the Virtual Box guest additions as CD ROM in Virtual Box Settings / Storage / Attributes / Optical Drive

- Run this VM so installation within VM environment starts

- After installation the VM will shutdown

- Remove virtual CD with Virtual Box guest additions

- Export appliance
