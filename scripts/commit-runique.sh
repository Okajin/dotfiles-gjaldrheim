#!/bin/bash

# --- Couleurs Runomantiques de Gjaldrheim ---

COLOR_SUCCESS=$(tput setaf 35)   # Vert mousse
COLOR_FAIL=$(tput setaf 160)     # Rouge forge
COLOR_TEXT=$(tput setaf 136)     # Bronze mystique
COLOR_DIM=$(tput setaf 245)      # Gris pierre
BOLD=$(tput bold)
RESET=$(tput sgr0)

say_runefail() {
  echo -e "\n💥 ${COLOR_FAIL}${BOLD}La forge a refusé ta rune...${RESET}"
  echo "${COLOR_DIM}   🧱 Reviens avec un acier plus affûté, Gardien.${RESET}"
  echo "${COLOR_FAIL}   ❌ [Rune Rejetée]${RESET}"
}

# --- Choix du type de commit ---
echo -e "${COLOR_TEXT}${BOLD}Quelle rune veux-tu forger ?${RESET}"
select type in "feat" "fix" "chore" "refactor" "test" "style" "docs" "build"; do
  case $type in
    feat) emoji="✨" ;;   # Nouvelle fonctionnalité
    fix) emoji="🐛" ;;    # Correction de bug
    chore) emoji="🔧" ;;  # Tâches diverses
    refactor) emoji="♻️" ;; # Refactorisation de code
    test) emoji="🧪" ;;   # Ajout/modification de tests
    style) emoji="🎨" ;;  # Modifications de style/code
    docs) emoji="📚" ;;   # Documentation
    build) emoji="🏗️" ;;  # Modifications de build
    *) echo -e "${COLOR_FAIL}Type inconnu. Annulation.${RESET}"; exit 1 ;;
  esac
  break
done

# --- Saisie du message de commit ---
read -p "$(echo -e ${COLOR_TEXT}Forge ton message runique :${RESET} ) " message

# --- Option : ajouter tous les fichiers modifiés ---

read -p "$(echo -e ${COLOR_TEXT}💡 Ajouter tous les fichiers modifiés avant de forger ? (o/N)${RESET} ) " add_all
if [[ "$add_all" =~ ^[Oo]$ ]]; then
  git add .
  echo -e "${COLOR_SUCCESS}📜 Tous les fichiers ont été gravés sur l’enclume.${RESET}"
fi

# --- Construction du message complet ---
full_message="$emoji $type: $message"

# --- Vérification des changements en attente ---

if git diff --cached --quiet; then
  echo -e "${COLOR_FAIL}⚠️  Rien à commit forge vide. Abandon de la gravure.${RESET}"
  exit 1
fi

# --- Confirmation et Exécution ---
echo -e "\n${COLOR_TEXT}${BOLD}⚡ Préparation de la gravure...${RESET}"
echo -e "${COLOR_TEXT}Message final :${RESET} ${COLOR_SUCCESS}$full_message${RESET}"
echo -e "${COLOR_DIM}Fichiers en attente :${RESET}"
git diff --cached --name-only

read -p "$(echo -e ${COLOR_TEXT}✅ Confirmer la gravure de cette rune ? (o/N)${RESET} ) " confirm
if [[ ! "$confirm" =~ ^[Oo]$ ]]; then
  say_runefail
  exit 1
fi

# --- Gravure de la rune ---
git commit -m "$full_message"
echo -e "\n${COLOR_SUCCESS}${BOLD}🪓 Rune gravée avec succès ! Gloire à Gjaldrheim.${RESET}"
