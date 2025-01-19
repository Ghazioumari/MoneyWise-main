Write-Host "Checking prerequisites..."

$tools = @{
    "git" = "git --version"
    "docker" = "docker --version"
    "terraform" = "terraform --version"
    "virtualbox" = "VBoxManage --version"
}

foreach ($tool in $tools.Keys) {
    Write-Host "Checking $tool..."
    try {
        Invoke-Expression $tools[$tool] | Out-Null
        Write-Host "$tool is installed" -ForegroundColor Green
    }
    catch {
        Write-Host "$tool is not installed" -ForegroundColor Red
    }
}

# Check if ports are available
$ports = @(3000, 8081, 3307, 9090, 9093, 3000)
foreach ($port in $ports) {
    $test = Test-NetConnection -ComputerName localhost -Port $port -WarningAction SilentlyContinue -InformationLevel Quiet
    if ($test) {
        Write-Host "Port $port is in use" -ForegroundColor Red
    } else {
        Write-Host "Port $port is available" -ForegroundColor Green
    }
}
