#!/bin/bash

echo "Installing discord-canary..."
yay -S --noconfirm discord-canary

echo "Installing Vencord..."
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"

echo "Done."
