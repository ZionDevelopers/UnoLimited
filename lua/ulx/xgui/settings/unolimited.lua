--[[
 UnoLimited
 
 Copyright (c) 2013 - 2025 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5 by Dathus [BR] on 2023-10-29 01:15 AM (GMT -03)
]]--

-- Preparate Data for XGUI

xgui.prepareDataType( "UnoLimited" )

-- Create Parent Panel
unoLimited.GUI = xlib.makepanel{ parent=xgui.null }
unoLimited.GUI.currentGroup = nil

-- Create Side Parent
unoLimited.GUI.panel = xlib.makepanel{ x=160, y=5, w=415, h=320, parent=unoLimited.GUI, visible=false }
-- Create Groups List
unoLimited.GUI.groups = xlib.makelistview{ x=5, y=5, w=150, h=320, parent=unoLimited.GUI }
-- Add Groups Column
unoLimited.GUI.groups:AddColumn( "Groups" )

-- Setup Event to Show the Limit
unoLimited.GUI.groups.OnRowSelected = function( self, LineID, Line )
	-- Define a Standard Value
	local value = 1
	-- Get Current Group
	unoLimited.GUI.currentGroup = Line:GetValue( 1 )
	-- UnHide the Panel
	unoLimited.GUI.panel:SetVisible(true)
	
	-- Check if Group is Listed
	if unoLimited.groups[ unoLimited.GUI.currentGroup ] ~= nil then
		-- Get Current Value
		value = unoLimited.groups[ unoLimited.GUI.currentGroup ]
	end
	
	-- Set New Value
	unoLimited.limitSlider:SetValue( value )
end

-- Populate UnoLimited Available Groups
unoLimited.populateGroups = function ()
  -- Add Animation
  unoLimited.GUI.panel:SetVisible( false )
  -- Delete Current Group
  unoLimited.GUI.currentGroup = nil
  -- Clear Selection
  unoLimited.GUI.groups:ClearSelection()
  
  -- Empty Groups
  unoLimited.GUI.groups:Clear()
  
  -- Loop by groups
  for k, v in ipairs( xgui.data.groups ) do
  	-- Add Group Line
  	unoLimited.GUI.groups:AddLine( v )
  end
end

-- Populate groups
unoLimited.populateGroups()
-- Add repopulate groups to list of commands
concommand.Add("unolimited_repopulate", unoLimited.populateGroups)

-- Add Limit Slider and hook Event
unoLimited.limitSlider = xlib.makeslider{ x=0, y=0, w=285, label="Limit Multiplier:", min=-1, max=100, value=1, decimal=2, parent=unoLimited.GUI.panel }
unoLimited.limitSlider.OnValueChanged = function( self, val )
	-- Save to Table the New Value
	unoLimited.groups[ unoLimited.GUI.currentGroup ] = val	
end

-- Add Default Button
xlib.makebutton{ x=287, y=0, w=50, label="Default", parent=unoLimited.GUI.panel }.DoClick = function()
	-- Save Limits
	unoLimited.groups[ unoLimited.GUI.currentGroup ] = 1
	unoLimited.limitSlider:SetValue( 1 )
end

-- Add Unlimited Button
xlib.makebutton{ x=340, y=0, w=50, label="Unlimited", parent=unoLimited.GUI.panel }.DoClick = function()
	-- Save Limits
	unoLimited.groups[ unoLimited.GUI.currentGroup ] = -1
	unoLimited.limitSlider:SetValue( -1 )
end

-- Add Save Button
xlib.makebutton{ x=83, y=25, w=150, label="Save", parent=unoLimited.GUI.panel }.DoClick = function()
	-- Save Limits
	unoLimited.saveClientLimits()
end

-- Add Texts
xlib.makelabel{ x=140, y=275, label="UnoLimited v" .. unoLimited.version .. " by Dathus [BR]", parent=unoLimited.GUI.panel }
xlib.makelabel{ x=5, y=300, label="Change Limits of ragdolls, props, effects, vehicles, NPCs and SENTs per User Group.", parent=unoLimited.GUI.panel }

-- Add Module to XGUI
xgui.addSettingModule( "UnoLimited", unoLimited.GUI, "icon16/lock_edit.png", unoLimited.accessFlag )
