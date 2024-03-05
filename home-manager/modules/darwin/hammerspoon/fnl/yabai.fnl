(fn [{: hs : paths}]
  (let [exec (fn [command]
               (os.execute (.. paths.yabai " -m " command)))
        bind (fn [key command]
               (hs.hotkey.bind [:ctrl :shift] key #(exec command)))
        stack (fn [action]
                (.. "window --focus stack." action))]
    (bind :j (stack :next))
    (bind :k (stack :prev))))
