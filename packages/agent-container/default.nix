{
  bashInteractive,
  dockerTools,
  pkgs,
  writeShellScriptBin,
}:
let
  tools = with pkgs; [
    bashInteractive
    coreutils
    curl
    fd
    github-copilot-cli
    gitMinimal
    jq
    ripgrep
  ];
in
{
  image = dockerTools.streamLayeredImage {
    name = "agent-container";
    tag = "latest";
    created = "now"; # Binary reproducibility is not important since we stream directly into podman load

    contents = tools ++ [ dockerTools.caCertificates ];

    extraCommands = ''
      mkdir -p etc tmp home/agent

      # Create users
      echo 'root:x:0:0:root:/root:/bin/sh' > etc/passwd
      echo 'agent:x:1000:1000:Agent:/home/agent:${bashInteractive}/bin/bash' >> etc/passwd

      # Create groups
      echo 'root:x:0:' > etc/group
      echo 'agent:x:1000:' >> etc/group

      # Install skills
      mkdir -p home/agent/.agents
      cp -r ${pkgs.customPackages.agent-skills} home/agent/.agents/skills
    '';

    fakeRootCommands = ''
      chown -R 1000:1000 /home/agent
      chmod 1777 /tmp
    '';

    enableFakechroot = true;

    config = {
      User = "1000:1000";
      WorkingDir = "/workspace";
      Cmd = [ "${bashInteractive}/bin/bash" ];
      Env = [
        "HOME=/home/agent"
        "USER=agent"
        "PATH=${pkgs.lib.makeBinPath tools}"
      ];
    };
  };

  # Use podman from system path to make script compatible on generic linux distros
  script = writeShellScriptBin "agent-exec" ''
    workspace="''${1:-$(pwd)}"
    podman run --rm -it \
        --network=host \
        --userns=keep-id \
        --security-opt=no-new-privileges \
        -v "$workspace:/workspace:Z" \
        -v "$HOME/.copilot:/home/agent/.copilot:Z" \
        agent-container:latest
  '';
}
