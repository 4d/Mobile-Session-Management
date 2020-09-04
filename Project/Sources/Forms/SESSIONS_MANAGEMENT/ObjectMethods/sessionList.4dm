// ----------------------------------------------------
// Object method : SESSIONS_MANAGEMENT.sessionList
// Database: MOBILE SESSION MANAGEMENT
// ID[3DDEC3316FE549669FB0156E14295696]
// Created #12-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $choice; $me; $popup : Text
var $button; $column; $row; $x; $y : Integer
var $e : Object

var $file : 4D:C1709.Document

// ----------------------------------------------------
// Initialisations
$e:=FORM Event:C1606
$me:=OBJECT Get name:C1087(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Clicked:K2:4)
		
		If (Contextual click:C713)
			
			LISTBOX GET CELL POSITION:C971(*; $me; $column; $row)
			
			$popup:=Create menu:C408
			
			If ($row>0)
				
				APPEND MENU ITEM:C411($popup; "Show on disk")
				SET MENU ITEM PARAMETER:C1004($popup; -1; "show")
				
				APPEND MENU ITEM:C411($popup; "-")
				
				APPEND MENU ITEM:C411($popup; "Delete")
				SET MENU ITEM PARAMETER:C1004($popup; -1; "delete")
				
			Else 
				
				APPEND MENU ITEM:C411($popup; "Refresh")
				SET MENU ITEM PARAMETER:C1004($popup; -1; "refresh")
				
			End if 
			
			$choice:=Dynamic pop up menu:C1006($popup)
			RELEASE MENU:C978($popup)
			
			Case of 
					//………………………………………………………………………………………
				: (Length:C16($choice)=0)
					
					// nothing selected
					
					//………………………………………………………………………………………
				: ($choice="delete")
					
					// Delete the session file
					MOBILE APP SESSION UPDATE(Form:C1466.selected; "delete")
					
					// Refresh UI
					SET TIMER:C645(-1)
					
					//………………………………………………………………………………………
				: ($choice="show")
					
					$file:=Folder:C1567(fk mobileApps folder:K87:18; *).file(Choose:C955(Length:C16(Form:C1466.selected.team.id)>0; Form:C1466.selected.team.id+"."; "")\
						+Form:C1466.selected.application.id+"/"+Form:C1466.selected.session.id)
					
					SHOW ON DISK:C922($file.platformPath)
					
					//………………………………………………………………………………………
				: ($choice="refresh")
					
					SET TIMER:C645(-1)
					
					//………………………………………………………………………………………
				Else 
					
					ASSERT:C1129(False:C215; "Unknown menu action ("+$choice+")")
					
					//………………………………………………………………………………………
			End case 
		End if 
		
		//______________________________________________________
	: ($e.code=On Mouse Enter:K2:33)
		
		// Set a short tips delay
		SET DATABASE PARAMETER:C642(Tips delay:K37:80; 10)
		
		//______________________________________________________
	: ($e.code=On Mouse Move:K2:35)
		
		// Set tips content according to the line over
		GET MOUSE:C468($x; $y; $button)
		LISTBOX GET CELL POSITION:C971(*; $me; $x; $y; $column; $row)
		
		If ($row=0)\
			 | ($column=2)  // Not for status
			
			OBJECT SET HELP TIP:C1181(*; $me; "")
			
		Else 
			
			OBJECT SET HELP TIP:C1181(*; $me; JSON Stringify:C1217(Form:C1466.sessions[$row-1].device; *))
			
		End if 
		
		//______________________________________________________
	: ($e.code=On Mouse Leave:K2:34)
		
		// Restore default tips delay
		SET DATABASE PARAMETER:C642(Tips delay:K37:80; 45)
		
		//______________________________________________________
	: ($e.code=On Data Change:K2:15)
		
		// Update the session file
		MOBILE APP SESSION UPDATE(Form:C1466.selected)
		
		// Refresh UI
		SET TIMER:C645(-1)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+String:C10($e.description)+")")
		
		//______________________________________________________
End case 