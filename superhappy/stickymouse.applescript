

on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit

set mouseloc to theSplit(do shell script "a=$(" & POSIX path of ((path to me as text) & "::") & "MouseTools" & " -location)&&echo $a", " ")

repeat
	-- Store old mouse location
	set lmouseloc to mouseloc
	
	-- Get bounds of current window
	tell application "System Events"
		set frontApp to name of first application process whose frontmost is true
	end tell
	set winbounds to bounds of window 1 of application frontApp
	
	-- Get current mouse location
	set mouseloc to theSplit(do shell script "a=$(~/Downloads/MouseTools -location)&&echo $a", " ")
	
	set dx to (item 1 of mouseloc) - (item 1 of lmouseloc)
	set dy to (item 2 of mouseloc) - (item 2 of lmouseloc)
	
	set item 1 of winbounds to (item 1 of winbounds) + dx
	set item 2 of winbounds to (item 2 of winbounds) + dy
	set item 3 of winbounds to (item 3 of winbounds) + dx
	set item 4 of winbounds to (item 4 of winbounds) + dy
	-- get winbounds
	
	set bounds of window 1 of application frontApp to winbounds
end repeat
set AppleScript's text item delimiters to oldDelimiters
