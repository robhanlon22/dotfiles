(fn [_vim]
  (let [extras (require :which-key.extras)]
    {:which_key {:buffers extras.expand.buf :windows extras.expand.win}}))
