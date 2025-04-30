#!/bin/bash

# --- Choix du type de commit ---
echo "Quelle rune veux-tu forger ?"
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
    *) echo "Type inconnu. Annulation."; exit 1 ;;
  esac
  break
done

# --- Saisie du message de commit ---
read -p "Forge ton message runique : " message

# --- Option : ajouter tous les fichiers modifiés ---

read -p "💡 Ajouter tous les fichiers modifiés avant de forger ? (o/N) " add_all
if [[ "$add_all" =~ ^[Oo]$ ]]; then
  git add .
  echo "📜 Tous les fichiers ont été gravés sur l’enclume."
fi

# --- Construction du message complet ---
full_message="$emoji $type: $message"

# --- Vérification des changements en attente ---

if git diff --cached --quiet; then
  echo "⚠️  Rien à commit forge vide. Abandon de la gravure."
  exit 1
fi

# --- Confirmation et Exécution ---
echo -e "\n⚡ Préparation de la gravure..."
echo "Message final : $full_message"
echo "Fichiers en attente :"
git diff --cached --name-only

read -p "✅ Confirmer la gravure de cette rune ? (o/N) " confirm
if [[ ! "$confirm" =~ ^[Oo]$ ]]; then
