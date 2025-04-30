#!/bin/bash


# forge-git-perso.sh — Initialisation Git runique
# 📜 Par les Scribes de Gjaldrheim


# Définition des runes personnelles
GIT_NAME="Okajin"
GIT_EMAIL="kocokajin@gmail.com"
GIT_REMOTE="git@github.com-okajin"

echo "🛠️  Invocation de la Forge Git Personnelle..."


# Vérifie s’il y a déjà un dépôt Git
if [ -d .git ]; then
  echo "⚠️  Un dépôt Git existe déjà dans ce répertoire."
else
  git init
  echo "✅ Dépôt Git initialisé."
fi


# Applique la configuration locale
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

echo "📛 Nom : $GIT_NAME"
echo "📫 Email : $GIT_EMAIL"

# Proposition d'ajout d’un remote
read -p "🌐 Veux-tu définir un remote vers GitHub perso ? (o/n) " response
if [[ "$response" == "o" ]]; then
  read -p "🗂️  Nom du repo (ex: okajin/type-tests) : " reponame
  git remote remove origin 2>/dev/null
  git remote add origin "$GIT_REMOTE:$reponame"
  echo "🔗 Remote ajouté : $GIT_REMOTE:$reponame"
fi


# Affiche le résultat
echo ""
echo "🔍 Configuration Git locale actuelle :"
git config --list --local

echo ""
echo "🔍 Vérification rapide du profil Git :"
echo "📛 Nom     : $(git config user.name)"
echo "📫 Email   : $(git config user.email)"
remote_url=$(git remote get-url origin 2>/dev/null || echo "Aucun")
echo "🌍 Remote  : $remote_url"

