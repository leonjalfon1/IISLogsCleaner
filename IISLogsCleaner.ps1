# Script to cleanup IIS log files 
# By Default: Remove logs files located in "C:\inetpub\logs" greater than 30 days old. 


# CONFIGURATION

$LogPath = "C:\inetpub\logs" 
$maxDaystoKeep = -30
 

# FUNCTION

$itemsToDelete = dir $LogPath -Recurse -File *.log | Where LastWriteTime -lt ((get-date).AddDays($maxDaystoKeep)) 
$totalFiles = $itemsToDelete.Count

if ($itemsToDelete.Count -gt 0)
{ 
    ForEach ($item in $itemsToDelete)
    { 
        Get-item $item.FullName | Remove-Item -Verbose 
    } 

    Write-Output "Cleanup of log files older than $((get-date).AddDays($maxDaystoKeep)) completed..." 
    Write-Output "$totalFiles Files Deleted..." 
} 
else
{ 
    Write-Output "No items to be deleted today $($(Get-Date).DateTime)" 
} 
   

start-sleep -Seconds 10