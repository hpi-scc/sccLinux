#!/bin/bash

BUILDROOT_VERSION=2011.11

BUILDROOT=buildroot-${BUILDROOT_VERSION}
BUILDROOT_FILE=${BUILDROOT}.tar.bz2
BUILDROOT_PATCH=${BUILDROOT}-scc.patch

PERFORM_DIFF=""

if [ ! -d $BUILDROOT ]; then
  echo "Please execute \"./configure.sh\" first... Aborting!"
  exit
fi

if [ $1 == "--diff" ]; then
  echo Finding out changes compared to existing patch!
  cat patches/${BUILDROOT}-scc.patch | grep -v '^+++' | grep -v '^+++' | grep -v '^---' > existingPatch
  ./createBuildrootPatch.sh tmpPiggy > /dev/null
  cat tmpPiggy | grep -v '^+++' | grep -v '^---' > newPatch
  tkdiff existingPatch newPatch
  rm -f tmpPiggy existingPatch newPatch
elif [ $1 == "--apply" ]; then
  PERFORM_DIFF="patches/${BUILDROOT}-scc.patch"
elif [ "$1" == "" ] || echo $1 | grep -q '^-'; then
  echo "Usage: $0 [options] "
  echo "       $0 file"
  echo ""
  echo "Options:"
  echo "--diff    Show the differences between the buildroot folder and the"
  echo "          patch-file \"patches/${BUILDROOT}-scc.patch\""
  echo "--apply   Apply all changes in the buildroot folder to the patch-file"
  echo "          \"patches/${BUILDROOT}-scc.patch\". Use --diff option to"
  echo "          find out what changes have been made..."
  echo "-h/--help Show this help text..."
  echo ""
  echo "If no options are given, you may provide a filename. The new buidroot"
  echo "patchfile will be created (compared to buildroot-${BUILDROOT_VERSION}.orig)"
  echo "and stored under the give filename."
else
  PERFORM_DIFF="$1"
fi

if [ "$PERFORM_DIFF" != "" ]; then
  # Identified with: diff -urN ${BUILDROOT}.orig ${BUILDROOT} || grep "^diff"
  # Only works before building something in the buildroot folder (invoking make)
  echo "Writing patch file \"$PERFORM_DIFF\"..."
  diff -urN ${BUILDROOT}.orig/bin2obj/bin2obj.c ${BUILDROOT}/bin2obj/bin2obj.c > $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/bin2obj/Makefile ${BUILDROOT}/bin2obj/Makefile >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/busybox-1.18.4.config ${BUILDROOT}/board/intel/scc/busybox-1.18.4.config >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/Config.in ${BUILDROOT}/board/intel/scc/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/crosstool-ng.config ${BUILDROOT}/board/intel/scc/crosstool-ng.config >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/device_table.txt ${BUILDROOT}/board/intel/scc/device_table.txt >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/linux-3.1.4.config ${BUILDROOT}/board/intel/scc/linux-3.1.4.config >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/Makefile.in ${BUILDROOT}/board/intel/scc/Makefile.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/banner ${BUILDROOT}/board/intel/scc/target_skeleton/etc/banner >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/br-version ${BUILDROOT}/board/intel/scc/target_skeleton/etc/br-version >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/fstab ${BUILDROOT}/board/intel/scc/target_skeleton/etc/fstab >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/group ${BUILDROOT}/board/intel/scc/target_skeleton/etc/group >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/hostname ${BUILDROOT}/board/intel/scc/target_skeleton/etc/hostname >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/hosts ${BUILDROOT}/board/intel/scc/target_skeleton/etc/hosts >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/rcS ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/rcS >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S01hotplug ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S01hotplug >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S02hostname ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S02hostname >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S08syslog ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S08syslog >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S09klog ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S09klog >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S20urandom ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S20urandom >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S40network ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S40network >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S41scc-network ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S41scc-network >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S42mount ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S42mount >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S45rhid ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S45rhid >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S55gpm ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S55gpm >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/init.d/S60cpuutil ${BUILDROOT}/board/intel/scc/target_skeleton/etc/init.d/S60cpuutil >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/inittab ${BUILDROOT}/board/intel/scc/target_skeleton/etc/inittab >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/inputrc ${BUILDROOT}/board/intel/scc/target_skeleton/etc/inputrc >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/issue ${BUILDROOT}/board/intel/scc/target_skeleton/etc/issue >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/mdev.conf ${BUILDROOT}/board/intel/scc/target_skeleton/etc/mdev.conf >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/memstat.conf ${BUILDROOT}/board/intel/scc/target_skeleton/etc/memstat.conf >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/mke2fs.conf ${BUILDROOT}/board/intel/scc/target_skeleton/etc/mke2fs.conf >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/network/interfaces ${BUILDROOT}/board/intel/scc/target_skeleton/etc/network/interfaces >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/passwd ${BUILDROOT}/board/intel/scc/target_skeleton/etc/passwd >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/profile ${BUILDROOT}/board/intel/scc/target_skeleton/etc/profile >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/protocols ${BUILDROOT}/board/intel/scc/target_skeleton/etc/protocols >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/resolv.conf ${BUILDROOT}/board/intel/scc/target_skeleton/etc/resolv.conf >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/securetty ${BUILDROOT}/board/intel/scc/target_skeleton/etc/securetty >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/services ${BUILDROOT}/board/intel/scc/target_skeleton/etc/services >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/shadow ${BUILDROOT}/board/intel/scc/target_skeleton/etc/shadow >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_config ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_config >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/sshd_config ${BUILDROOT}/board/intel/scc/target_skeleton/etc/sshd_config >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_host_dsa_key ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_host_dsa_key >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_host_dsa_key.pub ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_host_dsa_key.pub >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_host_ecdsa_key ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_host_ecdsa_key >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_host_ecdsa_key.pub ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_host_ecdsa_key.pub >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_host_key.pub ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_host_key.pub >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_host_rsa_key ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_host_rsa_key >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/ssh_host_rsa_key.pub ${BUILDROOT}/board/intel/scc/target_skeleton/etc/ssh_host_rsa_key.pub >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/etc/TZ ${BUILDROOT}/board/intel/scc/target_skeleton/etc/TZ >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/root/.ashrc ${BUILDROOT}/board/intel/scc/target_skeleton/root/.ashrc >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/root/.ssh/authorized_keys ${BUILDROOT}/board/intel/scc/target_skeleton/root/.ssh/authorized_keys >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/root/.ssh/identity.pub ${BUILDROOT}/board/intel/scc/target_skeleton/root/.ssh/identity.pub >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/root/.ssh/id_rsa ${BUILDROOT}/board/intel/scc/target_skeleton/root/.ssh/id_rsa >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/root/.ssh/known_hosts ${BUILDROOT}/board/intel/scc/target_skeleton/root/.ssh/known_hosts >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/usr/bin/imaze ${BUILDROOT}/board/intel/scc/target_skeleton/usr/bin/imaze >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/board/intel/scc/target_skeleton/usr/bin/sccdsp ${BUILDROOT}/board/intel/scc/target_skeleton/usr/bin/sccdsp >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/boot/Config.in ${BUILDROOT}/boot/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/boot/sccboot/Config.in ${BUILDROOT}/boot/sccboot/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/boot/sccboot/sccboot.mk ${BUILDROOT}/boot/sccboot/sccboot.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/configs/scc_defconfig ${BUILDROOT}/configs/scc_defconfig >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/configs/sccDemo_defconfig ${BUILDROOT}/configs/sccDemo_defconfig >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/fs/Config.in ${BUILDROOT}/fs/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/fs/sccfs/Config.in ${BUILDROOT}/fs/sccfs/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/fs/sccfs/sccfs.mk ${BUILDROOT}/fs/sccfs/sccfs.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/images/commandline.bin ${BUILDROOT}/images/commandline.bin >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/Config.in ${BUILDROOT}/package/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/Config.in.orig ${BUILDROOT}/package/Config.in.orig >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/games/prboom/prboom.mk ${BUILDROOT}/package/games/prboom/prboom.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/links/Config.in ${BUILDROOT}/package/links/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/links/links.mk ${BUILDROOT}/package/links/links.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/multimedia/mplayer/mplayer.mk ${BUILDROOT}/package/multimedia/mplayer/mplayer.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/multimedia/pulseaudio/pulseaudio-1.0-0001-mute.patch ${BUILDROOT}/package/multimedia/pulseaudio/pulseaudio-1.0-0001-mute.patch >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/ncurses/ncurses.mk ${BUILDROOT}/package/ncurses/ncurses.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/Config.in ${BUILDROOT}/package/scc/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/gpm/Config.in ${BUILDROOT}/package/scc/gpm/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/gpm/gpm.mk ${BUILDROOT}/package/scc/gpm/gpm.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/imaze/Config.in ${BUILDROOT}/package/scc/imaze/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/imaze/imaze.mk ${BUILDROOT}/package/scc/imaze/imaze.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/rhid/Config.in ${BUILDROOT}/package/scc/rhid/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/rhid/rhid.mk ${BUILDROOT}/package/scc/rhid/rhid.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/sccapps/Config.in ${BUILDROOT}/package/scc/sccapps/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/sccapps/sccapps.mk ${BUILDROOT}/package/scc/sccapps/sccapps.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/scc.mk ${BUILDROOT}/package/scc/scc.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/usbip/Config.in ${BUILDROOT}/package/scc/usbip/Config.in >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/package/scc/usbip/usbip.mk ${BUILDROOT}/package/scc/usbip/usbip.mk >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/selfboot/fastBoot.mt ${BUILDROOT}/selfboot/fastBoot.mt >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/selfboot/fastBoot.obj ${BUILDROOT}/selfboot/fastBoot.obj >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/selfboot/linux.mt ${BUILDROOT}/selfboot/linux.mt >> $PERFORM_DIFF
  diff -urN ${BUILDROOT}.orig/selfboot/preMergeImage.csh ${BUILDROOT}/selfboot/preMergeImage.csh >> $PERFORM_DIFF
  echo "Done..."
fi
