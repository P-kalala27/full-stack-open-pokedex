
#verifier si il y a des changements à commit
if git diff --exit-code --quiet HEAD && git diff --exit-code --quiet origin/main; then
    echo "No changes to commit"
    exit 0
fi

#Récupérer la branche actuelle 
current_branch=$(git branch --show-current)

#verifier si la branche est main
if [ "$current_branch" != "main" ]; then
    echo "Current branch is not main"
    exit 1
fi

#afficher le fichier modifiés
echo "Files modified:"
git status -s

#Demander le message du commit
if [ -n "$1" ]; then
    commit_message="$1"
else
    read -p "📝 Message du commit : " commit_message
fi



git add -u 

# Vérifier s'il y a des fichiers non suivis
untracked_files=$(git ls-files --others --exclude-standard)
if [[ -n "$untracked_files" ]]; then
    echo "⚠️ Fichiers non suivis détectés :"
    echo "$untracked_files"
    read -p "Voulez-vous les ajouter ? (y/n) : " add_untracked
    if [[ "$add_untracked" == "y" ]]; then
        git add .
    fi
fi


#valider le commit 
if git commit -m "$commit_message"; then
    echo "Commit validé avec succès !"
else
    echo "Erreur lors de la validation du commit"
    exit 1
fi

# Pousser les changements
if git push origin "$current_branch"; then
    echo "🚀 Code poussé avec succès sur la branche '$current_branch'."
else
    echo "❌ Erreur lors du push. Vérifie ta connexion ou tes permissions."
    exit 1
fi
