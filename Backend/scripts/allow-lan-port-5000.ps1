#Requires -RunAsAdministrator
<#
  Allow inbound TCP 5000 on Private + Domain profiles so LAN devices (e.g. ESP32)
  can reach the Node backend. Curl on the same PC often works without this.

  Run elevated:
    cd Backend\scripts
    powershell -ExecutionPolicy Bypass -File .\allow-lan-port-5000.ps1
#>

$ruleDisplayName = "Smart Agriculture API TCP 5000 (LAN)"

$existing = Get-NetFirewallRule -DisplayName $ruleDisplayName -ErrorAction SilentlyContinue
if ($existing) {
  Remove-NetFirewallRule -DisplayName $ruleDisplayName -Confirm:$false
  Write-Host "Removed previous rule: $ruleDisplayName"
}

$null = New-NetFirewallRule `
  -DisplayName $ruleDisplayName `
  -Direction Inbound `
  -Action Allow `
  -Protocol TCP `
  -LocalPort 5000 `
  -Profile Private, Domain `
  -Description "LAN access to Smart Agriculture API (Node) on TCP 5000"

Write-Host "Firewall rule added: $ruleDisplayName (TCP 5000, Private + Domain)."
Write-Host "Set your Wi-Fi to Private (not Public). If ESP32 still fails, check router AP/client isolation."
