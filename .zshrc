# ~/.zshrc — Tronc générique

# Détection du répertoire des dotfiles
DOTFILES_DIR="$HOME/dotfiles-gjaldrheim"

# Chargement centralisé (distribue vers init ou équivalent)
if [ -f "$DOTFILES_DIR/init.sh" ]; then
  source "$DOTFILES_DIR/init.sh"
else
  echo "⚠️  Aucun init.sh trouvé dans $DOTFILES_DIR"
fi

