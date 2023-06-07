--[[ 
 UnoLimited
 
 Copyright (c) 2013-2023 Dathus [BR] <https://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>
 
 This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 To view a copy of this license, visit Common Creative's Website. <https://creativecommons.org/licenses/by-nc-sa/4.0/>
 
 Former Contributors: Megiddo and JamminR
 
 $Id$
 Version 2.5 by Dathus [BR] on 2023-06-06 09:30 PM (GMT -03)
]]--

-- Check if Player have Access to UnoLimited
unoLimited.checkAccess = function ( ply )
	-- Check if Player Have Access
	return ULib.ucl.query( ply, unoLimited.accessFlag )	
end
