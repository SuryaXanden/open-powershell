; https://superuser.com/questions/205359/how-can-i-open-a-command-prompt-in-current-folder-with-a-keyboard-shortcut

SetTitleMatchMode RegEx
return

; Stuff to do when Windows Explorer is open

; #IfWinActive ahk_class ExploreWClass|CabinetWClass

#c::
	run_in_cwd()
return
; #IfWinActive

run_in_cwd()
{
    ; This is required to get the full path of the file from the address bar
    WinGetText, full_path, A

    ; Split on newline (`n)
    StringSplit, word_array, full_path, `n

    ; Find and take the element from the array that contains address
    Loop, %word_array0%
    {
        IfInString, word_array%A_Index%, Address
        {
            full_path := word_array%A_Index%
            break
        }
    }  

    ; strip to bare address
    full_path := RegExReplace(full_path, "^Address: ", "")

    ; Just in case - remove all carriage returns (`r)
    StringReplace, full_path, full_path, `r, , all

    IfInString full_path, \
    {
        Run, powershell, %full_path%, max
    }
	else
	{
		Run, powershell, %userprofile%\desktop, max
	}
}
