# pushrm

[![Current Tag](https://img.shields.io/github/v/tag/actionhippie/pushrm?sort=semver)](https://github.com/actionhippie/pushrm) [![Docker Build](https://github.com/actionhippie/pushrm/workflows/docker/badge.svg)](https://github.com/actionhippie/pushrm/actions?query=workflow%3Adocker)

[GitHub Action](https://github.com/features/actions) to push a README to DockerHub, Quay or Harbor.

## Usage

```yml
name: Example

on:
  - push
  - pull_request

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - uses: actionhippie/pushrm@v1
        with:
          provider: dockerhub
          target: webhippie/alpine
          description: Docker image for Alpine
          username: octocat
          password: p455w0rd
```

## Inputs

### username

Username for DockerHub or Harbor

### password

Password for DockerHub or Harbor

### apikey

API key only used for Quay.io

### provider

Used provider like dockerhub, harbor or quay

### description

Short description to be set on the registry

### readme

Path to another README like README.container.md

### target

Target image to write the README to

## Outputs

None

## Security

If you find a security issue please contact thomas@webhippie.de first.

## Contributing

Fork -> Patch -> Push -> Pull Request

## Authors

* [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2021 Thomas Boerger <thomas@webhippie.de>
```
