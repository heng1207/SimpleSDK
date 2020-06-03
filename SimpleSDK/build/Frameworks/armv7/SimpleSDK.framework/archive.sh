#!/bin/sh

clear

function showMsg()
{
  echo -e "\033[32m$1\033[0m"
}

lstRepo=(
  SimpleSDK
)
for repo in ${lstRepo[@]}
do
  cd ../$repo
  showMsg '开始git pull '$repo
  git pull
done



set -e
set +u
### Avoid recursively calling this script.
if [[ $UF_MASTER_SCRIPT_RUNNING ]]
then
exit 0
fi
set -u
export UF_MASTER_SCRIPT_RUNNING=1
### Constants.
PROJECT_NAME=$1
CONFIGURATION=Release
BUILD_DIR=build
BUILD_ROOT=build
TARGET_NAME=$1
PROJECT_FILE_PATH=${PROJECT_NAME}.xcodeproj
UF_TARGET_NAME=${PROJECT_NAME}
FRAMEWORK_VERSION="A"
UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal
IPHONE_DEVICE_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos
IPHONE_SIMULATOR_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator
RELEASE_FRAMEWORKS=${BUILD_DIR}/Frameworks
#OTHER_CFLAGS=
OTHER_CFLAGS=-fembed-bitcode

### Functions
## List files in the specified directory, storing to the specified array.
#
# @param $1 The path to list
# @param $2 The name of the array to fill
#
##
list_files ()
{
  filelist=$(ls "$1")
  while read line
  do
    eval "$2[\${#$2[*]}]=\"\$line\""
  done <<< "$filelist"
}

rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
mkdir -p ${RELEASE_FRAMEWORKS}

### Build simulator platform. (i386, x86_64)
echo "========== Build Simulator Platform =========="
echo "===== Build Simulator Platform: i386 ====="
xcodebuild OTHER_CFLAGS="$OTHER_CFLAGS" -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIMULATOR_BUILD_DIR}/i386"   ARCHS='i386' VALID_ARCHS='i386'
mkdir -p ${RELEASE_FRAMEWORKS}/i386 && cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/i386/${PROJECT_NAME}.framework" ${RELEASE_FRAMEWORKS}/i386

echo "===== Build Simulator Platform: x86_64 ====="
xcodebuild OTHER_CFLAGS="$OTHER_CFLAGS" -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIMULATOR_BUILD_DIR}/x86_64" ARCHS='x86_64' VALID_ARCHS='x86_64'
mkdir -p ${RELEASE_FRAMEWORKS}/x86_64  && cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/x86_64/${PROJECT_NAME}.framework" ${RELEASE_FRAMEWORKS}/x86_64

### Build device platform. (armv7, arm64)
echo "========== Build Device Platform =========="
echo "===== Build Device Platform: armv7 ====="
xcodebuild OTHER_CFLAGS="$OTHER_CFLAGS" -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"  CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/armv7"  ARCHS='armv7' VALID_ARCHS='armv7'
mkdir -p ${RELEASE_FRAMEWORKS}/armv7   && cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/armv7/${PROJECT_NAME}.framework" ${RELEASE_FRAMEWORKS}/armv7
xcodebuild OTHER_CFLAGS="$OTHER_CFLAGS" -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"  CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/armv7s" ARCHS='armv7s' VALID_ARCHS='armv7s'
mkdir -p ${RELEASE_FRAMEWORKS}/armv7s   && cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/armv7s/${PROJECT_NAME}.framework" ${RELEASE_FRAMEWORKS}/armv7s
echo "===== Build Device Platform: arm64 ====="
xcodebuild OTHER_CFLAGS="$OTHER_CFLAGS" -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/arm64"   ARCHS='arm64' VALID_ARCHS='arm64'
mkdir -p ${RELEASE_FRAMEWORKS}/arm64 && cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/arm64/${PROJECT_NAME}.framework" ${RELEASE_FRAMEWORKS}/arm64
### Build device platform. (arm64, armv7)
echo "========== Build Universal Platform =========="
## Copy the framework structure to the universal folder (clean it first).
rm -rf "${UNIVERSAL_OUTPUTFOLDER}"
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"
## Copy the last product files of xcodebuild command.
cp -R "${IPHONE_DEVICE_BUILD_DIR}/arm64/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework"


lipo -create  "${RELEASE_FRAMEWORKS}/i386/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
              "${RELEASE_FRAMEWORKS}/x86_64/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
              "${RELEASE_FRAMEWORKS}/armv7/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
              "${RELEASE_FRAMEWORKS}/armv7s/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
              "${RELEASE_FRAMEWORKS}/arm64/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
              -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}"
