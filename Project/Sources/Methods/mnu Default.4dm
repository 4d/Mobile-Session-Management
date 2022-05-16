//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : mnu Default
// Database: MOBILE SESSION MANAGEMENT
// ID[9AC0908BC17549029BB86D03271EB4FE]
// Created #12-6-2018 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE()->$menuBar : Text

If (False:C215)
	C_TEXT:C284(mnu Default; $0)
End if 

$menuBar:=Create menu:C408

var $menuEdit : Text
$menuEdit:=Create menu:C408

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuItemUndo")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak undo:K76:51)
SET MENU ITEM SHORTCUT:C423($menuEdit; -1; "Z"; Command key mask:K16:1)

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuRedo")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak redo:K76:52)
SET MENU ITEM SHORTCUT:C423($menuEdit; -1; "Z"; Shift key mask:K16:3)

APPEND MENU ITEM:C411($menuEdit; "-")

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuItemCut")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak cut:K76:53)
SET MENU ITEM SHORTCUT:C423($menuEdit; -1; "X"; Command key mask:K16:1)

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuItemCopy")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak copy:K76:54)
SET MENU ITEM SHORTCUT:C423($menuEdit; -1; "C"; Command key mask:K16:1)

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuItemPaste")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak paste:K76:55)
SET MENU ITEM SHORTCUT:C423($menuEdit; -1; "V"; Command key mask:K16:1)

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuItemClear")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak clear:K76:56)

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuItemSelectAll")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak select all:K76:57)
SET MENU ITEM SHORTCUT:C423($menuEdit; -1; "A"; Command key mask:K16:1)

APPEND MENU ITEM:C411($menuEdit; "(-")

APPEND MENU ITEM:C411($menuEdit; ":xliff:CommonMenuItemShowClipboard")
SET MENU ITEM PROPERTY:C973($menuEdit; -1; Associated standard action name:K28:8; ak show clipboard:K76:58)

APPEND MENU ITEM:C411($menuBar; ":xliff:CommonMenuEdit"; $menuEdit)
RELEASE MENU:C978($menuEdit)