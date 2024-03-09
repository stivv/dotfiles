-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    -- Telescope file browser
    { "nvim-telescope/telescope-file-browser.nvim" },
  },
  config = function()
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`

    local ok, telescope = pcall(require, "telescope")

    if not ok then
      return
    end

    local actions = require("telescope.actions")

    local fb_actions = require("telescope").extensions.file_browser.actions

    telescope.setup({
      defaults = {
        path_display = { truncate = 1 },
        prompt_prefix = "   ",
        selection_caret = "  ",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
          },
        },
        file_ignore_patterns = { ".git/", "node_modules", "public", "vendor" },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          previewer = false,
          layout_config = {
            width = 80,
          },
        },
        oldfiles = {
          prompt_title = "History",
        },
        lsp_references = {
          previewer = false,
        },
      },
      extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          cwd_to_path = true,
          mappings = {
            ["i"] = {
              ["C-w"] = function()
                vim.cmd("normal vbd")
              end,
            },
            ["n"] = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
            },
          },
        },
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(telescope.load_extension, "fzf")

    -- To get telescope-file-browser loaded and working with telescope,
    pcall(telescope.load_extension, "file_browser")

    local builtin = require("telescope.builtin")


    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- See `:help telescope.builtin`
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer]" })

    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>nt', "<cmd>Telescope file_browser path=%:p:h previewer=false initial_mode=normal<cr>")
  end
}

