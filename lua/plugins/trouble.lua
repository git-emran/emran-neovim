return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Core settings
    auto_close = false,    -- auto close when there are no items
    auto_open = false,     -- auto open when there are items
    auto_preview = true,   -- automatically open preview when on an item
    auto_refresh = true,   -- auto refresh when open
    auto_jump = false,     -- auto jump to the item when there's only one

    focus = false,         -- Focus the window when opened
    follow = true,         -- Follow the current item
    indent_guides = true,  -- show indent guides
    max_items = 200,       -- limit number of items
    multiline = true,      -- render multi-line messages
    pinned = false,        -- pin to current buffer
    warn_no_results = true, -- show warning when no results
    open_no_results = false, -- don't open when no results

    -- Use LSP diagnostic signs
    use_diagnostic_signs = true,

    -- Window configuration
    win = {
      type = "split",   -- split, vsplit, float
      relative = "editor",
      position = "bottom", -- bottom, top, left, right
      size = { height = 12 },
      zindex = 200,
    },

    -- Preview window
    preview = {
      type = "float",
      relative = "win",
      border = "rounded",
      title = "Preview",
      title_pos = "center",
      position = { 0, -2 },
      size = { width = 0.3, height = 0.3 },
      zindex = 200,
    },

    -- Icons (simplified but comprehensive)
    icons = {
      indent = {
        top = "│ ",
        middle = "├╴",
        last = "└╴",
        fold_open = " ",
        fold_closed = " ",
        ws = "  ",
      },
      folder_closed = " ",
      folder_open = " ",
      kinds = {
        Array = " ",
        Boolean = "󰨙 ",
        Class = " ",
        Constant = "󰏿 ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Function = "󰊕 ",
        Interface = " ",
        Key = " ",
        Method = "󰊕 ",
        Module = " ",
        Namespace = "󰦮 ",
        Null = " ",
        Number = "󰎠 ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        String = " ",
        Struct = "󰆼 ",
        TypeParameter = " ",
        Variable = "󰀫 ",
      },
    },

    -- Key mappings (essential ones)
    keys = {
      ["?"] = "help",
      ["r"] = "refresh",
      ["R"] = "toggle_refresh",
      ["q"] = "close",
      ["o"] = "jump_close",
      ["<esc>"] = "cancel",
      ["<cr>"] = "jump",
      ["<2-leftmouse>"] = "jump",
      ["<c-s>"] = "jump_split",
      ["<c-v>"] = "jump_vsplit",
      -- Navigation
      ["j"] = "next",
      ["k"] = "prev",
      ["]]"] = function()
        require("trouble").next({ skip_groups = true, jump = true })
      end,
      ["[["] = function()
        require("trouble").prev({ skip_groups = true, jump = true })
      end,
      -- Folding
      ["za"] = "fold_toggle",
      ["zA"] = "fold_toggle_recursive",
      ["zo"] = "fold_open",
      ["zO"] = "fold_open_recursive",
      ["zc"] = "fold_close",
      ["zC"] = "fold_close_recursive",
      ["zr"] = "fold_reduce",
      ["zm"] = "fold_more",
      -- Preview
      ["<tab>"] = "toggle_preview",
      ["P"] = "toggle_preview",
    },
  },
  cmd = "Trouble",
  keys = {
    -- Diagnostics (most important)
    {
      "<leader>tr",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>tx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    -- LSP features
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    -- Lists
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    -- Navigation (fixed to avoid "next item not found" flash)
    {
      "]t",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          vim.cmd.cnext()
        end
      end,
      desc = "Next Trouble/Quickfix Item",
    },
    {
      "[t",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          vim.cmd.cprev()
        end
      end,
      desc = "Previous Trouble/Quickfix Item",
    },
  },
}
