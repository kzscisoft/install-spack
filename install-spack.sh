#!/usr/bin/bash
set -e

CURWD=$PWD
PACKAGES=$@

echo "::group::Install Spack"
echo "::notice title=Data Store::Installing Spack to: ${SPACK_SRC_DIR}"
git clone -c feature.manyFiles=true https://github.com/spack/spack.git ${SPACK_SRC_DIR}

cd ${SPACK_SRC_DIR}

if [ "${SPACK_REF}" == "latest" ]; then
    SPACK_REF=$(git describe --tags --abbrev=0)
fi

echo "::notice title=Data Store::Checking out version: ${SPACK_REF}"
git checkout ${SPACK_REF}

cd ${CURWD}
echo "::endgroup::"

if [ "$#" -ne 0 ]; then
    if [ "${SPACK_ENV_DIR}" == "none" ]; then
        SPACK_ENV_DIR=$GITHUB_WORKSPACE/spack_env
    fi
    echo "::group::Installing Package"
    echo "::notice title=Environment::Creating spack environment in: ${SPACK_ENV_DIR}"
    $SPACK_SRC_DIR/bin/spack env create -d $SPACK_ENV_DIR
    $SPACK_SRC_DIR/bin/spack env activate -d $SPACK_ENV_DIR
    for package in "$@"
    do
        $SPACK_SRC_DIR/bin/spack install $package
    done
elif [ "${SPACK_ENV_DIR}" != "none" ]; then
    echo "::notice title=Environment::Using spack environment in: ${SPACK_ENV_DIR}"
    $SPACK_SRC_DIR/bin/spack env activate -d 
    $SPACK_ENV_DIR/bin/spack install
fi


