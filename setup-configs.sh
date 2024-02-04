# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    setup-configs.sh                                    |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/02/04 15:04:28 by YohanGH           '__   _/_               #
#    Updated: 2024/02/04 16:45:35 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

echo "Début de la configuration de l'environnement..."

# Fonction pour afficher une barre de progression simple
progress_bar() {
    echo -n "Progression : ["
    for i in {1..50}; do
        sleep 0.02
        echo -n "#"
    done
    echo "] Terminé!"
}

echo "-----"

# Fonction pour vérifier la réussite du clonage/mise à jour
check_success() {
    if [ $? -eq 0 ]; then
        echo "Succès."
    else
        echo "Une erreur s'est produite. Vérifiez les messages d'erreur ci-dessus."
        exit 1
    fi
}

echo "-----"

# Fonction pour cloner ou mettre à jour un dépôt
clone_or_update_repo() {
    local repo_url=$1
    local target_dir=$2
    local repo_name=$(basename $repo_url)

    echo -e "\nTraitement de $repo_name..."
    progress_bar

    if [ -d "$target_dir/.git" ]; then
        echo -e "\nMise à jour du dépôt $repo_name..."
        git -C "$target_dir" pull
        check_success
    else
        echo -e "\nClonage du dépôt $repo_name vers $target_dir..."
        git clone $repo_url "$target_dir"
        check_success
    fi
}

echo "-----"

# Installation d'Oh My Zsh
echo -e "\nInstallation d'Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
progress_bar
check_success

# Configuration pour zshrc et Vim
CONFIG_ZSHRC_URL="https://github.com/YohanGH/Configuration_zshrc"
CONFIG_VIM_URL="https://github.com/YohanGH/Configuration_Vim"
CONFIG_ZSHRC_DIR="$HOME/.config/zsh"
CONFIG_VIM_DIR="$HOME/.vim"

# Téléchargement et installation de plugins zsh et Powerlevel10k
ZSH_AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
ZSH_SYNTAX_HIGHLIGHTING_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Création des répertoires s'ils n'existent pas
mkdir -p $CONFIG_ZSHRC_DIR
mkdir -p $CONFIG_VIM_DIR

# Téléchargez et configurez zshrc, Vim, zsh-autosuggestions, et zsh-syntax-highlighting
clone_or_update_repo $CONFIG_ZSHRC_URL $CONFIG_ZSHRC_DIR
clone_or_update_repo $CONFIG_VIM_URL $CONFIG_VIM_DIR
clone_or_update_repo https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTIONS_DIR
clone_or_update_repo https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_SYNTAX_HIGHLIGHTING_DIR

# Téléchargez et installez Powerlevel10k
echo -e "\nInstallation de Powerlevel10k..."
if [ ! -d "$P10K_DIR/.git" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10K_DIR
    progress_bar
    check_success
else
    echo "Powerlevel10k est déjà installé."
fi

echo "-----"

# Déplacez les fichiers de configuration, s'ils existent
echo -e "\nDéplacement des fichiers de configuration..."
if [ -f "$CONFIG_ZSHRC_DIR/zshrc" ]; then
    cp "$CONFIG_ZSHRC_DIR/zshrc" "$HOME/.zshrc"
else
    echo "Le fichier zshrc est introuvable, vérifiez le dépôt $CONFIG_ZSHRC_URL."
fi

if [ -f "$CONFIG_VIM_DIR/vimrc" ]; then
    cp "$CONFIG_VIM_DIR/.vimrc" "$HOME/.vimrc"
else
    echo "Le fichier vimrc est introuvable, vérifiez le dépôt $CONFIG_VIM_URL."
fi

echo "---------------------------------------------------------------------"

# Emplacement de base pour la création de l'arborescence GTD
BASE_DIR="$HOME/Documents/GTD"

# Liste des chemins de dossiers à créer
declare -a FOLDERS=(
    "1_In-Box"
    "Activable-NON/Incubation"
    "Activable-NON/Références/Contacts/Professionnelle"
    "Activable-NON/Références/Contacts/Personnel"
    "Activable-NON/Références/DataBase"
    "Activable-NON/Références/Documents/Textuel"
    "Activable-NON/Références/Documents/images"
    "Activable-NON/Références/Documents/PDF"
    "Activable-NON/Références/Documents/Autres"
    "Activable-NON/Références/Livres"
    "Activable-OUI/EnAttente/Professionnel"
    "Activable-OUI/EnAttente/Personnel"
    "Activable-OUI/Projets/Professionnel/DevOps"
    "Activable-OUI/Projets/Professionnel/Docker"
    "Activable-OUI/Projets/Professionnel/Testing"
    "Activable-OUI/Projets/Professionnel/GitHub"
    "Activable-OUI/Projets/Professionnel/Administration"
    "Activable-OUI/Projets/Personnel/DevOps"
    "Activable-OUI/Projets/Personnel/Docker"
    "Activable-OUI/Projets/Personnel/Testing"
    "Activable-OUI/Projets/Personnel/GitHub"
    "Activable-OUI/Projets/Personnel/Administration"
    "Activable-OUI/Sous-Traitez/En Attente"
    "Liste-Contrôle"
    "Idées-Réflexions/Post-it"
    "Archives/Note-Quotidienne"
    "Archives/Professionnel"
    "Archives/Agenda"
    "Archives/Personnel"
    "Template"
)

echo "-----"

# Fonction pour afficher l'arborescence en cours de création
print_tree() {
    local folder=$1
    local prefix="|---"
    # Remplace les slashs par des barres verticales pour simuler une structure d'arbre
    local tree_path=$(echo "$folder" | sed 's:/:/|---:g')
    echo -e "${prefix}${tree_path}"
}

echo "Création de l'arborescence GTD dans $BASE_DIR :"

echo "-----"

# Création de l'arborescence
for folder in "${FOLDERS[@]}"; do
    mkdir -p "$BASE_DIR/$folder"
    print_tree "$folder"
done

echo "-----"

echo "L'arborescence GTD a été créée avec succès dans $BASE_DIR."

echo "---------------------------------------------------------------------"

echo -e "\nConfiguration terminée."
