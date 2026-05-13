# Emran's Custom Neovim setup

Modular | Scalable | Easy to Maintain

<img width="2974" height="1674" alt="Emran Neovim Alpha" src="https://github.com/user-attachments/assets/b98d8d7d-68ef-412f-be59-02d3939c5563" />

# Why Vim or Nvim ?

It is an improvement of `vi` editor from the 1970's. It is a text editor. Vim has been around for a long time. It makes you productive, efficient and it is BLAZINGLY fast. Works over remote ssh without needing a GUI. Vim has a rock solid stability that will surpass your expectation by a long shot. Instead of “where’s my cursor and how do I drag-select this?” you start thinking:

> “I want to operate on this sentence, that block, or that function.”

## What you need to know

A little bit of [Lua](https://www.lua.org/manual/5.4/) knowledge
Vim motions : [Vim motions](https://neovim.io/doc/user/motion.html) are "cursor motions", you use them to perform editing, navigation and move around without using the mouse.

## Setup

1. Clone this repository into your Neovim config directory and you are good to go.
   [git clone https://github.com/git-emran/emran-neovim.git ~/.config/nvim]
2. There are few dependencies you might need to install like fzf, lazygit, opencode etc. But All of the errors coming from the dependencies will be straight forward and will flag when something is missing. So installation of the missing dependencies should be very easy.
3. Since my config uses `vim-pack`, You will find that there are some custom local functions inside my `vim-pack.lua` file. Go through them, it should be fairly easy to comprehend why it's there. But I will summarize here a bit. I was using lazy distro for nvim. So lazy loading was something I liked very much. Inside the `vim-pack.lua` file, the custom functions are divided into few categories like, `add_on_event`, `add`, `on_plugin_update` etc are there to lazy load plugins when necessary.

4. Updating the plugins. After you have setup the config manually, What if you want to update stuff ? That is easy too with the new neovim 0.12 with vim command `:lua vim.pack.update()` you can update your plugins.


