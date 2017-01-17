-- UnoLimited
-- Copyright (c) 2013 Nexus [BR] <http://www.nexusbr.net>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Former Contributors: Megiddo and JamminR
--
-- $Id$
-- Version 2.5.1 - 19-10-2013 12:51 PM

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
