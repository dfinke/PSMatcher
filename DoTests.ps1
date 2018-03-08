$PSVersionTable

#if ((Get-Module -ListAvailable pester) -eq $null) {
    Install-Module -Name Pester -Repository PSGallery -Force -Scope CurrentUser
#} else {
#    Update-Module -Name Pester -Repository PSGallery -Force -Scope CurrentUser
#}

Invoke-Pester