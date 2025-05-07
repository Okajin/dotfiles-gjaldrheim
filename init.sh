# ~/dotfiles-gjaldrheim/init.sh

# 🔔 Alerte visuelle et sonore en cas d’échec de rune
say_runefail() {
  local msg="🔥 Une rune a échoué à se graver ! ($1)"
  echo "$msg"
  if command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -Command "New-BurntToastNotification -Text 'Forge de Gjaldrheim', '$msg'" 2>/dev/null
  fi
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

echo -ne "\033]0;Forge de Gjaldrheim ⚒️  \007"
echo "🛡️  Bienvenue, Gardien de Gjaldrheim ! La forge est chaude et l'acier t'attend..."

eval "$(starship init zsh)" && echo "✅ Starship init OK" || echo "❌ Starship init FAIL"
export LANG=en_US.UTF-8

source_rune "$HOME/dotfiles-gjaldrheim/aliases_common"

if grep -qiE "(microsoft|wsl)" /proc/version; then
  export GJ_ENV="wsl"
elif [ "$(uname -s)" = "Linux" ]; then
  export GJ_ENV="linux"
else
  export GJ_ENV="unknown"
fi

echo "🔧 Chargement des runes pour environnement : $GJ_ENV"

[ "$GJ_ENV" = "wsl" ]   && source_rune "$HOME/dotfiles-gjaldrheim/aliases_wsl"
[ "$GJ_ENV" = "linux" ] && source_rune "$HOME/dotfiles-gjaldrheim/aliases_debian"

echo ">>> Chargement init.sh terminé avec succès"

