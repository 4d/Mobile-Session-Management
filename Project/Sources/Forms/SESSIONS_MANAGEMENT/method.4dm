// ----------------------------------------------------
// Form method : SESSIONS_MANAGEMENT
// Database: MOBILE SESSION MANAGEMENT
// ID[CA20DED5061E47EDA9B0B29E8B2A573F]
// Created #7-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
var $e : Object

$e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		Form:C1466.applications:=New object:C1471  // Apps' drop-down data source
		Form:C1466.sessions:=New collection:C1472  // Sessions list's data source
		
		// Load the json schema for a mobile session
		Form:C1466.scheme:=JSON Parse:C1218(Get 4D Resources folder.file("JSONSchemas/mobileSessionSchema.json").getText())
		
		// The current session file assessor
		Form:C1466.currentSessionFile:=Formula:C1597(Folder:C1567(fk mobileApps folder:K87:18; *)\
			.folder(Form:C1466.applications.values[Form:C1466.applications.index])\
			.file(Form:C1466.sessionCurrent.session.id))
		
		Form:C1466.refresh:=Formula:C1597(SET TIMER:C645(-1))
		
		OBJECT SET ENABLED:C1123(*; "push"; False:C215)
		
		//______________________________________________________
	: ($e.code=On Activate:K2:9)
		
		Form:C1466.refresh()
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		// Keep the current selected application
		Form:C1466.currentApp:=String:C10(Form:C1466.applications.currentValue)
		
		// Retrieve the sessions informations
		Form:C1466.infos:=MOBILE APP Get sessions info
		
		If (Form:C1466.infos.apps.length>0)
			
			Form:C1466.applications.values:=Form:C1466.infos.apps.extract("name")
			Form:C1466.applications.index:=Form:C1466.applications.values.indexOf(Form:C1466.currentApp)
			Form:C1466.applications.index:=Form:C1466.applications.index=-1 ? 0 : Form:C1466.applications.index  // The first available for the first time
			
			// Load the application's sessions
			Form:C1466.sessions:=Form:C1466.infos.apps[Form:C1466.applications.index].sessions
			
		Else 
			
			Form:C1466.applications.values:=New object:C1471
			Form:C1466.applications.index:=-1
			Form:C1466.applications.currentValue:="No application session"
			Form:C1466.sessions:=New collection:C1472
			
		End if 
		
		LISTBOX SELECT ROW:C912(*; "sessionList"; 0; lk remove from selection:K53:3)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+$e.description+")")
		
		//______________________________________________________
End case 