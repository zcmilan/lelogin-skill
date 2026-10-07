$ErrorActionPreference = "Stop"
$baseUrl = if ($env:LELOGIN_INSTALL_BASE_URL) { $env:LELOGIN_INSTALL_BASE_URL.TrimEnd("/") } else { "https://lelogin.nationauth.cn/lelogin/cmd" }
if (-not $baseUrl.StartsWith("https://")) { throw "LeLogin installer requires an HTTPS origin" }
$installer = Join-Path $env:TEMP "install-lelogin.bat"
Invoke-WebRequest -Uri "$baseUrl/install-lelogin.bat" -OutFile $installer
$checksums = (Invoke-WebRequest -Uri "$baseUrl/SHA256SUMS").Content
$line = ($checksums -split "`n" | Where-Object { $_ -match "\s\*?install-lelogin\.bat\s*$" } | Select-Object -First 1)
if (-not $line) { throw "install-lelogin.bat is absent from SHA256SUMS" }
$expected = ($line.Trim() -split "\s+")[0].ToLowerInvariant()
$actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $installer).Hash.ToLowerInvariant()
if ($actual -ne $expected) { throw "Installer checksum mismatch" }
$env:LELOGIN_SKIP_AGENT_SKILL = "1"
& $installer
if ($LASTEXITCODE -ne 0) { throw "LeLogin installer failed with exit code $LASTEXITCODE" }
$installDir = if ($env:LELOGIN_INSTALL_DIR) { $env:LELOGIN_INSTALL_DIR } else { Join-Path $env:USERPROFILE ".local\bin" }
$installedCli = Join-Path $installDir "lelogin.exe"
& $installedCli --help
if ($LASTEXITCODE -ne 0) { throw "LeLogin CLI verification failed with exit code $LASTEXITCODE" }
& $installedCli runtime status
if ($LASTEXITCODE -ne 0) { throw "LeLogin runtime verification failed with exit code $LASTEXITCODE" }
