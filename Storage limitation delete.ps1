#Storage Limitation GDPR (Art 5(1)(e)) script to delete folders and files date stamped more than 1 month from execution time on na-stor02 - D.Love

$StartFolder = "\\na-stor02\visualstudiocommunity$\Single Customer View\Data\Backup sources"

$date = Get-Date


dir $StartFolder -Recurse -Force -ea 0 | 
?{$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddMonths(-1)} | # delete only folders more than 1 month old at point of execution 

ForEach-Object {
    
	$_ | del -Recurse -Force
	$_ | Format-Table -property Name, LastWriteTime -AutoSize | Out-File -Append -Width 220 "\\na-stor02\visualstudiocommunity$\Single Customer View\Data\Backup sources" #Outputs log iff folders are deleted
}

