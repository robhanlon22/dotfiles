(fn []
  (let [files [:conf/cmp :conf/telescope :conf/lsp]]
    (accumulate [conf {} _ file (ipairs files)]
      (let [mod (require file)]
        (vim.tbl_extend :error conf (mod))))))
