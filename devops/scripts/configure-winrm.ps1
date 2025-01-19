$ErrorActionPreference = "Stop"

# Activer WinRM
winrm quickconfig -q
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Configurer les règles du pare-feu
New-NetFirewallRule -Name "WinRM-HTTP" -DisplayName "WinRM HTTP" -Enabled True -Profile Any -Action Allow -Direction Inbound -Protocol TCP -LocalPort 5985

Write-Host "Configuration WinRM terminée. Testez la connexion avec : "
Write-Host "Test-WSMan -ComputerName localhost"

# Créer l'utilisateur Ansible si non existant
$ansibleUsername = "ansible_admin"
$ansiblePassword = "AnsiblePass123!"

try {
    $user = Get-LocalUser -Name $ansibleUsername -ErrorAction SilentlyContinue
    if ($user -eq $null) {
        New-LocalUser -Name $ansibleUsername `
                     -Password (ConvertTo-SecureString $ansiblePassword -AsPlainText -Force) `
                     -FullName "Ansible Admin" `
                     -Description "Compte pour Ansible" `
                     -AccountNeverExpires
        
        Add-LocalGroupMember -Group "Administrators" -Member $ansibleUsername
        Write-Host "Utilisateur Ansible créé avec succès"
    } else {
        Write-Host "L'utilisateur Ansible existe déjà"
    }
} catch {
    Write-Error "Erreur lors de la création de l'utilisateur Ansible : $_"
}
