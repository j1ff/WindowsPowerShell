$ver = $host | select version
if($Ver.version.major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
if(!(Get-PSSnapin Microsoft.SharePoint.PowerShell -ea 0))
{
Write-Progress -Activity "Loading Modules" -Status "Loading Microsoft.SharePoint.PowerShell"
Add-PSSnapin Microsoft.SharePoint.PowerShell
}

##
#Set Static Variables
##


#SourceWebURL is the URL of the web which contains the source list
$SourceWebURL = "http://sharepoint.rcormier.local"

#SoureLibraryTitle is the title of the Source Library where documents reside
$SourceLibraryTitle = "Shared Documents"

#DestinationWebURL is the URL of the web in which you want to transfer your documents
$DestinationWebURL = "http://sharepoint.rcormier.local/sites/sts_0"

#DestinationLibraryTitle is the title of the destionation library in which you want to store your files
$DestinationLibraryTitle = "Shared Documents"

##
#Begin Script
##

#Retrieve the source web, using the parameter provided
$sWeb = Get-SPWeb $SourceWebURL

#Retrieve the source list using the parameter provided
$sList = $sWeb.Lists | ? {$_.Title -eq $SourceLibraryTitle}

#Retrieve the destination web using the parameter provided
$dWeb = Get-SPWeb $DestinationWebURL

#Retrieve the source list using the parameter provided
$dList = $dWeb.Lists | ? {$_.title -like $DestinationLibraryTitle}

#Retrieve all folders in the source list.  This used to maintain the folder structure in source and destination libraries.  This excludes the root folder
$AllFolders = $sList.Folders

#Retrieve the root folder in the source list.
$RootFolder = $sList.RootFolder

#Return all files that exist directly in the root of the library
$RootItems = $RootFolder.files

#Loop through each of the documents discovered in the root of the library and perform some action
foreach($RootItem in $RootItems)
{
    #Get the Binary Stream of the referenced file, such that we can create the same file in the destination environment
    $sBytes = $RootItem.OpenBinary()
    
    #Create A New file using the name and binary stream from the original document, assign it to a variable.  This variable will later be called when setting properties
    $dFile = $dList.RootFolder.Files.Add($RootItem.Name, $sBytes, $true)

    #Return all fields for the source item which are not read-only
    $AllFields = $RootItem.Item.Fields | ? {!($_.sealed)}

    #Loop through all of the fields returned and perform some action
    foreach($Field in $AllFields)
    {
        #If the source item has a property that matches the name of the field perform some action
        if($RootItem.Properties[$Field.Title])
        {
            #If the destination file does not contain the same property as the source item perform some action.
            if(!($dFile.Properties[$Field.title]))
            {
                #Add a property to the file matching title and value of the same field in the original item
                $dFile.AddProperty($Field.Title, $RootItem.Properties[$Field.Title])
            }
            else
            {
                #If the property already exists, set the value on the destination item to the same value as it was in the source item.
                $dFile.Properties[$Field.Title] = $RootItem.Properties[$Field.Title]
            }
            
        }
    }
    #Commit the changes by updating the destination file.
    $dFile.Update()
}

#loop through all folders which are not the root folder
foreach($Folder in $AllFolders)
{
    #Since we're looping quite a bit and re-building the ParentFolderURL, make sure it doesn't exist every time we switch folders
    Remove-Variable ParentFolderURL
    
    #Since we're looping through sections of the folder URL, we need something to start at zero and increment as we loop through sections of the Folder URL
    $i = 0
    
    #Break the Folder URL up into sections, separated by "/"
    $FolderURL = $Folder.url.Split("/")
        
    #Perform a variable number of actions against the Folder URL based on the number of sections in FolderURL
    while($i -lt ($FolderURL.count-1))
    {
    #Keep apending the Folder section in order to build the parent folder URL
    $ParentFolderURL = "$ParentFolderURL/" + $FolderURL[$i]
    
    #Increment the I variable in order to move forward through the folder structure
    $i++
    }
    
    $CurrentFolder = $dList.Folders | ? {$_.url -eq $ParentFolderURL.substring(1)}
    #If the destination list does not contain a folder with the same name, create it
    if(!($CurrentFolder.Folders | ? {$_.name -eq $Folder.Name}))
    {
        #Create a Folder in the destination library with the same name as it had in the source library, in the same relative location
        $NewFolder = $dlist.Folders.Add(("$DestinationWebURL" + $ParentFolderURL), [Microsoft.SharePoint.SPFileSystemObjectType]::Folder, $Folder.name)
        
        #Finalize creating the folder by calling update
        $NewFolder.update()
    }
    else
    {
        #If the folder already exists, retrieve the folder where the file will be created
        $NewFolder = $dList.Folders | ? {$_.name -eq $Folder.Name}
    }
    
    #Return all files from the source list.  we will use this later to perform updates on items
    $AllFiles = $sList.Items
    
    #Return all items from the current folder
    $sItems = $Folder.folder.Files
    
    #If the folder we're currently in has more than zero objects, perform some actions.
    if($Folder.Folder.Files.count -gt 0)
    {
        #Perform some actions against each object in the current folder
        foreach($item in $sItems)
        {
            #Get the relative URL from the current item            
            $Relative = ($Item.ServerRelativeUrl).substring(1)
            
            #Based on the relative path of the current item, retrieve the file from the site
            $TargetItem = $AllFiles | ? {$_.URL -eq $Relative}
            
            #Retrieve the binary stream of the current file
            $sBytes = $TargetItem.File.OpenBinary()
            
            #Create a file in destination library, same relative folder, using the current file's name and binary stream
            $dFile = $Newfolder.Folder.Files.Add($TargetItem.Name, $sBytes, $true)
            
            #Return all fields for the source item which are not read-
            $AllFields = $TargetItem.Fields | ? {!($_.sealed)}
            
            #Loop through all of the fields returned and perform some action
            foreach($Field in $AllFields)
            {
                #If the destination file does not contain the same property as the source item perform some action.
                if($TargetItem.Properties[$Field.Title])
                {
                    #If the destination file does not contain the same property as the source item perform some action.
                    if(!($dFile.Properties[$Field.title]))
                    {
                        #Add a property to the file matching title and value of the same field in the original item
                        $dFile.AddProperty($Field.Title, $TargetItem.Properties[$Field.Title])
                    }
                    else
                    {
                        #If the property already exists, set the value on the destination item to the same value as it was in the source item.
                        $dFile.Properties[$Field.Title] = $TargetItem.Properties[$Field.Title]
                    }
                    
                }
            }
            #Commit the changes by updating the destination file.
            $dFile.Update()
                    }
    }
}