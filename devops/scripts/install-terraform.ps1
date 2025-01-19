# Créer un dossier pour Terraform
$terraformPath = "C:\terraform"
if (-not (Test-Path -Path $terraformPath)) {
    New-Item -ItemType Directory -Path $terraformPath
}

# Télécharger Terraform
$terraformUrl = "https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_windows_amd64.zip"
$zipPath = "$terraformPath\terraform.zip"
Write-Host "Téléchargement de Terraform..."
Invoke-WebRequest -Uri $terraformUrl -OutFile $zipPath

# Extraire le fichier
Write-Host "Extraction de Terraform..."
Expand-Archive -Path $zipPath -DestinationPath $terraformPath -Force

# Ajouter au PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$terraformPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$terraformPath", "User")
    Write-Host "Terraform ajouté au PATH"
}

# Nettoyer
Remove-Item $zipPath
Write-Host "Installation terminée. Veuillez redémarrer votre terminal pour que les changements prennent effet."

# Vérifier l'installation
try {
    $version = terraform --version
    Write-Host "Terraform installé avec succès : $version"
} catch {
    Write-Host "Erreur lors de la vérification de l'installation de Terraform"
}
