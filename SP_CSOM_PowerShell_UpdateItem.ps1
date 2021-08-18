#Add Microsoft.SharePoint.Client.dll
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"

#Add Microsoft.SharePoint.Client.Runtime.dll
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

#SharePoint Online Site URL
$siteURL = "https://pphackathonteam5.sharepoint.com/sites/Shuvodip"

#SharePoint Online Username
$userId = "shuvodip@pphackathonteam5.onmicrosoft.com"

#SharePoint Online Password
$pwd = Read-Host -Prompt "Enter password" -AsSecureString  

#Authentication
$creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($userId, $pwd)  

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

    $listItem["Title"] = Read-Host -Prompt "Enter Title"
    $listItem["Email"] = Read-Host -Prompt "Enter Email"
    $listItem["Contact"] = Read-Host -Prompt "Enter Contact"
    $subjectId = (Read-Host -Prompt "Enter Subject") -as [int]
    $listItem["Subject"] = $subjectId
    $branchId = (Read-Host -Prompt "Enter Subject") -as [int]
    $listItem["Branch"] = $branchId  
    
    $listItem.Update()  
    $ctx.load($listItem)      
    $ctx.executeQuery()  
}  
catch{  
    write-host "$($_.Exception.Message)" -foregroundcolor red  
}  