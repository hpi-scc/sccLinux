#!/bin/bash

VERSION=2011.11

BUILDROOT=buildroot-${VERSION}
BUILDROOT_FILE=${BUILDROOT}.tar.bz2
PATCH_FILE=${BUILDROOT}-scc.patch

# "Source" sccApps
ln -fs ../sccApps apps

# Download
if [ ! -f $BUILDROOT_FILE ]; then
	echo "Downloading ${BUILDROOT_FILE}"
	wget http://buildroot.uclibc.org/downloads/${BUILDROOT_FILE}
fi

# Extract
echo "Extracting..."
tar xf ${BUILDROOT_FILE}
cp -R ${BUILDROOT} ${BUILDROOT}.orig

echo "Applying patch file ${PATCH_FILE}"
patch -d ${BUILDROOT} -p1 < patches/${PATCH_FILE}

echo "Copying binary files..."
cp -a target_skeleton ${BUILDROOT}/board/intel/scc >& /dev/null
find  ${BUILDROOT}/board/intel/scc/target_skeleton -name ".svn" -exec rm -rf {} \; >& /dev/null

echo "Copying applications..."
mkdir -p ${BUILDROOT}/dl
cp -a apps/* ${BUILDROOT}/dl

echo "Done."
