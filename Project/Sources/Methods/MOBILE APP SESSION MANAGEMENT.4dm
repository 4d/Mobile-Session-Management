//%attributes = {"shared":true}
// ----------------------------------------------------
// Project method: MOBILE APP SESSION MANAGEMENT
// Database: MOBILE SESSION MANAGEMENT
// ID[72B19F04EC24458489F07B9810F2C7B2]
// Created #11-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($action : Text)

If (False:C215)
	C_TEXT:C284(MOBILE APP SESSION MANAGEMENT; $1)
End if 

Case of 
		
		//___________________________________________________________
	: (Length:C16($action)=0)
		
		BRING TO FRONT:C326(New process:C317(Current method name:C684; 0; "$"+Current method name:C684; "run"; *))
		
		//___________________________________________________________
	: ($action="run")
		
		// First launch of this method executed in a new process
		var $data : Object
		$data:=New object:C1471
		$data.menuBar:=mnu Default
		SET MENU BAR:C67($data.menuBar)
		$data.window:=Open form window:C675("SESSIONS_MANAGEMENT"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		DIALOG:C40("SESSIONS_MANAGEMENT"; $data)
		CLOSE WINDOW:C154
		RELEASE MENU:C978($data.menuBar)
		
		//___________________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point ("+$action+")")
		
		//___________________________________________________________
End case 