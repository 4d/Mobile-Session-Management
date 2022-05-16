//%attributes = {"invisible":true}
var $name : Text
var $len; $pos : Integer
var $mobileApps : Collection
var $file : 4D:C1709.File
var $folder; $target : 4D:C1709.Folder

/*
With iOS only, the folders were named <TEAMID>.<BundleID>.
Since the Android implementation, where the team ID is not mandatory because unused, 
we could end up with 2 folders for the same application.
So, since version 19R6, folders are now named only with the bundle ID.
To be compatible, this method updates and/or merges the existing folders
*/

$mobileApps:=Folder:C1567(fk mobileApps folder:K87:18; *).folders()

If (Num:C11(Application version:C493)>=1960)
	
	For each ($folder; $mobileApps)
		
		If (Match regex:C1019("(?m-si)^([A-Z0-9]*\\.)"; $folder.fullName; 1; $pos; $len; *))
			
			$name:=Delete string:C232($folder.fullName; $pos; $len)
			
			$target:=$mobileApps.query("fullName = :1"; $name).pop()
			
			If ($target=Null:C1517)
				
				$folder.rename($name)
				
			Else 
				
				For each ($file; $folder.files())
					
					$file.copyTo($target; fk overwrite:K87:5)
					
				End for each 
			End if 
			
			$folder.delete(fk recursive:K87:7)
			
		End if 
	End for each 
End if 