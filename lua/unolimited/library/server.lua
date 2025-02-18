--[[ 
 UnoLimited
 
 Copyright (c) 2013 - 2025 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5.6 by Dathus [BR] on 2023-10-29 08:53 AM (GMT -03)
]]--

-- Save Vars
unoLimited.saveDir = "unolimited"
unoLimited.saveFile = unoLimited.saveDir .. "/limits.txt"

-- Save UnoLimited Limits to File
unoLimited.save = function ()
	-- Check if unoLimited Data Folder Exists
	if not file.Exists( unoLimited.saveDir, "DATA" ) then
		-- Create Data folder unoLimited
		file.CreateDir( unoLimited.saveDir )
	end
	
	-- Write Default Limits to File
	file.Write( unoLimited.saveFile, von.serialize( unoLimited.groups ) )		
end

-- Reload UnoLimited Groups
unoLimited.loadSave = function ()
	-- Check if Save File was Created
	if not file.Exists( unoLimited.saveFile, "DATA" ) then
		-- Save
		unoLimited.save()	
	end
	
	-- Get UnoLimited Groups table from Save File	
	unoLimited.groups = von.deserialize( file.Read( unoLimited.saveFile, "DATA" ) )
end

-- Send Limits to a Player
unoLimited.sendLimits = function ( ply )
	-- Start Transmission
	net.Start( "UnoLimited" )	
	-- Send Table
	net.WriteTable( unoLimited.groups )
	-- Send Transmission to Player
	net.Send( ply )
end

-- Receive Client Limits
unoLimited.receiveLimits = function ( len, ply )
	-- Check if user Have Access
	if unoLimited.checkAccess( ply ) then
		-- Read Groups Table
		unoLimited.groups = net.ReadTable()
		
		-- Broadcast the new Limits to all Players
		net.Start( "UnoLimited" )
		net.WriteTable( unoLimited.groups )
		net.Broadcast()
		
		-- Save Limits
		unoLimited.save()
	else
		-- Ban UnAuthorized Player
		ply:Ban( 0, "UnoLimited Anti-Hax" )
	end
end

-- Populate ULX groups in unoLimited groups
unoLimited.populateGroups = function ()
  -- Define if groups was updated
  local groupsUpdated = false
  
  -- Loop by ulx groups
  for group, g in pairs(ULib.ucl.groups) do
    -- Check if group does not exists in the table
    if unoLimited.groups[group] == nil then
      -- Add group to the table
      unoLimited.groups[group] = 1
      -- Update flag
      groupsUpdated = true
    end
  end
  
  -- loop by UnoLimited groups
   for group, g in pairs(unoLimited.groups) do
    -- Check if group does not exists in the table
    if ULib.ucl.groups[group] == nil then
      -- Remove group from the table
      unoLimited.groups[group] = nil
      -- Update flag
      groupsUpdated = true
    end
  end
  
  -- Check if groups was updated
  if groupsUpdated then
    -- Save the file
    unoLimited.save()
  end
  
  return groupsUpdated
end
