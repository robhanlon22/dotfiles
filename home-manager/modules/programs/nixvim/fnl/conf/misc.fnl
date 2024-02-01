(let [ufo (require :ufo)]
  (fn nvim-paredit-setup []
    (let [nvim-paredit (require :nvim-paredit)
          nvim-paredit-fennel (require :nvim-paredit-fennel)]
      (nvim-paredit.setup {})
      (nvim-paredit-fennel.setup {})))

  (fn ufo-provider-selector []
    [:treesitter :indent])

  (fn virt-column-setup []
    (let [virt-column (require :virt-column)]
      (virt-column.setup {})))

  (fn []
    (nvim-paredit-setup)
    (virt-column-setup)
    {:ufo {:open_all_folds ufo.openAllFolds
           :close_all_folds ufo.closeAllFolds
           :provider_selector ufo-provider-selector}}))
