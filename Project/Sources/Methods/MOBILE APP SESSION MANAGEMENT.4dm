//%attributes = {"shared":true}
// ----------------------------------------------------
// Project method: MOBILE APP SESSION MANAGEMENT
// Database: MOBILE SESSION MANAGEMENT
// ID[72B19F04EC24458489F07B9810F2C7B2]
// Created #11-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Declarations
var $1 : Text

If (False:C215)
	C_TEXT:C284(MOBILE APP SESSION MANAGEMENT; $1)
End if 

var $action; $t : Text
var $w : Integer

// ----------------------------------------------------
// Initialisations
If (Count parameters:C259>=1)
	
	$action:=$1
	
End if 

// ----------------------------------------------------
Case of 
		
		//___________________________________________________________
	: (Length:C16($action)=0)
		
		$t:=Current method name:C684
		
		Case of 
				
				//……………………………………………………………………
			: (Method called on error:C704=$t)
				
				// Error handling manager
				
				//……………………………………………………………………
				//: (Method called on event=$Txt_methodName)
				// Event manager - disabled for a component method
				
				//……………………………………………………………………
			Else 
				
				// This method must be executed in a unique new process
				BRING TO FRONT:C326(New process:C317($t; 0; "$"+$t; "_run"; *))
				
				//……………………………………………………………………
		End case 
		
		//___________________________________________________________
	: ($action="_run")
		
		// First launch of this method executed in a new process
		MOBILE APP SESSION MANAGEMENT("_declarations")
		MOBILE APP SESSION MANAGEMENT("_init")
		
		$w:=Open form window:C675("SESSIONS_MANAGEMENT"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		DIALOG:C40("SESSIONS_MANAGEMENT")
		CLOSE WINDOW:C154
		
		MOBILE APP SESSION MANAGEMENT("_deinit")
		
		//___________________________________________________________
	: ($action="_declarations")
		
		COMPILER_SESSIONS
		
		//___________________________________________________________
	: ($action="_init")
		
		SET MENU BAR:C67(mnu Default)
		
		//___________________________________________________________
	: ($action="_deinit")
		
		RELEASE MENU:C978(Get menu bar reference:C979)
		
		//___________________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point ("+$action+")")
		
		//___________________________________________________________
End case 