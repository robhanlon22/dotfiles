(fn [options]
  (each [_ mod (ipairs [:fnl.ipc :fnl.yabai])]
    ((require mod) options)))
