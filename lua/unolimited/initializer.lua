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
-- Version 2.5.0 - 18-10-2013 11:52 PM

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
