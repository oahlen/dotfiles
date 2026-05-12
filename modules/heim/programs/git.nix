{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.git;

  base = lib.generators.toGitINI {
    alias = {
      br = "branch";
      c = "commit";
      s = "status";
      sb = "!switch-branch";
      tree = "log --graph --decorate --oneline";
    };

    core = {
      autocrlf = "input";
      editor = "nvim";
      eol = "lf";
      pager = "delta";
    };

    filter.lfs = {
      clean = "git-lfs clean -- %f";
      process = "git-lfs filter-process";
      required = true;
      smudge = "git-lfs smudge -- %f";
    };

    include.path = "delta";

    init.defaultBranch = "main";

    interactive.diffFilter = "delta --color-only";

    pull.rebase = true;

    push.autoSetupRemote = true;

    user.name = "Oscar Ahlén";
  };

  mkDeltaConfig =
    variant:
    lib.generators.toGitINI {
      delta = {
        navigate = true;
        side-by-side = true;
        syntax-theme = "base16";
        file-modified-label = "changed:";
        file-style = "cyan";
        file-decoration-style = "brightblack ul";
        hunk-header-style = "line-number syntax";
        hunk-header-decoration-style = "brightblack box";
        hunk-header-file-style = "white";
        hunk-header-line-number-style = "white";
        minus-style = "syntax ${variant.diff.deleted_bg}";
        minus-non-emph-style = "syntax ${variant.diff.deleted_bg}";
        minus-emph-style = "black red";
        minus-empty-line-marker-style = "syntax ${variant.diff.deleted_bg}";
        plus-style = "syntax ${variant.diff.added_bg}";
        plus-non-emph-style = "syntax ${variant.diff.added_bg}";
        plus-emph-style = "black green";
        plus-empty-line-marker-style = "syntax ${variant.diff.added_bg}";
        line-numbers-minus-style = "syntax ${variant.diff.deleted_bg}";
        line-numbers-plus-style = "syntax ${variant.diff.added_bg}";
        line-numbers-zero-style = "brightblack";
        line-numbers-left-style = "brightblack";
        line-numbers-right-style = "brightblack";
      };
    };
in
{
  options.programs.git.enable = lib.mkEnableOption "git.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.delta ];

    xdg.config.files = {
      "git/config".text = base;

      "git/delta".variants = {
        dark = {
          text = mkDeltaConfig config.colors.dark;
          default = config.colorscheme.default == "dark";
        };

        light = {
          text = mkDeltaConfig config.colors.light;
          default = config.colorscheme.default == "light";
        };
      };
    };
  };
}
