function kernels
    curl -s "https://www.kernel.org/releases.json" | jq -r '
      .releases[] |
        "\u001b[1m\(.moniker):\u001b[0m \(.version) (\(.released.isodate))"
    '
end
