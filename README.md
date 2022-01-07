# Spack Install Action
Downloads and installs [spack](https://spack.readthedocs.io/en/latest/) along with any package specified into the GitHub runner. 

## Using
```yaml
jobs:
    example:
    runs-on: ubuntu-latest
    steps:
    - name: Install Spack
      uses: kzscisoft/install-spack@v1

    - name: Use spack
      run: spack --version 
```

## Options
|**Option**|**Description**|**Default**|
|---|---|---|
|`version`|[Spack repository](https://github.com/spack/spack) tag/reference to use for install|Latest tagged release|
|`packages`|Packages to install with Spack (see below)|None|

## Installing Spack Packages
You can specify packages to install on setup:
```yaml
jobs:
    example:
    runs-on: ubuntu-latest
    steps:
    - name: Install Spack
      uses: kzscisoft/install-spack@v1
      with:
        packages: |
            zlib
            grep
```
