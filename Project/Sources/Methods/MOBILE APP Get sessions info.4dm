//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// ----------------------------------------------------
// Project method : MOBILE APP Get sessions info
// Database: MOBILE SESSION MANAGEMENT
// ID[759E8A62FEAA48DA8E9A2B5AC05637F6]
// Created #6-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Returns an object containing detailed information on mobile applications
// & associated devices' sessions
// ----------------------------------------------------
// Declarations
#DECLARE() : Object

If (False:C215)
	C_OBJECT:C1216(MOBILE APP Get sessions info; $0)
End if 

var $text : Text
var $app; $infos; $session : Object
var $file : 4D:C1709.File
var $folder; $mobileApps : 4D:C1709.Folder

// ----------------------------------------------------
$infos:=New object:C1471(\
"apps"; New collection:C1472)

$mobileApps:=Folder:C1567(fk mobileApps folder:K87:18; *)

If ($mobileApps.exists)
	
	// Each folder whose name begins with "com." corresponds to an application
	For each ($folder; $mobileApps.folders())
		
		$app:=New object:C1471(\
			"name"; $folder.fullName; \
			"id"; $folder.fullName; \
			"sessions"; New collection:C1472)
		
		// Each file, without extension, should correspond to a session
		For each ($file; $folder.files().query("extension =''"))
			
			// Check that the file name is composed of hexadecimal characters only
			If (Match regex:C1019("(?mi-s)^[[:xdigit:]]+$"; $file.name; 1; *))
				
				// Make sure it's a json
				$text:=$file.getText()
				
				If (Match regex:C1019("(?msi)^\\{.*\\}$"; $text; 1; *))
					
					$session:=JSON Parse:C1218($text)
					$app.sessions.push($session)
					
				End if 
			End if 
		End for each 
		
		If ($app.sessions.length>0)\
			 && ($infos.apps.query("name = :1"; $app.name).pop()=Null:C1517)
			
			$app.label:=$session.application.name+" ("+$folder.name+")"
			$infos.apps.push($app)
			
		End if 
	End for each 
End if 

return $infos