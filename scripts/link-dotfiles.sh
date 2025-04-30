#!/bin/bash
echo "🛠️  Invocation des symlinks de la Forge Gjaldrheim..."

# Fichiers Zsh
ln -sf "$HOME/dotfiles-gjaldrheim/zshrc" "$HOME/.zshrc" &&
echo "🔗 .zshrc lié à dotfiles-gjaldrheim"

ln -sf "$HOME/dotfiles-gjaldrheim/aliases_gjaldrheim" "$HOME/.zsh_aliases" &&
echo "🔗 .zsh_aliases lié à aliases_gjaldrheim"

# Alacritty (sous WSL)
mkdir -p "$HOME/.config/alacritty"
ln -sf "$HOME/dotfiles-gjaldrheim/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml" &&
echo "🔗 alacritty.yml lié à ~/.config/alacritty/"

echo "✅ Tous les symlinks de la Forge sont en place !"

