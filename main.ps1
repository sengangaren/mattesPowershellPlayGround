 #!Powershell
<#
Testing some Powershell stuff
#>

function Start-Test {
    Write-Output "Start testing"
    Get-Users
    Write-Output "End testing"
}


function Test-LocalUsers {
    Get-Users
    New-LocalGroup -Name "TestGroup" 
}

Start-Test