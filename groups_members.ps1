Write-Host " All Groups "
Write-Host "-----------"
$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$SearchString = "LDAP://"
$PDC = ($domainObj.PdcRoleOwner).Name
$SearchString += $PDC + "/"
$DistinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))"
$SearchString += $DistinguishedName
$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$Searcher.SearchRoot = $objDomain
$Searcher.filter="(objectClass=Group)"
$Result = $Searcher.FindAll()
Foreach($obj in $Result)
{
$obj.Properties.name
}


Write-Host " Members of each Groups "
Write-Host "-----------"

Foreach($obj in $Result)
{

Write-Host "Members in" $obj.Properties.name ":-"
Write-Host " "

$obj.Properties.member

}

