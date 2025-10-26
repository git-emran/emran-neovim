# Emran's Custom Neovim setup

Modular | Scalable | Easy to Maintain

<img width="2974" height="1674" alt="Emran Neovim Alpha" src="https://github.com/user-attachments/assets/b98d8d7d-68ef-412f-be59-02d3939c5563" />

# Why vim ?

It is an improvement of `vi` editor from the 1970's. It is a text editor. Vim has been around for a long time. It makes you productive, efficient and it is BLAZINGLY fast. Works over remote ssh without needing a GUI. Vim has a rock solid stability that will surpass your expectation by a long shot. Instead of “where’s my cursor and how do I drag-select this?” you start thinking:

> “I want to operate on this sentence, that block, or that function.”

## What you need to know

A little bit of [Lua](https://www.lua.org/manual/5.4/) knowledge
Vim motions : [Vim motions](https://neovim.io/doc/user/motion.html) are "cursor motions", you use them to perform editing, navigation and move around without using the mouse.

## Setup

My setup is so easy that you can copy it in just 4 steps.

1. Clone this repository into your Neovim config directory:
   [git clone https://github.com/git-emran/emran-neovim.git ~/.config/nvim]

2. Recreate my Folder structure. For example: options folder (for all neovim options), keymaps folder (for all keybindings), plugins folder (for all plugins) and etc.

3. Create your custom init.lua file in your .config/nvim directory.

4. Paste my init.lua content and run " :Lazy sync "
