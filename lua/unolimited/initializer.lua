--[[ 
 UnoLimited
 
 Copyright (c) 2013-2023 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5 by Dathus [BR] on 2023-10-29 01:15 AM (GMT -03)
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
hook.Add("UCLChanged", "UnoLimited-Check-Groups", function () 
  local groupsUpdated = false
  -- Loop by groups
  for group, g in pairs(ULib.ucl.groups) do
    -- Check if group does not exists in the table
    if unoLimited.groups[group] == nil then
      -- Add group to the table
      unoLimited.groups[group] = 1
      -- Update flag
      groupsUpdated = true
    end
  end
  
  -- Check if groups was updated
  if groupsUpdated then
    -- Save the file
    unoLimited.save()
   
    local players = player.GetAll() -- get the list of players
    for _, ply in ipairs(players) do -- loop through the table
        unoLimited.sendLimits(ply)
    end
  end
end)

-- Receive Player's Limits
net.Receive( "UnoLimited", unoLimited.receiveLimits )
