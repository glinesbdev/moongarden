(local fennel (require :fennel))
(local lfs (require :lfs))

(local separator (package.config:sub 1 1))

(fn version []
  (let [f (assert (io.open (.. (lfs.currentdir) separator :.version) :r))]
    (f:read :*all)))

(local help (string.format "
Moon Garden v%s
Usage: moongarden [[--path [FILE|DIRECTORY]] [--out [DIRECTORY]] [,--verbose]]

Outputs a structure of folders / files containing .fnl files and outputs the same structure as .lua files

FLAGS
  --path      : Relative path of the input files - Default ./src
  --out       : Relative path of the output files - Default ./out
  --verbose   : Shows the build output - Defalt false
  -h, --help  : Show this help text" (version)))

(local options {})
(local default-path (.. "." separator :src))
(local default-out (.. "." separator :out))

(fn set-options [path out verbose]
  (when (not options.path)
    (set options.path (or path default-path)))
  (when (not options.out)
    (set options.out (or out default-out)))
  (when (not options.verbose)
    (set options.verbose (or verbose false))))

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
  (let [file-name (string.sub file-path (string.find file-path "%a+%.%a+") -1)
        out-file (replace-ext out-path)
        f (assert (io.open out-file :w+))]
    (f:write text)
    (when options.verbose
      (print (.. "Writing file: " out-file)))
    (f:close)))

(fn compile [file-path out-path]
  "Compile the .fnl file to a .lua file"
  (let [f (assert (io.open file-path :r))
        text (fennel.compile-string (f:read :*all))]
    (write-file file-path out-path text)
    (f:close)))

(fn walk-files [path]
  "Walk each folder for all .fnl files in the [path] and compile it to .lua"
  (create-out-dir)
  (each [dir (lfs.dir path)]
    (let [dir-path (.. path separator dir)
          dir-mode (. (lfs.attributes dir-path) :mode)
          out-path (string.gsub dir-path (.. "(" options.path ")") options.out)]
      (if (= dir-mode :file) (compile dir-path out-path)
          (and (= dir-mode :directory) (not (or (= "." dir) (= ".." dir)))) (do
                                                                              (lfs.mkdir out-path)
                                                                              (walk-files dir-path))))))

(match arg
  ([] ? (= 0 (length arg))) (do
                              (set-options)
                              (walk-files options.path))
  [:--path path :--out out :--verbose] (do
                                         (set-options path out true)
                                         (walk-files path))
  [:--path path :--out out] (do
                              (set-options path out)
                              (walk-files path))
  [:--path path :--verbose] (do
                              (set-options path nil true)
                              (walk-files path))
  [:--path path] (do
                   (set-options path)
                   (walk-files path))
  [:--out out] (do
                 (set-options nil out)
                 (walk-files options.path))
  [:--verbose] (do
                 (set-options nil nil true)
                 (walk-files options.path))
  [:-h] (print help)
  [:--help] (print help))

