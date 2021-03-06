#!/usr/bin/env bash
# bin/compile <build-dir> <cache-dir>

echo "-----> Applying whtmltopdf"
BIN_PATH="$BUILD_DIR/bin"
TMP_PATH="$BUILD_DIR/tmp"
mkdir -p $CACHE_DIR $BIN_PATH $TMP_PATH


#WKHTMLTOPDF_URL="http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
# WKHTMLTOPDF_PKG="$CACHE_DIR/wkhtmltopdf.deb"
WKHTMLTOPDF_PKG="$CACHE_DIR/wkhtmltopdf.tar.xz"
WKHTMLTOPDF_PATH="$TMP_PATH/wkhtmltopdf"
# WKHTMLTOPDF_BINARIES="$WKHTMLTOPDF_PATH/usr/local/bin"
WKHTMLTOPDF_BINARIES="$WKHTMLTOPDF_PATH/wkhtmltox/bin"

# cp -p $BP_DIR/user/src/pdf/wkhtmltopdf.deb $WKHTMLTOPDF_PKG
cp -p $BP_DIR/user/src/pdf/wkhtmltopdf.tar.xz $WKHTMLTOPDF_PKG
FONTS_DIR=$(cd "$BP_DIR/user/src/pdf/fonts"; pwd)

#if [ -f $WKHTMLTOPDF_PKG ]; then
#  echo "-----> Using wkhtmltopdf Debian package from cache"
#else
#  echo "-----> Downloading wkhtmltopdf Debian package"
#  curl -L $WKHTMLTOPDF_URL -o $WKHTMLTOPDF_PKG
#fi
echo "       - Create folder and suce ma bite"
mkdir -p $WKHTMLTOPDF_PATH

echo "       - Unzip package..."
# dpkg -x $WKHTMLTOPDF_PKG $WKHTMLTOPDF_PATH
tar xpvf $WKHTMLTOPDF_PKG -C $WKHTMLTOPDF_PATH

echo "       - Setting permissions, dude"
chmod +x $WKHTMLTOPDF_BINARIES/*

echo "       - Moving binaries to the right place, my friend"
mv $WKHTMLTOPDF_BINARIES/* $BIN_PATH/

echo "       - Cleaning up !!!"
rm -rf $WKHTMLTOPDF_PATH

echo "       - Installing fonts...feeeeww"
mkdir -p $1/.fonts
ls $FONTS_DIR
cp $FONTS_DIR/* $1/.fonts/
fc-cache -f $1/.fonts
echo "       Done Biatch!"