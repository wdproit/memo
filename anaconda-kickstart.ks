text
keyboard --vckeymap=it --xlayouts='it'
lang it_IT.UTF-8

ignoredisk --only-use=nvme0n1,nvme1n1
zerombr
clearpart --all --initlabel

part /boot/efi --fstype="efi" --size=500 --ondisk=nvme0n1

part raid.01 --size=1024 --ondisk=nvme0n1
part raid.02 --size=1024 --ondisk=nvme1n1

part raid.11 --size=1000 --grow --ondisk=nvme0n1
part raid.12 --size=1000 --grow --ondisk=nvme1n1

raid /boot --level=1 --device=md0 --fstype="xfs" raid.01 raid.02
raid pv.01 --level=1 --device=md1 --fstype="xfs" raid.11 raid.12

volgroup vg_openvzwdpro pv.01
logvol / --fstype="xfs" --size=50000 --name=root --vgname=vg_openvzwdpro
logvol swap --fstype="swap" --size=8192 --name=swap --vgname=vg_openvzwdpro

logvol /vz --fstype="ext4" --size=1000 --grow --name=vz --vgname=vg_openvzwdpro --fsoptions="defaults,noatime"

bootloader --location=partition --boot-drive=nvme0n1

eula --agreed
reboot
