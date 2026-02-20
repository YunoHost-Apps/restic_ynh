**[Restic](https://restic.net/)** est un outil de sauvegarde sécurisé et efficace pour sauvegarder votre serveur vers un stockage externe.

### Fonctionnalités
- **Plusieurs types de stockage** : Prise en charge de tous les backends compatibles avec Restic (SFTP, S3, Backblaze B2, Azure, etc.). **SFTP est recommandé** pour sa simplicité.
- **Déduplication et compression** : Économise de l'espace en supprimant les doublons et en compressant les données.
- **Chiffrement** : Les données sont chiffrées avant d'être envoyées vers le stockage externe.
- **Flexibilité** : Possibilité d'installer plusieurs instances pour sauvegarder vers différents emplacements ou définir des fréquences personnalisées.

### Configuration
- **SFTP** : Une clé SSH sera générée lors de l'installation. Vous devrez l'autoriser sur votre serveur de destination.
- **Autres backends** : Après l'installation, configurez les variables d'environnement requises dans le **Panneau de configuration**.