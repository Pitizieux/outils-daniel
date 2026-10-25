# Les outils de Daniel

Application web d'inventaire de l'atelier de Daniel : où est rangé chaque outil, à qui il est prêté, ses notices, ses accessoires, son entretien et sa garantie.

Elle fonctionne dans le navigateur sur ordinateur et s'installe sur le téléphone comme une application (PWA). Les données sont synchronisées entre les appareils via Supabase.

## Fonctions

- Fiche par outil : désignation, référence, marque, modèle, caractéristiques, photo
- Localisation : garage, grenier, cabane porte 1 ou porte 2, avec un emplacement précis
- Prêts : emprunteur, date, retour prévu, retards signalés, historique
- Documents : notice, vue éclatée, facture (fichiers privés) et liens
- Accessoires possédés ou non, entretien périodique, consommables
- Achat et garantie avec date de fin calculée
- Recherche par mots-clés et filtres
- Étiquettes QR à imprimer (planche A4 de 24 étiquettes 70 × 37 mm)
- Export Excel, sauvegarde et import JSON
- Consultation hors ligne

## Installation

Voir [GUIDE-INSTALLATION.md](GUIDE-INSTALLATION.md) : création de la base Supabase (`supabase-installation.sql`), renseignement de `config.js`, activation de GitHub Pages, installation sur téléphone.

## Fichiers

| Fichier | Rôle |
|---|---|
| `index.html` | L'application |
| `config.js` | Adresse et clé publique du projet Supabase |
| `manifest.webmanifest`, `sw.js`, `icons/` | Installation et fonctionnement hors ligne |
| `supabase-installation.sql` | Tables, sécurité, stockage des fichiers et reprise des données |
