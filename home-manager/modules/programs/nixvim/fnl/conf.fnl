(fn [vim]
  (let [files [:conf/cmp :conf/telescope :conf/lsp :conf/misc :conf/ufo]]
    (accumulate [conf {} _ file (ipairs files)]
      (let [mod (require file)]
        (vim.tbl_extend :error conf (mod vim))))))
