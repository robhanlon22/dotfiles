(fn [_vim]
  (fn nvim-paredit-setup []
    (let [nvim-paredit (require :nvim-paredit)
          nvim-paredit-fennel (require :nvim-paredit-fennel)]
      (nvim-paredit.setup {})
      (nvim-paredit-fennel.setup {})))

  (fn virt-column-setup []
    (let [virt-column (require :virt-column)]
      (virt-column.setup {})))

  (fn copilot-chat-setup []
    (let [copilot-chat (require :CopilotChat)]
      ;; CopilotChat fails loudly when Copilot is not set up, so use pcall here
      ;; to handle expected errors
      (pcall copilot-chat.setup {})))

  (copilot-chat-setup)
  (nvim-paredit-setup)
  (virt-column-setup)
  {})
