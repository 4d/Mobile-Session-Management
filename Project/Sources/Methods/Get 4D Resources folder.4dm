//%attributes = {"invisible":true}
// Return path of the 4D Resources folder
var $0 : Text

If (False:C215)
	C_TEXT:C284(Get 4D Resources folder; $0)
End if 

var $directory : Text

If (Is Windows:C1573)
	
	// Get parent path
	$directory:=Path to object:C1547(Application file:C491).parentFolder
	
Else 
	
	// Content path
	$directory:=Object to path:C1548(New object:C1471(\
		"name"; "Contents"; \
		"isFolder"; True:C214; \
		"parentFolder"; Application file:C491))
	
End if 

$0:=Object to path:C1548(New object:C1471(\
"name"; "Resources"; \
"isFolder"; True:C214; \
"parentFolder"; $directory))