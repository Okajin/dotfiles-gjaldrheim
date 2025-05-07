# ~/.zshrc
# 🔔 Alerte visuelle et sonore en cas d’échec de rune
say_runefail() {
  local msg="🔥 Une rune a échoué à se graver ! ($1)"
  echo "$msg"
  # Notification WSL (Windows only)
  if command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -Command "New-BurntToastNotification -Text 'Forge de Gjaldrheim', '$msg'" 2>/dev/null
  fi
  # Bip terminal (optionnel)
  echo -ne "\a"
}

# 🧙‍♂️ Fonction de chargement stylisé des runes
source_rune() {
  local rune="$1"
  if [ -f "$rune" ]; then
    if source "$rune"; then
      echo "✨ Rune chargée : $rune"
    else
      say_runefail "$rune"
    fi
  else
    echo "⚠️  Rune manquante : $rune"
  fi
}

# 🪓 Nom de fenêtre
echo -ne "\033]0;Forge de Gjaldrheim ⚒️  \007"

# 🛡️ Message d’accueil
echo "🛡️  Bienvenue, Gardien de Gjaldrheim ! La forge est chaude et l'acier t'attend..."

eval "$(starship init zsh)" && echo "✅ Starship init OK" || echo "❌ Starship init FAIL"

# 🌍 Locales
export LANG=en_US.UTF-8

# 🛠️ Chargement des alias
# Alias communs
source_rune "$HOME/dotfiles-gjaldrheim/aliases_common"

# 🔍 Détection d’environnement
if grep -qiE "(microsoft|wsl)" /proc/version; then
  export GJ_ENV="wsl"
elif [ "$(uname -s)" = "Linux" ]; then
  export GJ_ENV="linux"
else
  export GJ_ENV="unknown"
fi

# Alias spécifiques selon environnement
echo "🔧 Chargement des runes pour environnement : $GJ_ENV"

[ "$GJ_ENV" = "wsl" ]   && source_rune "$HOME/dotfiles-gjaldrheim/aliases_wsl"
[ "$GJ_ENV" = "linux" ] && source_rune "$HOME/dotfiles-gjaldrheim/aliases_debian"

echo ">>> Chargement .zshrc terminé avec succès"
