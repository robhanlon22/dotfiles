; (let [VimMode (hs.loadSpoon :VimMode)
;       vim-mode (VimMode:new)]
;   (vim-mode:disableForApp :kitty)
;   (vim-mode:disableForApp :zoom.us)
;   (vim-mode:enterWithSequence :jk))

(let [yabai {:path :/run/current-system/sw/bin/yabai
             :exec (fn [self commands]
                     (each [_ command (ipairs commands)]
                       (os.execute (.. self.path " -m " command))))
             :bind (fn [self key commands]
                     (hs.hotkey.bind [:ctrl :shift] key #(self:exec commands)))}]
  (yabai:bind :j ["window --focus stack.next"])
  (yabai:bind :k ["window --focus stack.prev"]))
