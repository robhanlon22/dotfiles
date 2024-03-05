(fn [_vim]
  (let [ufo (require :ufo)]
    (fn ufo-provider-selector []
      [:treesitter :indent])

    {:ufo {:open_all_folds ufo.openAllFolds
           :close_all_folds ufo.closeAllFolds
           :provider_selector ufo-provider-selector}}))
