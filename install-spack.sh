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

. $SPACK_SRC_DIR/share/spack/setup-env.sh

echo "::set-output name=version::$(spack --version)"

if [ "$#" -ne 0 ]; then
    echo "::group::Installing Packages"
    for package in "$@"
    do
        echo "::notice title=Install Package::Installing package $package"
        spack install $package
    done
fi

echo "::group::Spack Export"
echo "::notice title=Updating PATH::Adding '$SPACK_SRC_DIR/bin' to \$PATH in \$GITHUB_ENV"
echo "PATH=$PATH" >> $GITHUB_ENV
echo "$SPACK_SRC_DIR/bin" >> $GITHUB_PATH
echo "::endgroup::"