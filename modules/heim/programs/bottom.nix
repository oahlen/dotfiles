{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.bottom;
  toml = pkgs.formats.toml { };

  conf = {
    flags = {
      processes = {
        default_grouped = true;
        default_memory_value = true;
      };
    };

    row = [
      {
        ratio = 30;
        child = [ { type = "cpu"; } ];
      }
      {
        ratio = 40;
        child = [
          {
            default = true;
            ratio = 4;
            type = "proc";
          }
          {
            ratio = 3;
            child = [
              { type = "temp"; }
              { type = "disk"; }
            ];
          }
        ];
      }
      {
        ratio = 30;
        child = [
          { type = "net"; }
          { type = "mem"; }
        ];
      }
    ];

    styles = {
      battery = {
        high_battery_color = "green";
        low_battery_color = "red";
        medium_battery_color = "yellow";
      };

      cpu = {
        all_entry_color = "green";
        avg_entry_color = "reset";
        cpu_core_colors = [
          "red"
          "green"
          "yellow"
          "blue"
          "magenta"
          "cyan"
          "light red"
          "light green"
          "light yellow"
          "light blue"
          "light magenta"
          "light cyan"
        ];
      };

      graphs = {
        graph_color = "reset";
        legend_text = "reset";
      };

      memory = {
        arc_color = "light cyan";
        cache_color = "light red";
        gpu_colors = [
          "light blue"
          "light red"
          "cyan"
          "green"
          "blue"
          "red"
        ];
        ram_color = "light magenta";
        swap_color = "light yellow";
      };

      network = {
        rx_color = "green";
        rx_total_color = "light cyan";
        tx_color = "cyan";
        tx_total_color = "light green";
      };

      tables = {
        headers = "blue";
      };

      widgets = {
        border_color = "dark gray";
        disabled_text = "dark gray";
        selected_border_color = "blue";
        text = "reset";
        widget_title = "white";
        selected_text = {
          bg_color = "blue";
          color = "black";
        };
      };
    };
  };
in
{
  options.programs.bottom.enable = lib.mkEnableOption "bottom.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.bottom ];

    xdg.config.files = {
      "bottom/bottom.toml".source = toml.generate "bottom.toml" conf;
    };
  };
}
