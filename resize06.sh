umount /home
df -h
e2fsck -f /dev/mapper/vg_hdp15slave05-lv_home
resize2fs -p /dev/mapper/vg_hdp15slave05-lv_home 500G
mount /home
df -h
lvreduce -L 500G /dev/mapper/vg_hdp15slave05-lv_home
lvextend -L +4.9T /dev/mapper/vg_hdp15slave05-lv_root
resize2fs -p /dev/mapper/vg_hdp15slave05-lv_root
df -h


