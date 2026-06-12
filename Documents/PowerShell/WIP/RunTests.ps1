# RunTests.ps1

# Ensure Pester is available before running tests
if (-not (Get-Module -ListAvailable -Name Pester)) {
    Write-Warning "❌ Pester is not installed. Run:"
    Write-Host   "`n    Install-Module Pester -Force -SkipPublisherCheck" -ForegroundColor Yellow
    exit 1
}

# Run all tests in the Tests/ folder
Invoke-Pester -Script './Tests' -Output Detailed

