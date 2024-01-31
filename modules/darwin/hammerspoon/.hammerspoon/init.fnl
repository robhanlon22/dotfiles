(require :hs.ipc)

(let [VimMode (hs.loadSpoon :VimMode)
      vim (: VimMode :new)]
  (-> vim
      (: :disableForApp :kitty)
      (: :disableForApp :zoom.us)
      (: :enterWithSequence :jk)))
