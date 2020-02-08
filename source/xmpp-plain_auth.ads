--  xmpp-plain_auth.ads ---

--  Copyright 2020 cnngimenez
--
--  Author: cnngimenez

--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.

--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.

--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.

-------------------------------------------------------------------------

--
--  PLAIN authentication implemented for XMPP.
--
package XMPP.PLAIN_Auth is

    --  Return the username and password as a PLAIN Base64 string
    function Plain_Password (Username, Password : Wide_Wide_String)
                            return Wide_Wide_String;

end XMPP.PLAIN_Auth;
