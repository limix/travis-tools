# travis-tools

Test, build, and deploy Linux and OSX wheels for Python packages.

## Usage

Your file .travis.yml will have

```
language: python
sudo: required
dist: trusty
services: docker
git:
  depth: 5
cache:
  pip: true
  directories:
  - "$HOME/bin"
  - "$HOME/.download"
matrix:
  include:
  - python: 2.7
  - python: 3.5
  - python: 3.6
  - env: DOCKER_IMAGE=quay.io/pypa/manylinux1_x86_64
  - os: osx
    language: generic
    env: PYENV=py27
  - os: osx
    language: generic
    env: PYENV=py35
  - os: osx
    language: generic
    env: PYENV=py36
before_install:
- travis_retry bash <(curl -s https://raw.githubusercontent.com/limix/travis-tools/master/get-travis-tools.sh)
- travis_retry travis/before-install.sh
script:
- travis_retry travis/script.sh
after_success:
- travis_retry travis/after-success.sh
notifications:
  email: false
```

## Authors

* **Danilo Horta** - [https://github.com/Horta](https://github.com/Horta)

## License

This project is licensed under the MIT License - see the
[LICENSE](LICENSE) file for details
