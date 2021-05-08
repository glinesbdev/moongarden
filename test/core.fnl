(local l (require :test.luaunit))
(local lfs (require :lfs))

(fn moongarden [...]
  (local cmd [:./moongarden ...])
  (let [proc (io.popen (table.concat cmd " "))
        output (proc:read :*a)]
    output))

(fn test-help []
  (l.assertStrContains (moongarden :--help)
                       "Usage: moongarden [--path FILE|DIRECTORY] [--out DIRECTORY] [,--verbose] [,--watch]"))

(fn test-version []
  (l.assertEquals (moongarden :--version)
                  (string.format "Moon Garden %s\n%s\n" :0.1.0 _VERSION)))

; TODO: Solidify this test and get it working
; (fn write-files []
;   (moongarden :--path :./test/input :--out :./test/out)
;   (let [out-dir (.. (lfs.currentdir) :/test/out)]
;     (each [dir (lfs.dir out-dir)]
;       (let [dir-mode (. (lfs.attributes dir) :mode)]
;         (if (= dir-mode :file)
;             (l.assertContains dir :.lua))))))

{: test-help : test-version}

