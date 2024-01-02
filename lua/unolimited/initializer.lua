--[[ 
 UnoLimited
 
 Copyright (c) 2013 - 2024 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5.6 by Dathus [BR] on 2023-10-29 08:53 AM (GMT -03)
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
-- Detect when ULC was changed and send limits to all players forcing XGUI groups column to reload
hook.Add("UCLChanged", "UnoLimited-Check-Groups", function ()   
  -- Populate ULX groups in UnoLimited groups
  local groupsUpdated = unoLimited.populateGroups()
  
  -- Check if groups was updated
  if groupsUpdated then   
    -- Loop by list of players
    for _, ply in ipairs(player.GetAll()) do
        unoLimited.sendLimits(ply)
    end
  end
end)

-- Receive Player's Limits
net.Receive( "UnoLimited", unoLimited.receiveLimits )
