--[[ 
 UnoLimited
 
 Copyright (c) 2013-2023 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5.6 by Dathus [BR] on 2023-10-29 08:53 AM (GMT -03)
]]--

-- Setup Main Vars
unoLimited = {}
unoLimited.groups = { superadmin = -1, admin = 2, operator = 1.5 }
unoLimited.version = "2.5.6"
unoLimited.accessFlag = "unolimited manager"

--Setup Loading Log Formatation
function loadingLog (text)
  --Set Max Size
  local size = 32
  --If Text Len < max size
  if(string.len(text) < size) then
    -- Format the text to be Text+Spaces*LeftSize
    text = text .. string.rep( " ", size-string.len(text) )
  else
    --If Text is too much big then cut and add ...
    text = string.Left( text, size-3 ) .. "..."
  end
  --Log Messsage
  Msg( "||  "..text.."||\n" )
end

Msg( "\n/====================================\\\n")
Msg( "||             UnoLimited           ||\n" )
Msg( "||----------------------------------||\n" )
loadingLog("Version " .. unoLimited.version)
loadingLog("Updated on 2023-10-29 8:53 AM")
Msg( "\\====================================/\n\n" )

-- Send Files to Client 
AddCSLuaFile()
AddCSLuaFile( "autorun/client/unolimited.lua" )
AddCSLuaFile( "unolimited/library/shared.lua" )
AddCSLuaFile( "unolimited/library/client.lua" )

-- If Run on SERVER
if SERVER then
	-- Require Library
	include( "unolimited/initializer.lua" )
end
