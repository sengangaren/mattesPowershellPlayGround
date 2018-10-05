 #!Powershell
<#
Testing some Powershell stuff
#>

function Start-Test {
    Write-Output "Start testing"
    Get-Users
    Write-Output "End testing"
}


    ## Remove User from group
    # Get connection
    $Computer = $env:COMPUTERNAME
    $GroupName = 'TestGroup'
    $ADSI = [ADSI]("WinNT://$Computer")
    $Group = $ADSI.Children.Find($GroupName, 'group')
    
    # Remove The user
    $User = $env:USERNAME
    $Group.Remove(("WinNT://$computer/$user")) 
}
function Test-LocalUsers {
    New-LocalGroup -Name "TestGroup" 
}

Start-Test