function update --description "Update Arch system and perform package maintenance"
    sudo pacman -Syu
    sudo pacman -Rns (pacman -Qqtd)
    sudo paccache -r -v -k 3
    sudo paccache -r -u -v -k 0
end
