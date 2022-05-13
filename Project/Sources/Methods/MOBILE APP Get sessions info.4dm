//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// ----------------------------------------------------
// Project method : MOBILE APP Get sessions info
// Database: MOBILE SESSION MANAGEMENT
// ID[759E8A62FEAA48DA8E9A2B5AC05637F6]
// Created #6-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Returns an object containing detailed information on mobile applications
// & devices sessions
// ----------------------------------------------------
// Declarations
#DECLARE() : Object

If (False:C215)
	C_OBJECT:C1216(MOBILE APP Get sessions info; $0)
End if 

var $text : Text
var $application; $infos; $session : Object
var $file : 4D:C1709.Document
var $folder; $mobileApps : 4D:C1709.Folder

// ----------------------------------------------------
$infos:=New object:C1471(\
"apps"; New collection:C1472)

$mobileApps:=Folder:C1567(fk mobileApps folder:K87:18; *)

If ($mobileApps.exists)
	
	// Each folder corresponds to an application
	For each ($folder; $mobileApps.folders())
		
		$application:=New object:C1471(\
			"name"; $folder.fullName; \
			"id"; $folder.fullName; \
			"sessions"; New collection:C1472)
		
		// Each file, without extension, should correspond to a session
		For each ($file; $folder.files().query("extension =''"))
			
			If (Match regex:C1019("(?mi-s)^[[:xdigit:]]+$"; $file.name; 1))
				
				$text:=$file.getText()
				
				If (Match regex:C1019("(?msi)^\\{.*\\}$"; $text; 1))
					
					$session:=JSON Parse:C1218($text)
					
					$application.sessions.push($session)
					
				End if 
			End if 
		End for each 
		
		If ($infos.apps.query("name = :1"; $application.name).pop()=Null:C1517)
			
			$infos.apps.push($application)
			
		End if 
		
	End for each 
End if 

return $infos