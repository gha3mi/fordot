[![GitHub](https://img.shields.io/badge/GitHub-ForDot-blue.svg?style=social&logo=github)](https://github.com/gha3mi/fordot)
[![Version](https://img.shields.io/github/release/gha3mi/fordot.svg)](https://github.com/gha3mi/fordot/releases/latest)
[![Documentation](https://img.shields.io/badge/ford-Documentation%20-blueviolet.svg)](https://gha3mi.github.io/fordot/)
[![License](https://img.shields.io/github/license/gha3mi/fordot?color=green)](https://github.com/gha3mi/fordot/blob/main/LICENSE)
[![Build](https://github.com/gha3mi/fordot/actions/workflows/CI_test.yml/badge.svg)](https://github.com/gha3mi/fordot/actions/workflows/CI_test.yml)


**ForDot**: A Fortran library that overloads the `dot` function to enable efficient dot product with/without coarray.

## Usage

```fortran
use fordot

a = dot_product(u,v,'coarray','m1')
```

## fpm dependency

If you want to use `ForDot` as a dependency in your own fpm project,
you can easily include it by adding the following line to your `fpm.toml` file:

```toml
[dependencies]
fordot = {git="https://github.com/gha3mi/fordot.git"}
```

## Benchmarks
You can find benchmark results on [ForBenchmark](https://github.com/gha3mi/forbenchmark/tree/main/benchmarks/dot).

## API documentation

The most up-to-date API documentation for the master branch is available
[here](https://gha3mi.github.io/fordot/).
To generate the API documentation for `ForDot` using
[ford](https://github.com/Fortran-FOSS-Programmers/ford) run the following
command:

```shell
ford ford.yml
```

## Contributing

Contributions to `ForDot` are welcome!
If you find any issues or would like to suggest improvements, please open an issue.
