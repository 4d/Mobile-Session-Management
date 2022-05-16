//%attributes = {"invisible":true,"shared":true,"executedOnServer":true}
// ----------------------------------------------------
// Project method : MOBILE APP SESSION UPDATE
// Database: MOBILE SESSION MANAGEMENT
// ID[0AEF0C7A0E964EC182A057BDC6E97B79]
// Created #6-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($session : Object; $action : Text)

If (False:C215)
	C_OBJECT:C1216(MOBILE APP SESSION UPDATE; $1)
	C_TEXT:C284(MOBILE APP SESSION UPDATE; $2)
End if 

var $file; $scheme : 4D:C1709.File

$action:=Length:C16($action)=0 ? "update" : $action
$file:=Folder:C1567(fk mobileApps folder:K87:18; *).folder($session.application.id).file($session.session.id)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($action="update")
		
		$scheme:=Get 4D Resources folder.file("JSONSchemas/mobileSessionSchema.json")
		
		If (JSON Validate:C1456($session; JSON Parse:C1218($scheme.getText())).success)
			
			$file.setText(JSON Stringify:C1217($session; *))
			
		Else 
			
			ALERT:C41("Invalid session object")
			
		End if 
		
		//______________________________________________________
	: ($action="delete")
		
		If ($file.exists)
			
			$file.delete()
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown action: \""+$action+"\"")
		
		//______________________________________________________
End case 