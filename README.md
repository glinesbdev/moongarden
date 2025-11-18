# Moon Garden

Moon Garden is a development streamlining tool for the [Fennel][1] programming language.\
This tool is aimed to make the general purpose programming experience for Fennel smoother.\
With help from the Fennel compiler, Moon Garden can compile .fnl to .lua files in a given directory as well as watching for file changes.

## Installation

Moon Garden can be downloaded from LuaRocks

```shell
luarocks install moongarden
```

## Usage

```shell
Outputs a structure of folders / files containing .fnl files and outputs the same structure as .lua files

USAGE
  moongarden [--path FILE|DIRECTORY] [--out DIRECTORY] [,--verbose] [,--watch]

VERSION
  0.2.1

FLAGS
  --path        : Relative path of the input files - Default ./src
  --out         : Relative path of the output files - Default ./out
  --verbose     : Shows the build output - Defalt false
  --watch       : Watches for files changes and copies from [path] to [out] - Default false
  -v, --version : Shows the current build version of Moon Garden
  -h, --help    : Show this help text
```

### About --watch

The `--watch` command relies on [entr][2] to watch when the .fnl files change as you save your work. Entr works on UNIX based systems and will need to be installed locally. Moon Garden will tell you if you don't have Entr installed if you try to use the `--watch` flag. You can use [WSL][3] (Windows Subsystem for Linux) when using Windows.

## Dependencies

There are two dependencies that Moon Garden relies on:

* [luafilesystem][5]
* [fennel][6]

The Makefile provides a handy command to install all of the dependencies for development:

```bash
make deps
```

Make sure that you have [luarocks][7] installed first.

## Contributing

1. Fork the repo.
2. Make your changes.
3. Submit a PR!
4. ...profit?

## Having Issues?

[Let me know!][4]

## License

Copyright © 2021-2025 Bradyn Glines

Released under the [MIT license](LICENSE).

## TODO:

- Get file writing tests working

[1]: https://fennel-lang.org
[2]: http://eradman.com/entrproject/
[3]: https://docs.microsoft.com/en-us/windows/wsl/about
[4]: https://github.com/glinesbdev/moongarden/issues/new/choose
[5]: https://luarocks.org/modules/hisham/luafilesystem
[6]: https://luarocks.org/modules/fennel/fennel
[7]: https://github.com/luarocks/luarocks/blob/main/docs/download.md
