--[[ 
 UnoLimited
 
 Copyright (c) 2013 - 2025 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5 by Dathus [BR] on 2023-10-29 01:15 AM (GMT -03)
]]--

-- Save Client Limits
unoLimited.saveClientLimits = function ()
	-- Add Animation
	unoLimited.GUI.panel:SetVisible( false )
	-- Delete Current Group
	unoLimited.GUI.currentGroup = nil
	-- Clear Selection
	unoLimited.GUI.groups:ClearSelection()
	-- Send Limits to Server
	unoLimited.sendLimits()
end

-- Send Limits to Server
unoLimited.sendLimits = function ( ply )
	net.Start("UnoLimited")	
	net.WriteTable( unoLimited.groups )
	net.SendToServer()
end

-- Receive Limits
unoLimited.receiveLimits = function ()
	-- Read Groups Table
	unoLimited.groups = net.ReadTable()
	
	-- Populate UnoLimited Available Groups
	RunConsoleCommand("unolimited_repopulate");
end
