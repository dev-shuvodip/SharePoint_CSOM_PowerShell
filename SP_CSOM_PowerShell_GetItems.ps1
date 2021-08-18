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
    #Get handle of the lists collection in the SharePoint Online Site
    $lists = $ctx.web.Lists

    #Get list by title
    $list = $lists.GetByTitle("Employee Database")

    #CAML query to get list items
    $listItems = $list.GetItems([Microsoft.SharePoint.Client.CamlQuery]::CreateAllItemsQuery())  
    
    $ctx.load($listItems)    

    $ctx.executeQuery()  

    foreach($listItem in $listItems)  
    {  
        Write-Host "ID - " $listItem["ID"]
        Write-Host "Title - " $listItem["Title"]
        Write-Host "Email - " $listItem["Email"]
        Write-Host "Contact - " $listItem["Contact"]
        Write-Host "Subject - " $listItem["Subject"].LookUpValue
        Write-Host "Branch - " $listItem["Branch"].LookUpValue
    }  
}  
catch{  
    write-host "$($_.Exception.Message)" -foregroundcolor red  
}