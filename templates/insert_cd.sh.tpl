export PATH="$PATH:/usr/sbin:/sbin:/bin:/usr/bin:";
disk="$(virsh qemu-monitor-command {$prefix}{$vps_vzid} --hmp --cmd "info block"|grep -e "not inserted" -e "/tmp/cd{$vps_vzid}.iso" | cut -d: -f1)";
virsh change-media {$prefix}{$vps_vzid} hdc --eject --live;
if [ {$url} != "" ]; then
	wget -O /tmp/cd{$vps_vzid}.iso {$url};
	virsh change-media {$prefix}{$vps_vzid} hdc /tmp/cd{$vps_vzid}.iso --update --live --config
fi;