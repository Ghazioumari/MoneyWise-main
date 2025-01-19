# Fonction pour générer le fichier de configuration
function Generate-EnvConfig {
    param (
        [string]$Environment,
        [string]$OutputPath
    )
    
    $config = @"
# Configuration pour l'environnement $Environment
# À utiliser comme référence pour configurer les variables dans Azure DevOps

Variables requises pour $Environment :

IIS_AUTH_USERNAME=admin_$Environment
# IIS_AUTH_PASSWORD doit être défini comme secret dans Azure DevOps
IIS_SERVER_IP=192.168.1.x # Remplacer par l'IP réelle du serveur $Environment
ANSIBLE_WIN_USER=ansible_$Environment
# ANSIBLE_WIN_PASS doit être défini comme secret dans Azure DevOps

Instructions :
1. Créez un groupe de variables 'moneywise-$Environment' dans Azure DevOps
2. Ajoutez chaque variable ci-dessus
3. Marquez les mots de passe comme secrets
4. Liez ce groupe au pipeline CD
"@

    # Créer le dossier s'il n'existe pas
    $folder = Split-Path $OutputPath
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }

    # Écrire le fichier
    $config | Out-File -FilePath $OutputPath -Encoding UTF8
    Write-Host "Configuration pour $Environment générée dans $OutputPath"
}

# Générer les configurations pour chaque environnement
$environments = @("dev", "staging", "prod")
foreach ($env in $environments) {
    $outputPath = "$PSScriptRoot\..\configs\$env-variables.txt"
    Generate-EnvConfig -Environment $env -OutputPath $outputPath
}

Write-Host "`nConfigurations générées avec succès !"
Write-Host "Utilisez ces fichiers comme référence pour configurer vos variables dans Azure DevOps"
