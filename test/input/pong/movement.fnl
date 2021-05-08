;; Example used from https://fennel-lang.org/see
;; Read the keyboard, move player accordingly
(local dirs {:up [0 -1] :down [0 1] :left [-1 0] :right [1 0]})

(each [key delta (pairs dirs)]
  (when (love.keyboard.isDown key)
    (let [[dx dy] delta
          [px py] player
          x (+ px (* dx player.speed dt))
          y (+ py (* dy player.speed dt))]
      (world:move player x y))))

