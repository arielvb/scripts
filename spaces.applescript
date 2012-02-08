#!/usr/bin/osascript
------------------------------------------
-- spaces.applescript
-- arielvb - http://www.arielvb.com
-- Turns on/off MacOS X Spaces or shows the current state
-- Usage: spaces.applescript [on | off]
-- Version: 0.2
-- Changelog:
-- 	0.1 First version
-- 	0.2 On/Off
------------------------------------------
-- use input arguments

on run argv
	tell application "System Events" to tell expose preferences to tell spaces preferences
		-- check arguments length
		if  argv is not {} then
			-- check input and 
			if (item 1 of argv is equal to "on") and not (spaces enabled) then
				set spaces enabled to true
			else if (spaces enabled) then
				set spaces enabled to false
			end if
		else
			if (spaces enabled) then
				return "on"
			else
				return "off"
			end if
		end if
	end tell
end run
