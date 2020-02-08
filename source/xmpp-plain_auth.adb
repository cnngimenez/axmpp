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

with XMPP.Base64;

package body XMPP.PLAIN_Auth is
    
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
        
        --  The result will have 33% more size at the most according to the 
        --  Base64 standard.
        Length : constant Natural := 
          Natural 
          (Float'Ceiling 
             (1.33 * 
                Float (Username'Length + Password'Length + 4)));
          
        Data : String (1 .. Length);
        Last : Natural;
        
        use Ada.Characters.Conversions;
    begin
        XMPP.Base64.Encode (Generate_Stream (Username, Password),
                            Data, Last);
        
        return To_Wide_Wide_String (Data);                
    end Plain_Password;
    
    
end XMPP.PLAIN_Auth;
