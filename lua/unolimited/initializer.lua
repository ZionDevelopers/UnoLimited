--[[ 
 UnoLimited
 
 Copyright (c) 2013-2023 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5 by Dathus [BR] on 2023-06-06 09:30 PM (GMT -03)
]]--

-- Add Net ID to the Pool
util.AddNetworkString( "UnoLimited" )

-- Check if vON Exists
if von == nil then
	include( "von.lua" )
end

-- Require Libraries
include( "unolimited/library/shared.lua" )
include( "unolimited/library/server.lua" )

-- Load Current Saved Limits
unoLimited.loadSave()

-- Send Limits to Player
hook.Add( "PlayerInitialSpawn", "UnoLimited-Send", unoLimited.sendLimits )
-- Receive Player's Limits
net.Receive( "UnoLimited", unoLimited.receiveLimits )
