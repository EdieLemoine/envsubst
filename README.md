# envsubst

[![Build status][workflow-image]][workflow-url]
[![GoDoc][godoc-img]][godoc-url]
[![License][license-image]][license-url]
[![Github All Releases][releases-image]][releases]
[![GitHub release (latest SemVer)][latest-release-image]][releases]

Envsubst which supports [parameter substution and expansion][parameter-substitution-and-expansion]. Built for ARM and AMD architectures.

## Installation

### From binaries

Latest stable `envsubst` [prebuilt binaries for 64-bit Linux, or MacOS][releases]
are available via GitHub releases.

### Linux and MacOS

#### Using install script

```shell
sh <(curl "https://raw.githubusercontent.com/EdieLemoine/envsubst/main/install.sh") v1.4.0
```

This will download the given release for your current OS and architecture, untar it, make it executable and move it to `/usr/local/bin/envsubst`.

To choose another destination, pass it as the second argument.

```shell
sh <(curl "https://raw.githubusercontent.com/EdieLemoine/envsubst/main/install.sh") v1.4.0 /path/to/envsubst
```

#### Manually

With `uname`

```shell
curl -L https://github.com/EdieLemoine/envsubst/releases/download/v1.4.0/envsubst-v1.4.0-`uname -s`-`uname -m` -o envsubst
chmod +x envsubst
sudo mv envsubst /usr/local/bin
```

> Note: This is why the install script was created: On Linux, running `uname -m`
> on arm64 architecture will return 'aarch64', which will not work. The install
> script transforms this to 'arm64'.

Without `uname`

```shell
curl -L https://github.com/EdieLemoine/envsubst/releases/download/v1.4.0/envsubst-v1.4.0-linux-arm64 -o envsubst
chmod +x envsubst
sudo mv envsubst /usr/local/bin
```

### Windows

Download the latest prebuilt binary from [releases page][releases], or if you
have curl installed:

```console
curl -L https://github.com/EdieLemoine/envsubst/releases/download/v1.4.0/envsubst.exe
```

### With go

You can install via `go get` (provided you have installed go):

```console
go get github.com/EdieLemoine/envsubst/cmd/envsubst
```

## Using via cli

```sh
envsubst < input.tmpl > output.text
echo 'welcome $HOME ${USER:=a8m}' | envsubst
envsubst -help
```

## Imposing restrictions

There are three command line flags with which you can cause the substitution to
stop with an error code, should the restriction associated with the flag not be
met. This can be handy if you want to avoid creating e.g. configuration files
with unset or empty parameters.

Setting a `-fail-fast` flag in conjunction with either no-unset or no-empty or
both will result in a faster feedback loop, this can be especially useful when
running through a large file or byte array input, otherwise a list of errors is
returned.

The flags and their restrictions are:

| __Option__   | __Meaning__                                                                                                      | __Type__              | __Default__ |
|--------------|------------------------------------------------------------------------------------------------------------------|-----------------------|-------------|
| `-i`         | input file                                                                                                       | ```string / stdin```  | `stdin`     |
| `-o`         | output file                                                                                                      | ```string / stdout``` | `stdout`    |
| `-no-unset`  | fail if a variable is not set                                                                                    | `flag`                | `false`     |
| `-no-empty`  | fail if a variable is set but empty                                                                              | `flag`                | `false`     |
| `-fail-fast` | fails at first occurence of an error, if `-no-empty` or `-no-unset` flags were **not** specified this is ignored | `flag`                | `false`     |

These flags can be combined to form tighter restrictions.

#### Using `envsubst` programmatically ?

You can take a look
on [`_example/main`](https://github.com/EdieLemoine/envsubst/blob/master/_example/main.go)
or see the example below.

```go
package main

import (
	"fmt"
	"github.com/EdieLemoine/envsubst"
)

func main() {
    input := "welcom $HOME"
    str, err := envsubst.String(input)
    // ...
    buf, err := envsubst.Bytes([]byte(input))
    // ...
    buf, err := envsubst.ReadFile("filename")
}
```

## Docs

> api docs here: [![GoDoc][godoc-img]][godoc-url]

| __Expression__     | __Meaning__                                                          |
|--------------------|----------------------------------------------------------------------|
| `${var}`           | Value of var (same as `$var`)                                        |
| `${var-$DEFAULT}`  | If var not set, evaluate expression as $DEFAULT                      |
| `${var:-$DEFAULT}` | If var not set or is empty, evaluate expression as $DEFAULT          |
| `${var=$DEFAULT}`  | If var not set, evaluate expression as $DEFAULT                      |
| `${var:=$DEFAULT}` | If var not set or is empty, evaluate expression as $DEFAULT          |
| `${var+$OTHER}`    | If var set, evaluate expression as $OTHER, otherwise as empty string |
| `${var:+$OTHER}`   | If var set, evaluate expression as $OTHER, otherwise as empty string |
| `$$var`            | Escape expressions. Result will be `$var`.                           |

<sub>Most of the rows in this table were taken
from [here][parameter-substitution-and-expansion]</sub>

## See also

* `os.ExpandEnv(s string) string` - only supports `$var` and `${var}` notations

### License

MIT

## Contributing

This was originally made by [a8m](https://github.com/a8m). I just forked it to add arm64 binaries. I'm willing to maintain this, though, so pull requests are welcome.

[godoc-img]: https://img.shields.io/badge/godoc-reference-blue.svg?style=for-the-badge
[godoc-url]: https://godoc.org/github.com/EdieLemoine/envsubst
[license-image]: https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge
[license-url]: LICENSE
[releases-image]: https://img.shields.io/github/downloads/EdieLemoine/envsubst/total.svg?style=for-the-badge
[releases]: https://github.com/EdieLemoine/envsubst/releases
[workflow-image]: https://img.shields.io/github/workflow/status/edielemoine/envsubst/Release?style=for-the-badge
[workflow-url]: https://github.com/EdieLemoine/envsubst/actions/workflows/release.yml
[parameter-substitution-and-expansion]: https://tldp.org/LDP/abs/html/refcards.html#AEN22728
[latest-release-image]: https://img.shields.io/github/v/release/edielemoine/envsubst?style=for-the-badge
