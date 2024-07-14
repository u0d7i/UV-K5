#!/bin/bash
#
set -e
echo "+ geting url ..."
UR=$(curl -sSf "https://archive.chirpmyradio.com/download?stream=next" | grep -Eo "\"https://\S+?\"" | sed 's/"//g')
echo "+ getting filename..."
FL=$(curl -sSf "${UR}/" | grep -Eo "\"\S+?none-any.whl\"" | sed 's/"//g')
echo "+ downloading ${FL} ..."
curl -sSfO "${UR}/${FL}"
echo "+ installing deps..."
sudo apt install -y python3-wxgtk4.0 pipx
echo "+ removing old version if any..."
pipx uninstall chirp || true
echo "+ installing ${FL} ..."
pipx install --system-site-packages ./${FL}
echo "+ cleanup..."
rm -f ${FL}
 ~/.local/bin/chirp --version
