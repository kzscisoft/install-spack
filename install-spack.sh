#!/usr/bin/bash
set -e

CURWD=$PWD

echo "::group::Install FAIR-CLI"
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
