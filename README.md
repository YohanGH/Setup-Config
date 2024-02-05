```
# **************************************************************************** #
#                                                                              #
#                                                         .--.    No           #
#    README.md                                           |o_o |    Pain        #
#                                                        |:_/ |     No         #
#    By: YohanGH <YohanGH@proton.me>                    //    ''     Code      #
#                                                      (|     | )              #
#    Created: 2024/02/05 08:57:27 by YohanGH           '__   _/_               #
#    Updated: 2024/02/05 10:47:50 by YohanGH          (___)=(___)              #
#                                                                              #
# **************************************************************************** #
```

# Configuration de l'Environnement macOS pour le Développement

Ce dépôt contient un script Bash pour configurer automatiquement un nouvel environnement de développement sur macOS. Il installe et configure des outils essentiels pour le développement, incluant des utilitaires de ligne de commande et des applications communes utilisées par les développeurs.

## Fonctionnalités

Le script automatise les tâches suivantes :

- Installation de Homebrew, le gestionnaire de paquets pour macOS.
- Installation des outils de ligne de commande essentiels : `git`, `curl`, `tree`.
- Installation d'utilitaires de développement supplémentaires :
    - `htop` : un outil interactif pour surveiller les processus et l'utilisation des ressources.
    - `tldr` : une version simplifiée et plus accessible des pages man.
    - `jq` : un outil pour manipuler des données JSON.
    - `fzf` : un chercheur de fichiers en ligne de commande avec un filtre interactif.
    - `httpie` : un client HTTP moderne et convivial.
    - `tmux` : un multiplexeur de terminal pour gérer plusieurs sessions de terminal dans une seule fenêtre.
    - `python3` : la dernière version de Python pour le développement en Python.

## Prérequis

- macOS 
- Accès à Internet pour télécharger les paquets et outils nécessaires.

## Utilisation

Pour utiliser ce script :

1. Téléchargez le script `setup-config.sh` depuis ce dépôt.
2. Ouvrez le Terminal.
3. Accordez les droits d'exécution au script avec la commande :
    
    bashCopy code
    
    `chmod +x setup-config.sh`
    
4. Exécutez le script avec :
    
    bashCopy code
    
    `./setup-config.sh`
    
5. Suivez les instructions à l'écran pour terminer la configuration.

## Personnalisation

Vous pouvez personnaliser ce script en modifiant la liste des dépendances dans la section dédiée du script. Ajoutez ou retirez des outils selon vos besoins de développement spécifiques.

## Contribution

Les contributions à ce script sont les bienvenues. Si vous avez des suggestions d'amélioration ou des outils supplémentaires à inclure, n'hésitez pas à créer une issue ou un pull request.

## Licence

Ce script est distribué sous la licence GPL. Voir le fichier `LICENSE` pour plus de détails.
