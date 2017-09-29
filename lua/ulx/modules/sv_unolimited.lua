-- UnoLimited
-- Copyleft (c) 2013 Nexus [BR] <http://www.nexusbr.net>
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
-- Version 2.5.2 - 2017-16-01 09:50 PM by Nexus [BR]

-- check if ULIB is Loaded
if ULib ~= nil then
	
	-- Show StartUp Info
	Msg( "//  UnoLimited v" .. unoLimited.version .. "        //\n")
	
	-- Register ULIB Flag
	ULib.ucl.registerAccess( unoLimited.accessFlag, { "superadmin" }, "Give Manager Access to UnoLimited", "UnoLimited" )

	-- Get Limit
	unoLimited.getLimit = function ( ply, str )
		-- Get Player's Group
		local group = ply:GetUserGroup()
		
		-- Default Limit is 1x
		local finalLimit = GetConVarNumber( "sbox_max"..str )		
		
		-- Check if Game is Singleplayer and Group is Set
		if not game.SinglePlayer() or unoLimited.groups[ group ] ~= nil then
			-- Get Limit Multiplier
			local mult = tonumber( unoLimited.groups[ group ] )				

			-- Check if Limits was Disabled
			if mult == -1 then
				-- Return -1 to disable Limits
				finalLimit = -1
			-- Check if Multiplier is valid
			elseif mult > 0 then			
				-- The Final Limit Calculation
				finalLimit = math.floor( mult * GetConVarNumber( "sbox_max" .. str ) )
			-- Check if Multiplier is zero
			elseif mult == 0 then
				finalLimit = 0
			end
		-- Check if Game is SinglePlayer
		elseif game.SinglePlayer() then
			-- Disable Limits if Game is Single Player
			finalLimit = -1
		-- check if group is not set
		elseif unoLimited.groups[ group ] == nil then
			-- Define Standard Limit
			finalLimit = 1
		end
				
		-- Return the Current Limit
		return finalLimit
	end
	
	-- Hander, Limit Handler
	unoLimited.handler = function ( ply, str )
		-- Get Player Limit
		local limit = unoLimited.getLimit( ply, str )

		-- Disable the Spawn Limits if multiplier is -1
		if limit == -1 then
			return true
		end
		
		-- Check if Player hit the Spawn Count
		if limit > ply:GetCount( str ) and limit > 0 then
			return true
		end
		
		-- Send a Hint about the Hit to player
		ply:LimitHit( str )

		return false
	end
	
	-- Get Player MetaTable
	local meta = FindMetaTable( "Player" )
	
	-- Setup Check Limit
	function meta:CheckLimit( str )
		-- No limits in single player
		if not game.SinglePlayer() then 	
			-- Get Limit
			local limit = unoLimited.getLimit( self, str )
			
			-- Check if Limit is Enabled
			if limit > 0 then	
				-- Check if Limit was Reached	
				if self:GetCount( str ) > limit - 1 then 
					-- Hit Limit
					self:LimitHit( str ) 
					-- Return False to block player to spawn
					return false 
				end
			end
		end
		
		-- Return True for No Limit
		return true		
	end
	
	-- Setup Spawn Ragdoll Handler
	hook.Add( "PlayerSpawnRagdoll","UnoLimited-Ragdoll", function ( ply )
    return unoLimited.handler( ply, "ragdolls" )
	end)
	
	-- Setup Spawn Prop Handler
	hook.Add( "PlayerSpawnProp", "UnoLimited-Prop", function ( ply )
		return unoLimited.handler( ply, "props" )
	end)
	
	-- Setup Spawn Effect Handler
	hook.Add( "PlayerSpawnEffect", "UnoLimited-Effect", function ( ply )
		return unoLimited.handler( ply, "effects" )
	end)
	
	-- Setup Spawn Vehicle Handler
	hook.Add( "PlayerSpawnVehicle", "UnoLimited-Vehicle", function ( ply )
		return unoLimited.handler( ply, "vehicles" )
	end)
	
	-- Setup Spawn NPC Handler
	hook.Add( "PlayerSpawnNPC", "UnoLimited-NPC", function( ply )
		  return unoLimited.handler( ply, "npcs" )
	end)
	
	-- Setup Spawn SENT Handler
	hook.Add( "PlayerSpawnSENT", "UnoLimited-SENT", function( ply )
		return unoLimited.handler( ply, "sents" )
	end)
else
	Msg( "\n ** UnoLimited v"..unoLimited.version.." REQUIRES ULX v3.51+ .. Aborting\n\n" )
end
