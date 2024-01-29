(let [VimMode (hs.loadSpoon :VimMode)
      vim (: VimMode :new)]
  (require :hs.ipc)
  (-> vim
      (: :disableForApp :kitty)
      (: :disableForApp :zoom.us)
      (: :enterWithSequence :jk)))
