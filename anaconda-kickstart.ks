text
keyboard --vckeymap=it --xlayouts='it'
lang it_IT.UTF-8

# Ignora tutti i dispositivi tranne i due dischi NVMe fisici
ignoredisk --only-use=nvme0n1,nvme1n1
zerombr
clearpart --all --initlabel

# 1. Partizioni per biosboot (1 MB su ciascun disco per GPT + BIOS)
part biosboot --fstype="biosboot" --size=1 --ondisk=nvme0n1
part biosboot --fstype="biosboot" --size=1 --ondisk=nvme1n1

# 2. Partizioni fisiche per il RAID1 di /boot
part raid.01 --size=1024 --ondisk=nvme0n1
part raid.02 --size=1024 --ondisk=nvme1n1

# 3. Partizioni fisiche per il RAID1 dell'LVM (occupa tutto lo spazio restante)
part raid.11 --size=1000 --grow --ondisk=nvme0n1
part raid.12 --size=1000 --grow --ondisk=nvme1n1

# Creazione degli Array RAID1
raid /boot --level=1 --device=md0 --fstype="xfs" raid.01 raid.02
raid pv.01 --level=1 --device=md1 --fstype="xfs" raid.11 raid.12

# Creazione Volume Group e Volumi Logici
volgroup vg_openvzwdpro pv.01
logvol / --fstype="xfs" --size=50000 --name=root --vgname=vg_openvzwdpro
logvol swap --fstype="swap" --size=8192 --name=swap --vgname=vg_openvzwdpro

# Volume /vz in ext4 per massima stabilità con opzione noatime
logvol /vz --fstype="ext4" --size=1000 --grow --name=vz --vgname=vg_openvzwdpro --fsoptions="defaults,noatime"

bootloader --location=mbr
eula --agreed
reboot
EOF
