--  xmpp-plain_auth.adb ---

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

with Ada.Characters.Conversions;
with Ada.Streams;
use Ada.Streams;

with XMPP.Utils;
with XMPP.Base64;
with XMPP.Logger;
use XMPP.Logger;

package body XMPP.PLAIN_Auth is

    function Generate_Stream (Username, Password : Wide_Wide_String)
                             return Stream_Element_Array;

    --  Create the stream needed by the Base64.Encode procedure.
    function Generate_Stream (Username, Password : Wide_Wide_String)
                             return Stream_Element_Array is

        Length : constant Stream_Element_Offset :=
          Username'Length + Password'Length + 2;
        Stream_Index : Stream_Element_Offset;

        Stream_Array : Stream_Element_Array (0 .. Length);

    begin
        --  Zero character
        Stream_Array (0) := 0;

        --  Username
        Stream_Index := 1;
        for I in Username'Range loop
            Stream_Array (Stream_Index) :=
              Stream_Element (Wide_Wide_Character'Pos (Username (I)));
            Stream_Index := Stream_Index + 1;
        end loop;

        --  Zero character
        Stream_Array (Stream_Index) := 0;
        Stream_Index := Stream_Index + 1;

        --  Password
        for I in Password'Range loop
            Stream_Array (Stream_Index) :=
              Stream_Element (Wide_Wide_Character'Pos (Password (I)));
            Stream_Index := Stream_Index + 1;
        end loop;

        return Stream_Array;
    end Generate_Stream;

    function Plain_Password (Username, Password : Wide_Wide_String)
                            return Wide_Wide_String is

        Just_Username : constant Wide_Wide_String :=
          XMPP.Utils.Remove_Host (Username);

        --  The result will have 33% more size at the most according to the
        --  Base64 standard.
        Char_Length : constant Natural :=
          Just_Username'Length + Password'Length + 4;
        Length : constant Natural :=
          Natural
          (4 * Natural
             (Float'Ceiling (Float (Char_Length) / 3.0)));

        Data : String (1 .. Length);
        Last : Natural;

        use Ada.Characters.Conversions;
    begin
        Log (Just_Username);
        Log (Password);
        XMPP.Base64.Encode (Generate_Stream (Just_Username, Password),
                            Data, Last);
        Log (Last'Wide_Wide_Image);
        return To_Wide_Wide_String (Data (1 .. Last));
    end Plain_Password;

end XMPP.PLAIN_Auth;
