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

-- Require Libraries
include( "unolimited/library/shared.lua" )
include( "unolimited/library/client.lua" )

-- Receive Limits
net.Receive( "UnoLimited", unoLimited.receiveLimits )
