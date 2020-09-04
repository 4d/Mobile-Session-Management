// ----------------------------------------------------
// Object method :SESSIONS_MANAGEMENT.applicationList
// Database: MOBILE SESSION MANAGEMENT
// ID[F94EE8C4A4B44B8DBF7DFEDCBFA0C96C]
// Created #7-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $e : Object

// ----------------------------------------------------
// Initialisations
$e:=FORM Event:C1606

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Data Change:K2:15)
		
		// Clear current selection
		Form:C1466.selected:=New object:C1471
		
		// Refresh UI
		SET TIMER:C645(-1)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+$e.description+")")
		
		//______________________________________________________
End case 