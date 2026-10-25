# Les outils de Daniel : guide d'installation

L'application fonctionne sur ordinateur et s'installe sur le téléphone comme une application classique. Elle repose sur deux services gratuits :

- **Supabase** garde l'inventaire et les fichiers (photos, notices, factures). Le téléphone et l'ordinateur voient les mêmes données, mises à jour en direct.
- **GitHub Pages** héberge l'application à une adresse du type `https://VOTRE-COMPTE.github.io/outils-daniel/`.

Comptez 20 à 30 minutes, une seule fois.

## Contenu du dossier

| Fichier | Rôle |
|---|---|
| `index.html` | L'application |
| `config.js` | Les deux codes de connexion à Supabase (à remplir à l'étape 1) |
| `manifest.webmanifest`, `sw.js`, `icons/` | Installation sur téléphone et consultation hors ligne |
| `supabase-installation.sql` | Création de la base, de la sécurité et reprise de la meuleuse Ryobi |

---

## Étape 1 : créer la base Supabase

1. Créez un compte gratuit sur **supabase.com**, puis cliquez sur **New project**.
   - Nom : `outils-daniel`
   - Mot de passe de la base : générez-le et gardez-le de côté (il ne servira pas au quotidien).
   - Région : **West EU (Paris)**.
2. Une fois le projet prêt, ouvrez **SQL Editor** > **New query**. Collez tout le contenu de `supabase-installation.sql`, puis cliquez sur **Run**. Le message « Success » doit s'afficher.
3. **Fermez les inscriptions** pour que personne d'autre ne puisse créer de compte : **Authentication** > **Sign In / Providers**, puis décochez **Allow new users to sign up**.
4. **Créez les comptes** : **Authentication** > **Users** > **Add user** > **Create new user**.
   - Saisissez l'e-mail et un mot de passe pour Daniel, et cochez **Auto Confirm User**.
   - Recommencez pour vous si vous voulez aussi y accéder.
5. **Récupérez les codes** : **Project Settings** > **API** (ou **Data API** / **API Keys** selon la version).
   - Copiez la **Project URL**.
   - Copiez la clé **anon public** (parfois appelée **Publishable key**).
6. Ouvrez `config.js` avec un éditeur de texte (Bloc-notes, TextEdit en mode texte brut) et collez les deux valeurs entre les guillemets :

   ```js
   window.OUTILS_CONFIG = {
     supabaseUrl: "https://xxxxxxxx.supabase.co",
     supabaseAnonKey: "eyJhbGciOi..."
   };
   ```

   Enregistrez le fichier.

> La clé « anon public » peut circuler sans danger : sans e-mail et mot de passe valides, la base ne donne accès à rien. Ne collez jamais la clé **service_role** ou **secret**.

## Étape 2 : mettre le site en ligne avec GitHub Pages

Le code est déjà déposé dans le dépôt GitHub `outils-daniel`.

1. **Renseignez les codes Supabase** dans le dépôt :
   - ouvrez le fichier `config.js` sur github.com, puis cliquez sur le crayon (**Edit this file**) ;
   - collez la Project URL et la clé anon public entre les guillemets ;
   - cliquez sur **Commit changes**.
2. **Activez GitHub Pages** : **Settings** > **Pages**.
   - Dans **Source**, choisissez **Deploy from a branch**.
   - Choisissez la branche **main** et le dossier **/ (root)**, puis cliquez sur **Save**.
3. Après une à deux minutes, l'adresse du site s'affiche en haut de la page **Pages**, par exemple `https://VOTRE-COMPTE.github.io/outils-daniel/`.
4. Ouvrez cette adresse et connectez-vous avec le compte de Daniel. La meuleuse Ryobi doit apparaître.

**Pour mettre à jour le site plus tard** : modifiez ou remplacez un fichier du dépôt. Le site se met à jour tout seul en une à deux minutes.

> Le dépôt peut rester public : il ne contient aucune donnée de l'inventaire. Les fiches et les fichiers sont dans Supabase, accessibles seulement après connexion. Un dépôt privé ne peut publier un site GitHub Pages qu'avec un abonnement payant.

## Étape 3 : installer l'application

**Sur un iPhone** :
1. Ouvrez l'adresse dans **Safari**.
2. Touchez **Partager** (le carré avec une flèche), puis **Sur l'écran d'accueil**.

**Sur un Android** :
1. Ouvrez l'adresse dans **Chrome**.
2. Ouvrez le menu **⋮**, puis touchez **Installer l'application** (ou **Ajouter à l'écran d'accueil**).

**Sur un ordinateur** :
1. Ouvrez l'adresse dans **Chrome** ou **Edge**.
2. Cliquez sur l'icône d'installation à droite de la barre d'adresse.

L'application s'ouvre ensuite dans sa propre fenêtre, avec l'icône « Outils ». La connexion est mémorisée : il n'y a pas besoin de ressaisir le mot de passe à chaque fois.

---

## Utilisation au quotidien

- **Ajouter un outil** : bouton « Ajouter » en bas à droite sur le téléphone. Le champ photo ouvre directement l'appareil photo.
- **Hors ligne** (cabane, grenier sans réseau) : l'inventaire reste consultable avec les dernières données chargées. Les modifications redeviennent possibles dès le retour du réseau.
- **Étiquettes QR** : bouton « Étiquettes QR », puis téléchargement d'une planche A4 de 24 étiquettes 70 × 37 mm. Imprimez à 100 %, sans mise à l'échelle. Scanner une étiquette avec l'appareil photo du téléphone ouvre la fiche de l'outil.
- **Export Excel** : il contient trois onglets (inventaire, accessoires, entretien).
- **Sauvegarde** : dans **Réglages** > **Télécharger une sauvegarde**, l'application produit un fichier JSON avec toutes les fiches. Ce fichier peut être réimporté au même endroit. Pensez à en faire une de temps en temps.

## Bon à savoir

- **Mise en veille de Supabase.** En formule gratuite, un projet sans aucune activité pendant une semaine est mis en pause. L'application affiche alors « Impossible de joindre la base ».
  - Pour le relancer : ouvrez supabase.com, choisissez le projet, puis cliquez sur **Restore project**. Il redémarre en quelques minutes, sans perte de données.
  - Ouvrir l'application au moins une fois par semaine suffit à l'éviter.
- **Limites gratuites** : 500 Mo de base et 1 Go de fichiers, largement assez pour des centaines d'outils. Les photos sont réduites automatiquement avant l'envoi.
- **Changer un mot de passe ou ajouter une personne** : Supabase > **Authentication** > **Users**.
- **Ajouter un lieu de rangement** : modifiez la liste `LIEUX` en haut du script dans `index.html`, puis enregistrez le fichier sur GitHub.
