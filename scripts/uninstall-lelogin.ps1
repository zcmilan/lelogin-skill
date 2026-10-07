param([switch]$Purge)
$ErrorActionPreference = "Stop"
$baseUrl = if ($env:LELOGIN_INSTALL_BASE_URL) { $env:LELOGIN_INSTALL_BASE_URL.TrimEnd("/") } else { "https://lelogin.nationauth.cn/lelogin/cmd" }
if (-not $baseUrl.StartsWith("https://")) { throw "LeLogin uninstaller requires an HTTPS origin" }
$target = Join-Path $env:TEMP "uninstall-lelogin.ps1"
Invoke-WebRequest -Uri "$baseUrl/uninstall-lelogin.ps1" -OutFile $target
$checksums = (Invoke-WebRequest -Uri "$baseUrl/SHA256SUMS").Content
$line = ($checksums -split "`n" | Where-Object { $_ -match "\s\*?uninstall-lelogin\.ps1\s*$" } | Select-Object -First 1)
if (-not $line) { throw "uninstall-lelogin.ps1 is absent from SHA256SUMS" }
$expected = ($line.Trim() -split "\s+")[0].ToLowerInvariant()
$actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $target).Hash.ToLowerInvariant()
if ($actual -ne $expected) { throw "Uninstaller checksum mismatch" }
& powershell -NoProfile -ExecutionPolicy Bypass -File $target -Purge:$Purge
