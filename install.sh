#!/bin/sh

version="${1}"

if [ -z $version -o $version -eq '-h' -o $version -eq '--help' ]; then
  echo 'Usage: install.sh <version="latest"> <output="/usr/local/bin/envsubst">'

  echo 'Examples: install.sh v1.4.1'
  echo '          install.sh v1.4.1 /usr/bin/envsubst'

  exit 1
fi

os=$(uname -s)
output=${2:-/usr/local/bin/envsubst}
arch=$(uname -m)

case "${arch}" in
  x86_64) arch="amd64" ;;
  aarch64) arch="arm64" ;;
esac

curl -f -L "https://github.com/EdieLemoine/envsubst/releases/download/${version}/envsubst-${version}-${os}-${arch}.tar.gz" | tar -xz

chmod +x envsubst
mv envsubst "${output}"
