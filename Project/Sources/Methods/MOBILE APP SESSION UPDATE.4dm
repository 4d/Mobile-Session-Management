//%attributes = {"invisible":true,"shared":true,"executedOnServer":true}
// ----------------------------------------------------
// Project method : MOBILE APP SESSION UPDATE
// Database: MOBILE SESSION MANAGEMENT
// ID[0AEF0C7A0E964EC182A057BDC6E97B79]
// Created #6-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Object
var $2 : Text

If (False:C215)
	C_OBJECT:C1216(MOBILE APP SESSION UPDATE; $1)
	C_TEXT:C284(MOBILE APP SESSION UPDATE; $2)
End if 

var $action : Text
var $session : Object

var $file; $scheme : 4D:C1709.File

// ----------------------------------------------------
// Initialisations
If (Asserted:C1132(Count parameters:C259>=1; "Missing session object"))
	
	// Required parameters
	$session:=$1
	
	// Default values
	$action:="update"
	
	// Optional parameters
	If (Count parameters:C259>=2)
		
		$action:=$2
		
	End if 
	
	// Compute the session file path
	// Warning: teamId is not mandatory
	$file:=Folder:C1567(fk mobileApps folder:K87:18; *).file(Choose:C955(Length:C16($session.team.id)>0; $session.team.id+"."; "")\
		+$session.application.id+"/"+$session.session.id)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($action="update")
		
		// Get the schema for sessions
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

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End