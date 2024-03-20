<#
.SYNOPSIS
Provide a filename for a csv and the script will look for the username header of it, check Active Directory for the usernames, and return properties such as GivenName, Enabled, MemberOf, and CreatedTimeStamp.
.PARAMETER csvname
.EXAMPLE
Get-ADUserProperties -csvname user.csv 
#>
param (
    [Parameter(Mandatory=$true)]
    [string]$csvname
    )
$UserList = (Import-CSV $csvname)
Foreach($User in $UserList) {
$GivenName = $User.Username
Get-ADUser -Filter 'Name -eq $GivenName' -Properties "MemberOf", "CreateTimeStamp", "modifyTimeStamp" | Format-List -Property GivenName,Enabled,MemberOf,modifyTimeStamp,CreateTimeStamp
}