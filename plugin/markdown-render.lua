local add_on_event = require('vim-pack').add_on_event

add_on_event('FileType', {
    {
        src = 'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            bullet = {
                enabled = true,
                icons = { '●', '○', '◆', '◇' },
            },
            code = {
                enabled = true,
                render_modes = true,
                sign = true,
                language = true,
                conceal_delimiters = true,
                position = 'right',
                language_icon = true,
                language_name = true,
            },
            sign = {
                enabled = true,
                highlight = 'RenderMarkdownSign',
            },
            checkbox = {
                enabled = true,
                unchecked = {
                    -- Replaces '[ ]' of 'task_list_marker_unchecked'.
                    icon = '󰄱 ',
                    -- Highlight for the unchecked icon.
                    highlight = 'RenderMarkdownUnchecked',
                    -- Highlight for item associated with unchecked checkbox.
                    scope_highlight = nil,
                },
                checked = {
                    -- Replaces '[x]' of 'task_list_marker_checked'.
                    icon = '󰱒 ',
                    -- Highlight for the checked icon.
                    highlight = 'RenderMarkdownChecked',
                    -- Highlight for item associated with checked checkbox.
                    scope_highlight = nil,
                },
            },
            pipe_table = {
                enabled = true,
                border_enabled = true,
                alignment_indicator = '━',
                padding = 2,
            },
            link = {
                render_modes = false,
                -- How to handle footnote links, start with a '^'.
                footnote = {
                    -- Turn on / off footnote rendering.
                    enabled = true,
                    -- Inlined with content.
                    icon = '󰯔 ',
                    -- Custom processing for footnote body to show.
                    -- Runs before prefix / suffix are added and superscript processing.
                    body = function(ctx)
                        return ctx.text
                    end,
                    -- Replace value with superscript equivalent.
                    superscript = true,
                    -- Added before link content.
                    prefix = '',
                    -- Added after link content.
                    suffix = '',
                },
                image = '󰥶 ',
                -- Check custom for 'image' elements.
                image_custom = true,
                -- Inlined with 'email_autolink' elements.
                email = '󰀓 ',
                -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
                hyperlink = '󰌹 ',
                -- Applies to the inlined icon as a fallback.
                highlight = 'RenderMarkdownLink',
                -- Applies to the link title.
                highlight_title = 'RenderMarkdownLinkTitle',
                custom = {
                    web = { icon = '󰖟 ', pattern = '^http' },
                    apple = { icon = ' ', pattern = 'apple%.com', kind = 'url' },
                    discord = { icon = '󰙯 ', pattern = 'discord%.com', kind = 'url' },
                    github = { icon = '󰊤 ', pattern = 'github%.com', kind = 'url' },
                    gitlab = { icon = '󰮠 ', pattern = 'gitlab%.com', kind = 'url' },
                    google = { icon = '󰊭 ', pattern = 'google%.com', kind = 'url' },
                    hackernews = { icon = ' ', pattern = 'ycombinator%.com', kind = 'url' },
                    linkedin = { icon = '󰌻 ', pattern = 'linkedin%.com', kind = 'url' },
                    microsoft = { icon = ' ', pattern = 'microsoft%.com', kind = 'url' },
                    neovim = { icon = ' ', pattern = 'neovim%.io', kind = 'url' },
                    reddit = { icon = '󰑍 ', pattern = 'reddit%.com', kind = 'url' },
                    slack = { icon = '󰒱 ', pattern = 'slack%.com', kind = 'url' },
                    stackoverflow = { icon = '󰓌 ', pattern = 'stackoverflow%.com', kind = 'url' },
                    steam = { icon = ' ', pattern = 'steampowered%.com', kind = 'url' },
                    twitter = { icon = ' ', pattern = 'twitter%.com', kind = 'url' },
                    wikipedia = { icon = '󰖬 ', pattern = 'wikipedia%.org', kind = 'url' },
                    x = { icon = ' ', pattern = 'x%.com', kind = 'url' },
                    youtube = { icon = '󰗃 ', pattern = 'youtube[^.]*%.com', kind = 'url' },
                    youtube_short = { icon = '󰗃 ', pattern = 'youtu%.be', kind = 'url' },
                },
            },
            callout = {
                -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'.
                -- The key is for healthcheck and to allow users to change its values, value type below.
                -- | raw        | matched against the raw text of a 'shortcut_link', case insensitive |
                -- | rendered   | replaces the 'raw' value when rendering                             |
                -- | highlight  | highlight for the 'rendered' text and quote markers                 |
                -- | quote_icon | optional override for quote.icon value for individual callout       |
                -- | category   | optional metadata useful for filtering                              |

                note = {
                    raw = '[!NOTE]',
                    rendered = '󰋽 Note',
                    highlight = 'RenderMarkdownInfo',
                    category = 'github',
                },
                tip = {
                    raw = '[!TIP]',
                    rendered = '󰌶 Tip',
                    highlight = 'RenderMarkdownSuccess',
                    category = 'github',
                },
                important = {
                    raw = '[!IMPORTANT]',
                    rendered = '󰅾 Important',
                    highlight = 'RenderMarkdownHint',
                    category = 'github',
                },
                warning = {
                    raw = '[!WARNING]',
                    rendered = '󰀪 Warning',
                    highlight = 'RenderMarkdownWarn',
                    category = 'github',
                },
                caution = {
                    raw = '[!CAUTION]',
                    rendered = '󰳦 Caution',
                    highlight = 'RenderMarkdownError',
                    category = 'github',
                },
                -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
                abstract = {
                    raw = '[!ABSTRACT]',
                    rendered = '󰨸 Abstract',
                    highlight = 'RenderMarkdownInfo',
                    category = 'obsidian',
                },
                summary = {
                    raw = '[!SUMMARY]',
                    rendered = '󰨸 Summary',
                    highlight = 'RenderMarkdownInfo',
                    category = 'obsidian',
                },
                tldr = {
                    raw = '[!TLDR]',
                    rendered = '󰨸 Tldr',
                    highlight = 'RenderMarkdownInfo',
                    category = 'obsidian',
                },
                info = {
                    raw = '[!INFO]',
                    rendered = '󰋽 Info',
                    highlight = 'RenderMarkdownInfo',
                    category = 'obsidian',
                },
                todo = {
                    raw = '[!TODO]',
                    rendered = '󰗡 Todo',
                    highlight = 'RenderMarkdownInfo',
                    category = 'obsidian',
                },
                hint = {
                    raw = '[!HINT]',
                    rendered = '󰌶 Hint',
                    highlight = 'RenderMarkdownSuccess',
                    category = 'obsidian',
                },
                success = {
                    raw = '[!SUCCESS]',
                    rendered = '󰄬 Success',
                    highlight = 'RenderMarkdownSuccess',
                    category = 'obsidian',
                },
                check = {
                    raw = '[!CHECK]',
                    rendered = '󰄬 Check',
                    highlight = 'RenderMarkdownSuccess',
                    category = 'obsidian',
                },
                done = {
                    raw = '[!DONE]',
                    rendered = '󰄬 Done',
                    highlight = 'RenderMarkdownSuccess',
                    category = 'obsidian',
                },
                question = {
                    raw = '[!QUESTION]',
                    rendered = '󰘥 Question',
                    highlight = 'RenderMarkdownWarn',
                    category = 'obsidian',
                },
                help = {
                    raw = '[!HELP]',
                    rendered = '󰘥 Help',
                    highlight = 'RenderMarkdownWarn',
                    category = 'obsidian',
                },
                faq = {
                    raw = '[!FAQ]',
                    rendered = '󰘥 Faq',
                    highlight = 'RenderMarkdownWarn',
                    category = 'obsidian',
                },
                attention = {
                    raw = '[!ATTENTION]',
                    rendered = '󰀪 Attention',
                    highlight = 'RenderMarkdownWarn',
                    category = 'obsidian',
                },
                failure = {
                    raw = '[!FAILURE]',
                    rendered = '󰅖 Failure',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                fail = {
                    raw = '[!FAIL]',
                    rendered = '󰅖 Fail',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                missing = {
                    raw = '[!MISSING]',
                    rendered = '󰅖 Missing',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                danger = {
                    raw = '[!DANGER]',
                    rendered = '󱐌 Danger',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                error = {
                    raw = '[!ERROR]',
                    rendered = '󱐌 Error',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                bug = {
                    raw = '[!BUG]',
                    rendered = '󰨰 Bug',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                example = {
                    raw = '[!EXAMPLE]',
                    rendered = '󰉹 Example',
                    highlight = 'RenderMarkdownHint',
                    category = 'obsidian',
                },
                quote = {
                    raw = '[!QUOTE]',
                    rendered = '󱆨 Quote',
                    highlight = 'RenderMarkdownQuote',
                    category = 'obsidian',
                },
                cite = {
                    raw = '[!CITE]',
                    rendered = '󱆨 Cite',
                    highlight = 'RenderMarkdownQuote',
                    category = 'obsidian',
                },
            },
        },
    },
})
