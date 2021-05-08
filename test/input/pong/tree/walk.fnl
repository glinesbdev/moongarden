;; Example used from https://fennel-lang.org/see
(fn walk-tree [root f custom-iterator]
  (fn walk [iterfn parent idx node]
    (when (f idx node parent)
      (each [k v (iterfn node)]
        (walk iterfn node k v))))

  (walk (or custom-iterator pairs) nil nil root)
  root)

