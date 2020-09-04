// ----------------------------------------------------
// Form method : SESSIONS_MANAGEMENT
// Database: MOBILE SESSION MANAGEMENT
// ID[CA20DED5061E47EDA9B0B29E8B2A573F]
// Created #7-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $current : Text
var $index : Integer
var $ptr : Pointer
var $e; $infos : Object

// ----------------------------------------------------
// Initialisations
$e:=FORM Event:C1606

// ----------------------------------------------------

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		//
		
		//______________________________________________________
	: ($e.code=On Activate:K2:9)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "applicationList")
		
		// Keep the selected session id, if any
		If (Form:C1466.selected#Null:C1517)
			
			$current:=String:C10(Form:C1466.selected.session.id)
			
		End if 
		
		// Retrieve the sessions informations
		$infos:=MOBILE APP Get sessions info
		
		If ($infos.apps#Null:C1517)
			
			Case of 
					
					//______________________________________________________
				: ($infos.apps.length=0)
					
					// Empty the list of applications and sessions
					CLEAR VARIABLE:C89($ptr->)
					Form:C1466.sessions:=New collection:C1472
					
					//______________________________________________________
				: ($infos.apps.length=1)
					
					// Populate the application list
					COLLECTION TO ARRAY:C1562($infos.apps.extract("name"); $ptr->)
					$ptr->:=1
					
					// Load the sessions
					Form:C1466.sessions:=$infos.apps[0].sessions
					
					//______________________________________________________
				Else 
					
					// Get current selected application
					//%W-533.3
					$index:=$infos.apps.extract("name").indexOf($ptr->{$ptr->})
					//%W+533.3
					
					// Select first one if none selected
					$index:=Choose:C955($index=-1; 0; $index)
					
					COLLECTION TO ARRAY:C1562($infos.apps.extract("name"); $ptr->)
					
					// Select & load the sessions
					$ptr->:=$index+1
					Form:C1466.sessions:=$infos.apps[$index].sessions
					
					//______________________________________________________
			End case 
			
			// Restore selection
			LISTBOX SELECT ROW:C912(*; "sessionList"; Form:C1466.sessions.extract("session.id").indexOf($current); lk replace selection:K53:1)
			
		Else 
			
			// Empty the list of applications, sessions and selection
			CLEAR VARIABLE:C89($ptr->)
			Form:C1466.sessions:=New collection:C1472
			LISTBOX SELECT ROW:C912(*; "sessionList"; 0; lk remove from selection:K53:3)
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+$e.description+")")
		
		//______________________________________________________
End case 