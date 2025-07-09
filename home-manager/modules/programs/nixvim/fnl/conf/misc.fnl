(fn [_vim]
  (fn nvim-paredit-setup []
    (let [nvim-paredit (require :nvim-paredit)]
      (nvim-paredit.setup {})))

  (nvim-paredit-setup)
  {})
