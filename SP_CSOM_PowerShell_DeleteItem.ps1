#Add Microsoft.SharePoint.Client.dll
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"

#Add Microsoft.SharePoint.Client.Runtime.dll
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

#SharePoint Online Site URL
$siteURL = ""

#SharePoint Online Username
$userId = ""

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
    $items = $list.GetItems([Microsoft.SharePoint.Client.CamlQuery]::CreateAllItemsQuery())  
    $ctx.load($items)  
    $ctx.executeQuery()  

    Write-Host "Listview - "

    foreach($item in $items)  
    {  
        Write-Host "ID - " $item["ID"]  "Title - " $item["Title"]
    }  

    $itemId = (Read-Host -Prompt "Enter ID of item to be updated - ") -as [int]

    $listItem = $list.GetItemById($itemId)  
    $listItem.DeleteObject()  

    $ctx.executeQuery()
}  
catch{  
    write-host "$($_.Exception.Message)" -foregroundcolor red  
}  