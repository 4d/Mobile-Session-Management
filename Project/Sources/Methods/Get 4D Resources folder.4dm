//%attributes = {"invisible":true}
#DECLARE() : 4D:C1709.Folder

If (Is Windows:C1573)
	
	return File:C1566(Application file:C491; fk platform path:K87:2).parent.folder("Resources")
	
Else 
	
	return Folder:C1567(Application file:C491; fk platform path:K87:2).folder("Contents/Resources")
	
End if 