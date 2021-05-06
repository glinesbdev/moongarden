# Moon Garden

Moon Garden is a helper tool used for the [Fennel][1] programming language. This tool is aimed to make the general purpose programming experience for Fennel more smooth and easier to use.

```shell
Moon Garden v0.0.1

Usage: moongarden [[--path [FILE|DIRECTORY]] [--out [DIRECTORY]] [,--verbose]]

Outputs a structure of folders / files containing .fnl files and outputs the same structure as .lua files

FLAGS
  --path      : Relative path of the input files - Default ./src
  --out       : Relative path of the output files - Default ./out
  --format    : Formats the Lua files using LuaFormatter - Defalt true
  --verbose   : Shows the build output - Defalt false
  -h, --help  : Show this help text
```

## License

Copyright © 2021-2021 Bradyn Glines

Released under the [MIT license](LICENSE).

## Contributing

1. Fork the repo.
2. Make your changes.
3. Submit a PR!
4. ...profit?

[1]: https://fennel-lang.org

## TODO:

- Get file writing tests working
- Implement a file watcher
