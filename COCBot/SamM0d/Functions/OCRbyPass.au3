; #FUNCTION# ====================================================================================================================
; Name ..........: OCRbypass / RK Auto Update camps v.0.3
; Description ...: ByPass camps. capacity auto update
; Author ........: Boludoz (25/6/2018) Rulesss (1/7/2018)
; Modified ......: Boludoz (1/7/2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: getArmyCapacityOnTrainTroops(48, 160), _getArmyCapacityOnTrainTroops(48, 160)
; ===============================================================================================================================

Func _getArmyCapacityOnTrainTroops($x_start, $y_start) ;  -> Gets quantity of troops in army Window
; BYPASS HACK

	Local $aResult[3] = [0, 0, 0]
	$aResult[0] = getOcrAndCapture("coc-NewCapacity", $x_start, $y_start, 67, 14, True)
	Local $dbg = 0
		Local $aTempResult = StringSplit($aResult[0], "#", $STR_NOCOUNT)
		$aResult[1] = Number($aTempResult[0])
		$aResult[2] = Number($aTempResult[1])
		$aResult[2] = $aResult[2] / 2
		; SG Machine
		;If $aResult[2] <= 2 Then
		;GUICtrlSetData($g_hTxtTotalMachine, $aResult[2])
		;$g_iTotalMachine = $aResult[2]
		; Spell
		If $aResult[2] <= 11 Then
		GUICtrlSetData($g_hTxtTotalCountSpell, $aResult[2])
		$g_iTotalSpellValue = $aResult[2]
		; Army
		ElseIf $aResult[2] >= 15 Then
		GUICtrlSetData($g_hTxtTotalCampForced, $aResult[2])
		$g_iTotalCampForcedValue = $aResult[2]

	If $dbg = 1 Then Setlog($aResult[0])
	If $dbg = 1 Then Setlog($g_iTotalSpellValue)
	If $dbg = 1 Then Setlog($g_iTotalCampForcedValue)

	EndIf

	Return $aResult[0]
EndFunc   ;==>_getArmyCapacityOnTrainTroops

Func CheckAutoCamp() ; Only first Run and th5 + (Then every time he does the troops he will do it alone.)
	Local $dbg = 0
	If $dbg = 1 Then Setlog($g_iTotalSpellValue)
	Local $iCmpSpell = StringCompare($g_iTotalSpellValue, "0")
        If $iCmpSpell = 0 And $g_iTownHallLevel >= 5 Then ; Spell camp
            click(30, 584)
            if _sleep(1000) then return
            click(407, 132)
            if _sleep(1000) then return
			Local $NewSpellOCR = getArmyCapacityOnTrainTroops(48, 160) ; Check spell camps
            click(280, 132)
            if _sleep(1000) then return
			Local $NewCampOCR = getArmyCapacityOnTrainTroops(48, 160) ; Check army camps
				click(825, 122)
			if _sleep(1000) then return
		Endif
EndFunc   ;==>CheckAutoCamp

; INFO ! ======================
	;		; full & forced Total Camp values
	;		$g_iTrainArmyFullTroopPct = Int(GUICtrlRead($g_hTxtFullTroop))
	;		$g_bTotalCampForced = (GUICtrlRead($g_hChkTotalCampForced) = $GUI_CHECKED)
	;		$g_iTotalCampForcedValue = Int(GUICtrlRead($g_hTxtTotalCampForced))
	;		; spell capacity and forced flag
	;		$g_iTotalSpellValue = GUICtrlRead($g_hTxtTotalCountSpell)
	;		$g_bForceBrewSpells = (GUICtrlRead($g_hChkForceBrewBeforeAttack) = $GUI_CHECKED)
; ============