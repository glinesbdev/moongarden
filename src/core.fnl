(local fennel (require :fennel))
(local lfs (require :lfs))

(local separator (package.config:sub 1 1))

(local help "
Usage: moongarden [--path FILE|DIRECTORY] [--out DIRECTORY] [,--verbose] [,--watch]

Outputs a structure of folders / files containing .fnl files and outputs the same structure as .lua files

FLAGS
  --path      : Relative path of the input files - Default ./src
  --out       : Relative path of the output files - Default ./out
  --verbose   : Shows the build output - Defalt false
  --watch     : Watches for files changes and copies from [path] to [out] - Default false
  --version   : Shows the current build version of Moon Garden
  -h, --help  : Show this help text")

(local options {})
(local default-path (.. "." separator :src))
(local default-out (.. "." separator :out))

(local options {:path (.. "." separator :src)
                :out (.. "." separator :out)
                :verbose false
                :watch false
                :watch-active false})

(fn replace-ext [file]
  (string.gsub file :.fnl :.lua))

(fn create-out-dir []
  "Checks if output directory exists. If not, create it."
  ;; Using os.rename since it'll return an error if it doesn't exist
  (let [(ok err code) (os.rename options.out options.out)]
    (when err
      (lfs.mkdir options.out))))

(fn write-file [file-path out-path text]
  "Write the .lua file to the output path"
  (let [out-file (replace-ext out-path)
        f (assert (io.open out-file :w+))]
    (f:write text)
    (when options.verbose
      (print (.. "Writing file: " out-file)))
    (f:close)))

(fn compile [file-path out-path]
  "Compile the .fnl file to a .lua file"
  (let [f (assert (io.open file-path :r))
        text (fennel.compile-string (f:read :*all))]
    (if options.watch-active
        (let [last-changed (. (lfs.attributes file-path) :change)]
          (when (>= last-changed (os.time))
            (write-file file-path out-path text)))
        (write-file file-path out-path text))
    (f:close)))

(fn walk-files [path]
  "Walk each folder for all .fnl files in the [path] and compile it to .lua"
  (create-out-dir)
  (each [dir (lfs.dir path)]
    (let [dir-path (.. path separator dir)
          dir-mode (. (lfs.attributes dir-path) :mode)
          out-path (string.gsub dir-path (.. "(" options.path ")") options.out)]
      (if (= dir-mode :file)
          (let [(suc err) (pcall compile dir-path out-path)]
            (when (not suc)
              (print (.. "Moongarden error report " dir-path "\n" (string.sub err 9 (# err))))))
          (and (= dir-mode :directory) (not (or (= "." dir) (= ".." dir)))) (do
                                                                              (lfs.mkdir out-path)
                                                                              (walk-files dir-path))))))

(fn watch-files []
  "Watch the .fnl files in the [path] and output .lua files to [out] when they change"
  (let [cmd (.. (string.format "find %s/ -name '*.fnl' | entr -np moongarden --path %s --out %s -wa "
                               options.path options.path options.out)
                (if options.verbose :--verbose ""))]
    (os.execute cmd)))

;; -wa is not public API and moongarden will behave strangely so DON'T USE IT! ...thanks
(for [i (length arg) 1 -1]
  (match (. arg i)
    :--path (set options.path (. arg (+ i 1)))
    :--out (set options.out (. arg (+ i 1)))
    :--verbose (set options.verbose true)
    :--watch (set options.watch true)
    :--version (do
                 (print (string.format "Moon Garden %s\n%s" :0.1.1 _VERSION))
                 (os.exit 0))
    :--help (do
              (print help)
              (os.exit 0))
    :-h (do
          (print help)
          (os.exit 0))
    :-wa (set options.watch-active true)))

(if options.watch
    (watch-files)
    (walk-files options.path))

