#!/usr/bin/env sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEVICES="titan"
BRANCH_NAME="lineage-16.0"

docker pull lineageos4microg/docker-lineage-cicd

docker run \
    --name=lineage-$(date +%Y%m%d_%H%M) \
    --rm \
    -it \
    -e "USER_NAME=GRBurst" \
    -e "USER_MAIL=GRBurst@protonmail.com" \
    -e "WITH_SU=false" \
    -e "RELEASE_TYPE=microG" \
    -e "CCACHE_SIZE=100G" \
    -e "DEVICE_LIST=${DEVICES}" \
    -e "BRANCH_NAME=${BRANCH_NAME}" \
    -e "OTA_URL=https://api.lineage.microg.org" \
    -e "CRONTAB_TIME=now" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "CUSTOM_PACKAGES=GmsCore GsfProxy FakeStore FDroid FDroidPrivilegedExtension MozillaNlpBackend NominatimNlpBackend OpenWeatherMapWeatherProvider additional_repos com.google.android.maps.jar RemoteDroidGuard AuroraStore bromite-webview privacy-friendly-netmonitor" \
    -e "SIGN_BUILDS=true" \
    -e "CLEAN_OUTDIR=false" \
    -e "CLEAN_AFTER_BUILD=true" \
    -e "ZIP_SUBDIR=true" \
    -e "LOGS_SUBDIR=true" \
    -e "DELETE_OLD_ZIPS=3" \
    -e "DELETE_OLD_LOGS=3" \
    -e "INCLUDE_PROPRIETARY=true" \
    -v "${DIR}/work/lineage:/srv/src" \
    -v "${DIR}/work/zips:/srv/zips" \
    -v "${DIR}/work/logs:/srv/logs" \
    -v "${DIR}/work/cache:/srv/ccache" \
    -v "${DIR}/local_manifests:/srv/local_manifests" \
    -v "${DIR}/../.android-certs:/srv/keys" \
    -v "${DIR}/scripts:/srv/userscripts" \
lineageos4microg/docker-lineage-cicd
