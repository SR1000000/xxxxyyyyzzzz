CtrlClick(xy)

{

	global uid

	;global Class

	global ClickDelay

	global ClickCount

	Sleep ClickDelay

	SetControlDelay 0

	;if Class = 0

	ControlClick, % "x" xy[1] " y" xy[2]
, ahk_id %uid%,,,,NA Pos
	;else
	;	ControlClick, %Class%,ahk_id %uid%,,,, % "x" xy[1] " y" xy[2]


	SoundPlay, %A_WinDir%\Media\ding.wav
	ClickCount++
	return

}

RCtrlClick(xy, r, r2 := 0)

{

	global uid

	;global Class

	global ClickDelay

	global ClickCount

	Sleep ClickDelay

	SetControlDelay 0


	x := xy[1], y := xy[2]	;need temp vars for Rand byrefs to work

	if r2 
		RandRect(x,y,r,r2)
	else 
		RandCircle(x,y,r)

	;if Class = 0

	ControlClick, x%x% y%y%
, ahk_id %uid%,,,,NA Pos
	;else
	;	ControlClick, %Class%,ahk_id %uid%,,,, x%x% y%y%
	
	SoundPlay, %A_WinDir%\Media\ding.wav
	ClickCount++
	return

}

RFindClick(x,y, r := 5, xoff :=0, yoff := 0)
{
	local tx := 0, ty := 0, temp, ta
	GuiControl,, StatA, %x%
	RandCircle(tx,ty,r)
	tx += xoff
	ty += yoff
	temp := FindClick(A_ScriptDir "\pics\" x,y " x"tx " y"ty)
	;ta := StrSplit(temp,",")
	
	GuiControl,, StatA, %x% %tx% %ty% %temp%
	if temp != 0
		SoundPlay, %A_WinDir%\Media\ding.wav
	return temp
}

WFindClick(x,y, SearchNumber := 40)
{
	global
	local tx, ty, wx, wy, tstr
	GuiControl,, StatA, %x% %ClickCount%
	Found := 0
	Found := FindClick(A_ScriptDir "\pics\" x,y " rNoxPlayer mc o"SearchNumber " n0")
	while found == 0
	{
		SearchNumber += 6
		Found := FindClick(A_ScriptDir "\pics\" x,y " rNoxPlayer mc o"SearchNumber " n0")
		GuiControl,, StatA, NotFound pixel shade offset [%SearchNumber%]
		If SearchNumber >= 200
		{
			GuiControl,, StatA, WFindClick failed %x% %ClickCount%
			Exit
		}
	}
	WinGetPos, wx, wy,,, NoxPlayer
	tstr := StrSplit(Found,",")
	tx := tstr[1] - wx
	ty := tstr[2] - wy
	MouseMove, tx, ty
	GuiControl,, StatA, %x% Found offset [%SearchNumber%] %tx% %ty%
	;FindClick(A_ScriptDir "\pics\" x, y "Center x" RandX " y"  RandY " o" SearchNumber)
	return Found
}