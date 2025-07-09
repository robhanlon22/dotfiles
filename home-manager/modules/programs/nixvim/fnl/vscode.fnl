(fn [vim]
  (let [code (require :vscode-neovim)]
    (fn map-paredit [keys action]
      (vim.keymap.set :n keys
                      (fn []
                        (code.action action))
                      {:silent true}))

    (map-paredit ">)" :paredit.slurpSexpForward)
    (map-paredit ">(" :paredit.barfSexpBackward)
    (map-paredit "<)" :paredit.barfSexpForward)
    (map-paredit "<(" :paredit.slurpSexpBackward)
    (map-paredit :>e :paredit.dragSexprForward)
    (map-paredit :<e :paredit.dragSexprBackward)))
