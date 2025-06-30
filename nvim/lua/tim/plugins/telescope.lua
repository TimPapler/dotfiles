return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  -- Lazy load telescope - now mainly used for legacy/specialized functions
  cmd = { "Telescope" },
  keys = {
    { "<leader>T", desc = "Telescope" },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telejscope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        file_ignore_patterns = { "%.git/", "node_modules", "%.npm/", "__pycache__", "%.DS_Store" },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ['<C-n>'] = require('telescope.actions').cycle_history_next,
            ['<C-p>'] = require('telescope.actions').cycle_history_prev,
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-c>'] = require('telescope.actions').close,
            ['<Down>'] = require('telescope.actions').move_selection_next,
            ['<Up>'] = require('telescope.actions').move_selection_previous,
            ['<CR>'] = require('telescope.actions').select_default,
            ['<C-x>'] = require('telescope.actions').select_horizontal,
            ['<C-v>'] = require('telescope.actions').select_vertical,
            ['<C-t>'] = require('telescope.actions').select_tab,
            ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
            ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
            ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
            ['<C-q>'] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
            ['<M-q>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
            ['<C-l>'] = require('telescope.actions').complete_tag,
            ['<C-_>'] = require('telescope.actions').which_key, -- keys from pressing <C-/>
          },
          n = {
            ['<esc>'] = require('telescope.actions').close,
            ['<CR>'] = require('telescope.actions').select_default,
            ['<C-x>'] = require('telescope.actions').select_horizontal,
            ['<C-v>'] = require('telescope.actions').select_vertical,
            ['<C-t>'] = require('telescope.actions').select_tab,
            ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
            ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
            ['<C-q>'] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
            ['<M-q>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
            ['j'] = require('telescope.actions').move_selection_next,
            ['k'] = require('telescope.actions').move_selection_previous,
            ['H'] = require('telescope.actions').move_to_top,
            ['M'] = require('telescope.actions').move_to_middle,
            ['L'] = require('telescope.actions').move_to_bottom,
            ['<Down>'] = require('telescope.actions').move_selection_next,
            ['<Up>'] = require('telescope.actions').move_selection_previous,
            ['gg'] = require('telescope.actions').move_to_top,
            ['G'] = require('telescope.actions').move_to_bottom,
            ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
            ['<C-f>'] = require('telescope.actions').preview_scrolling_down,
            ['<C-k>'] = require('telescope.actions').preview_scrolling_up,
            ['?'] = require('telescope.actions').which_key,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function(opts)
            return {"--hidden"}
          end
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = require('telescope.actions').delete_buffer,
            },
            n = {
              ["dd"] = require('telescope.actions').delete_buffer,
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Minimal telescope setup - main pickers replaced by snacks.picker
    -- Keep only specialized functions and xcodebuild.nvim dependency
    local builtin = require 'telescope.builtin'
    
    -- Telescope legacy keymaps (prefixed with T to avoid conflicts)
    vim.keymap.set('n', '<leader>Ts', builtin.builtin, { desc = '[T]elescope [S]elect Telescope' })
    vim.keymap.set('n', '<leader>Tn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[T]elescope [N]eovim files' })
    
    -- Keep specialized telescope functions without snacks equivalents
    vim.keymap.set('n', '<leader>T/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[T]elescope current buffer fuzzy search' })
    
    vim.keymap.set('n', '<leader>T?', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[T]elescope search in open files' })
    
  end,
}
