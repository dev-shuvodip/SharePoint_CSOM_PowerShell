#Add Microsoft.SharePoint.Client.dll
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"

#Add Microsoft.SharePoint.Client.Runtime.dll
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

#SharePoint Online Site URL
$siteURL = "https://pphackathonteam5.sharepoint.com/sites/Shuvodip"

#SharePoint Online Username
$userId = "shuvodip@pphackathonteam5.onmicrosoft.com"

#SharePoint Online Password
$pswd = Read-Host -Prompt "Enter password" -AsSecureString  

#Authentication
$creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($userId, $pswd)  

#SharePoint Online Site Client Context
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteURL)

$ctx.credentials = $creds
try{  
    $lists = $ctx.web.Lists  
    $list = $lists.GetByTitle("Employee Database")  
    $listItemInfo = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation  
    $listItem = $list.AddItem($listItemInfo)  
    $listItem["Title"] = Read-Host -Prompt "Enter Title"
    $listItem["Email"] = Read-Host -Prompt "Enter Email"
    $listItem["Contact"] = Read-Host -Prompt "Enter Contact"
    $subjectId = (Read-Host -Prompt "Enter Subject") -as [int]
    $listItem["Subject"] = $subjectId
    $branchId = (Read-Host -Prompt "Enter Subject") -as [int]
    $listItem["Branch"] = $branchId
    $listItem.Update()      
    $ctx.load($list)     
     
    $ctx.executeQuery()  

    Write-Host "Item Added with ID - " $listItem.Id      
}  
catch{  
    write-host "$($_.Exception.Message)" -foregroundcolor red  
}  