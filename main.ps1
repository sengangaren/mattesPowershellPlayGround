 #!Powershell
<#
Testing some Powershell stuff
#>

function Start-Test {
    Write-Output "Start testing"
    Get-Users
    Write-Output "End testing"
}

# Thanks to: 
# Boe Prox@mcpmag <https://mcpmag.com/articles/2015/05/28/managing-local-groups-in-powershell.aspx>
function Test-ADSI {
    # Active Directory Service Interface
    # Make ADSI connection
    $Computer = $env:COMPUTERNAME
    $ADSI = [ADSI]("WinNT://$Computer")

    # Create Local group object
    $Group = $ADSI.Create('Group', 'TestGroup') 

    # Write object to account database
    $Group.SetInfo()

    # Change group-definition
    $Group.Description  = 'This is a  test group for whatever'
    $Group.SetInfo()

    ## Remove Group ##
    # Initiating
    $Computer = $env:COMPUTERNAME
    $GroupName = 'TestGroup'
    $ADSI = [ADSI]("WinNT://$Computer")

    # Locate the group
    $Group = $ADSI.Children.Find($GroupName, 'group')

    # Remove the group
    $ADSI.Children.Remove($Group)

    ## Adding Users To the group ##
    # Connect and Locate the group
    $Computer = $env:COMPUTERNAME
    $GroupName = 'TestGroup'
    $ADSI = [ADSI]("WinNT://$Computer")
    $Group = $ADSI.Children.Find($GroupName, 'group') 

    # Add the user to the group
    $User = $env:USERNAME
    $Group.Add(("WinNT://$computer/$user"))

    # We can verify the membership by running the following  command:
    $Group.psbase.invoke('members')  | ForEach-Object {
        $_.GetType().InvokeMember("Name","GetProperty",$Null,$_,$Null)
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