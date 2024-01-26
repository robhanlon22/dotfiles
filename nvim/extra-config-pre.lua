-- luacheck: globals vim
local cmp_tab
local cmp_s_tab

-- cmp functions
do
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local function has_words_before()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	-- luacheck: ignore cmp_tab
	function cmp_tab(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end

	-- luacheck: ignore cmp_s_tab
	function cmp_s_tab(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end
end

-- telescope functions
local open_projects
local open_frecency
do
	local project = require("project_nvim.project")
	local project_config = require("project_nvim.config")
	local telescope = require("telescope")
	local telescope_actions = require("telescope.actions")
	local telescope_state = require("telescope.actions.state")

	function open_frecency(opts)
		telescope.extensions.frecency.frecency(vim.tbl_deep_extend("force", { workspace = "LSP" }, opts or {}))
	end

	local function change_working_directory(prompt_bufnr, prompt)
		local selected_entry = telescope_state.get_selected_entry(prompt_bufnr)
		if selected_entry == nil then
			telescope_actions.close(prompt_bufnr)
			return
		end
		local project_path = selected_entry.value
		if prompt == true then
			telescope_actions._close(prompt_bufnr, true)
		else
			telescope_actions.close(prompt_bufnr)
		end
		local cd_successful = project.set_pwd(project_path, "telescope")
		return project_path, cd_successful
	end

	local function find_project_files(prompt_bufnr)
		local project_path, cd_successful = change_working_directory(prompt_bufnr, true)
		local opts = {
			cwd = project_path,
			hidden = project_config.options.show_hidden,
			mode = "insert",
		}
		if cd_successful then
			open_frecency(opts)
		else
			vim.notify("hm")
		end
	end

	-- luacheck: ignore open_projects
	function open_projects()
		telescope.extensions.projects.projects({
			attach_mappings = function(prompt_bufnr)
				local on_project_selected = function()
					find_project_files(prompt_bufnr)
				end
				telescope_actions.select_default:replace(on_project_selected)
				return true
			end,
		})
	end
end
