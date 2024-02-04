# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    setup-configs.sh                                    |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/02/04 15:04:28 by YohanGH           '__   _/_               #
#    Updated: 2024/02/04 15:18:53 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Fonction pour vérifier la réussite du clonage/mise à jour
check_success() {
    if [ $? -eq 0 ]; then
        echo "Succès."
    else
        echo "Une erreur s'est produite. Vérifiez les messages d'erreur ci-dessus."
        exit 1
    fi
}

# Fonction pour cloner ou mettre à jour un dépôt
clone_or_update_repo() {
    local repo_url=$1
    local target_dir=$2
    local repo_name=$(basename $repo_url)

    echo "Traitement de $repo_name..."

    if [ -d "$target_dir/.git" ]; then
        echo "Mise à jour du dépôt $repo_name..."
        git -C "$target_dir" pull
        check_success
    else
        echo "Clonage du dépôt $repo_name vers $target_dir..."
        git clone $repo_url "$target_dir"
        check_success
    fi
}

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
if [ ! -d "$P10K_DIR/.git" ]; then
    echo "Installation de Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10K_DIR
    check_success
else
    echo "Powerlevel10k est déjà installé."
fi

# Déplacez les fichiers de configuration, s'ils existent
echo "Déplacement des fichiers de configuration..."
if [ -f "$CONFIG_ZSHRC_DIR/zshrc" ]; then
    cp "$CONFIG_ZSHRC_DIR/zshrc" "$HOME/.zshrc"
else
    echo "Le fichier zshrc est introuvable, vérifiez le dépôt $CONFIG_ZSHRC_URL."
fi

if [ -f "$CONFIG_VIM_DIR/vimrc" ]; then
    cp "$CONFIG_VIM_DIR/vimrc" "$HOME/.vimrc"
else
    echo "Le fichier vimrc est introuvable, vérifiez le dépôt $CONFIG_VIM_URL."
fi

echo "Configuration terminée."

