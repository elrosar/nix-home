{ config, lib, ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps =
      let
        normal =
          lib.mapAttrsToList
            (key: action: {
              mode = "n";
              inherit action key;
            })
            {
              "<Space>" = "<NOP>";

              # Esc to clear search results
              "<esc>" = ":noh<CR>";

              # back and fourth between the two most recent files
              "<C-c>" = ":b#<CR>";

              # close with Ctrl+x
              "<C-x>" = ":close<CR>";

              # save with Space+s
              "<leader>s" = ":w<CR>";

              # navigate to up/down/left/right window
              "<leader>k" = "<C-w>k";
              "<leader>j" = "<C-w>j";
              "<leader>h" = "<C-w>h";
              "<leader>l" = "<C-w>l";

              # Press 'H', 'L' to jump to start/end of a line (first/last character)
              L = "$";
              H = "^";

              # resize with arrows
              "<C-Up>" = ":resize -2<CR>";
              "<C-Down>" = ":resize +2<CR>";
              "<C-Left>" = ":vertical resize +2<CR>";
              "<C-Right>" = ":vertical resize -2<CR>";

              # move current line up/down
              # M = Alt key
              "<M-k>" = ":move-2<CR>";
              "<M-j>" = ":move+<CR>";
            };
        visual =
          lib.mapAttrsToList
            (key: action: {
              mode = "v";
              inherit action key;
            })
            {
              # better indenting
              ">" = ">gv";
              "<" = "<gv";
            };
      in
      config.lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual);
  };
}
