#!/bin/bash

BUILDROOT_VERSION=2011.11

BUILDROOT=buildroot-${BUILDROOT_VERSION}
BUILDROOT_FILE=${BUILDROOT}.tar.bz2
BUILDROOT_PATCH=${BUILDROOT}-scc.patch

if [ $1 == "--diff" ]; then
  echo Finding out changes compared to existing patch!
  cat patches/buildroot-2011.11-scc.patch | grep -v '^+++' | grep -v '^---' > existingPatch
  createBuildrootPatch.sh tmpPiggy
  cat tmpPiggy | grep -v '^+++' | grep -v '^---' > newPatch
  tkdiff existingPatch newPatch
  rm -f tmpPiggy existingPatch newPatch
elif [ $1 == "--apply" ]; then
  echo "Writing patch file \"patches/${BUILDROOT}-scc.patch\"..."
  echo "=> During the process you'll get 6 errors about missing files in"
  echo "   \"${BUILDROOT}*/fs/skeleton\" which are okay..."
  diff -urN ${BUILDROOT}.orig ${BUILDROOT} > patches/${BUILDROOT}-scc.patch
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
  echo "Writing patch file \"$1\"..."
  echo "=> During the process you'll get 6 errors about missing files in"
  echo "   \"${BUILDROOT}*/fs/skeleton\" which are okay..."
 diff -urN ${BUILDROOT}.orig ${BUILDROOT} > $1 
fi
