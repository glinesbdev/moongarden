package = "moongarden"
version = "dev-1"
source = {
   url = "git+https://github.com/glinesbdev/moongarden.git",
   tag = "0.0.1"
}
description = {
   summary = "Moon Garden is a helper tool used for the Fennel programming language.",
   detailed = [[
      Moon Garden is a helper tool used for the Fennel programming language.
      This tool is aimed to make the general purpose programming experience for Fennel more smooth and easier to use.]],
   homepage = "https://github.com/glinesbdev/moongarden",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1",
   "lfs >= 1.0, < 2.0"
}
build = {
   type = "builtin",
   modules = {
      fennel = "src/fennel.lua"
   },
   install = {
      bin = {
         fennel = "bin/fennel"
      }
   }
}
