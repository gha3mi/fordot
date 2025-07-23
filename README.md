[![DOI](https://zenodo.org/badge/732658661.svg)](https://zenodo.org/doi/10.5281/zenodo.10594970)
[![GitHub](https://img.shields.io/badge/GitHub-ForDot-blue.svg?style=social&logo=github)](https://github.com/gha3mi/fordot)
[![Version](https://img.shields.io/github/release/gha3mi/fordot.svg)](https://github.com/gha3mi/fordot/releases/latest)
[![Documentation](https://img.shields.io/badge/ford-Documentation%20-blueviolet.svg)](https://gha3mi.github.io/fordot/)
[![License](https://img.shields.io/github/license/gha3mi/fordot?color=green)](https://github.com/gha3mi/fordot/blob/main/LICENSE)
[![Build](https://github.com/gha3mi/fordot/actions/workflows/CI_test.yml/badge.svg)](https://github.com/gha3mi/fordot/actions/workflows/CI_test.yml)


**ForDot**: A Fortran library that overloads the `dot_product` function to enable efficient dot product with/without coarray.

## Usage

```fortran
use fordot

a = dot_product(u,v,coarray,option,nblock)
```

- `coarray` is an optional logical variable. Set it to `.true.` and use the `-DUSE_COARRAY` flag to enable coarray.
- `nblock` is an optional integer variable.
- `options` is an optional character variable. Available options are `'m1'` to `'m4'`, and the default option is `'m2'`.

- **Note**: Use the flag `-DUSE_DO_CONCURRENT` to enable do concurrent.

## Requirements

- A Fortran Compiler
- BLAS Library
- Fortran Package Manager (fpm)

## fpm Dependency

If you want to use `ForDot` as a dependency in your own fpm project,
you can easily include it by adding the following line to your `fpm.toml` file:

```toml
[dependencies]
fordot = {git="https://github.com/gha3mi/fordot.git"}
```

## Runing Tests

Execute the following commands to run tests with specific compilers:

```shell
fpm @<compiler>-test
```
`compiler: ifx, ifort, gfortran, nvfortran`

For coarray testing use:

```shell
fpm @<compiler>-test-coarray
```
`compiler: ifx, ifort`

All compiler options are accessible in the fpm response file `fpm.rsp`.

## Benchmarks
You can find benchmark results on [ForBenchmark](https://github.com/gha3mi/forbenchmark/tree/main/benchmarks/dot).

## API Documentation

The most up-to-date API documentation for the master branch is available
[here](https://gha3mi.github.io/fordot/).
To generate the API documentation for `ForDot` using
[ford](https://github.com/Fortran-FOSS-Programmers/ford) run the following
command:

```shell
ford README.md
```

## Contributing

Contributions to `ForDot` are welcome!
If you find any issues or would like to suggest improvements, please open an issue.

## Citation

If you use `ForDot` in your work, please cite it using the following DOI:

```
@software{ghasemi_2024_10594971,
  author       = {Ghasemi, Seyed Ali},
  title        = {gha3mi/fordot: v0.1.0},
  month        = jan,
  year         = 2024,
  publisher    = {Zenodo},
  version      = {v0.1.0},
  doi          = {10.5281/zenodo.10594971},
  url          = {https://doi.org/10.5281/zenodo.10594971}
}
```