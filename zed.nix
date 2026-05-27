{
  programs = {
    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "rust"
        "catppuccin"
        "material-icon-theme"
      ];
      userSettings = {
        theme = {
          mode = "system";
          light = "Catppuccin Latte - No Italics";
          dark = "Catppuccin Macchiato - No Italics";
        };
        icon_theme = "Material Icon Theme";
        base_keymap = "VSCode";
        search = {
          case_sensitive = true;
        };
        collaboration_panel = {
          button = false;
        };
        tab_bar = {
          show_pinned_tabs_in_separate_row = false;
        };
        gutter = {
          folds = false;
        };
        toolbar = {
          quick_actions = false;
          breadcrumbs = true;
        };
        inlay_hints = {
          enabled = false;
        };
        diagnostics = {
          inline = {
            enabled = true;
          };
        };
        drag_and_drop_selection = {
          enabled = false;
        };
        ui_font_family = ".SystemUIFont";
        cli_default_open_behavior = "existing_window";
        use_system_window_tabs = false;
        centered_layout = {
          left_padding = 0.2;
        };
        bottom_dock_layout = "contained";
        git = {
          inline_blame = {
            min_column = 100;
            show_commit_summary = true;
            enabled = true;
          };
        };
        outline_panel = {
          dock = "left";
        };
        git_panel = {
          dock = "left";
        };
        disable_ai = true;
        project_panel = {
          git_status_indicator = true;
          diagnostic_badges = true;
          bold_folder_labels = true;
          dock = "left";
        };
        session = {
          trust_all_worktrees = true;
        };
        terminal = {
          font_size = 19.0;
          font_family = "Uiua386";
          font_fallbacks = [
            "Fira Code"
            "DejaVu Sans Mono"
            ".ZedMono"
          ];
          cursor_shape = "bar";
          blinking = "on";
          max_scroll_history_lines = 5000;
        };
        tabs = {
          git_status = true;
          file_icons = true;
          close_position = "left";
        };
        buffer_font_family = "Fira Code";
        buffer_font_fallbacks = [
          "Uiua386"
          ".ZedMono"
        ];
        ui_font_size = 20.0;
        buffer_font_size = 19.0;
        semantic_tokens = "combined";
        multi_cursor_modifier = "ctrl";
        lsp = {
          rust-analyzer.initialization_options.check.command = "clippy";
        };
        profiles = {
          Uiua = {
            settings = {
              buffer_font_family = "Uiua386";
              buffer_font_size = 20;
            };
          };
        };
      };
      userKeymaps = [
        {
          bindings = {
            "ctrl-r" = "projects::OpenRecent";
            "ctrl-o" = "workspace::Open";
            "ctrl-g ctrl-c" = "git::Commit";
            "ctrl-g ctrl-p" = "git::Push";
            "ctrl-g ctrl-l" = "git::Pull";
            "ctrl-g ctrl-f" = "git::Fetch";
            "ctrl-g ctrl-a" = "git::StageAll";
          };
          unbind = {
            "ctrl-g" = "go_to_line::Toggle";
            "ctrl-k ctrl-o" = "workspace::Open";
            "ctrl-shift-w" = "workspace::CloseWindow";
          };
        }
        {
          context = "Workspace";
          bindings = {
            "ctrl-shift-e" = "workspace::ToggleLeftDock";
            "ctrl-e" = "project_panel::ToggleFocus";
            "alt-g" = "git_panel::ToggleFocus";
            "alt-l" = "go_to_line::Toggle";
          };
          unbind = {
            "ctrl-b" = "workspace::ToggleLeftDock";
            "ctrl-shift-e" = "project_panel::ToggleFocus";
            "ctrl-shift-g" = "git_panel::ToggleFocus";
            "ctrl-r" = "projects::OpenRecent";
          };
        }
        {
          context = "Pane";
          bindings = {
            "ctrl-p ctrl-p" = "pane::TogglePinTab";
            "ctrl-shift-w" = "workspace::CloseAllItemsAndPanes";
          };
          unbind = {
            "ctrl-k shift-enter" = "pane::TogglePinTab";
            "ctrl-k w" = [
              "pane::CloseAllItems"
              { close_pinned = false; }
            ];
            "ctrl-k ctrl-w" = "workspace::CloseAllItemsAndPanes";
          };
        }
      ];
    };
  };
}
