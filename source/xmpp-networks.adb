------------------------------------------------------------------------------
--                                                                          --
--                              AXMPP Project                               --
--                                                                          --
--                           XMPP Library for Ada                           --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Alexander Basov <coopht@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Alexander Basov, IE nor the names of its      --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Ada.Characters.Conversions;
with Ada.Exceptions;
with XMPP.Logger;

package body XMPP.Networks is

   use XMPP.Logger;

   use type Ada.Streams.Stream_Element_Offset;

   function "+" (Item : String) return Wide_Wide_String
     renames Ada.Characters.Conversions.To_Wide_Wide_String;

   ---------------
   --  Connect  --
   ---------------
   procedure Connect
    (Self : not null access Network'Class;
     Host : String;
     Port : Natural) is
      No_Block : GNAT.Sockets.Request_Type (GNAT.Sockets.Non_Blocking_IO);

   begin
      Create_Socket (Self.Sock);
      Self.Addr :=
        Sock_Addr_Type'(Addr   =>
                          Addresses (GNAT.Sockets.Get_Host_By_Name (Host), 1),
                        Port   => Port_Type (Port),
                        Family => Family_Inet);

      Set_Socket_Option (Self.Sock,
                         Socket_Level,
                         (Reuse_Address, True));

      Connect_Socket (Self.Sock, Self.Addr);
      Self.Channel := Stream (Self.Sock);

      delay 0.2;

      No_Block.Enabled := True;

      --  Setting non-blocking IO
      GNAT.Sockets.Control_Socket (Self.Get_Socket, No_Block);

      Create_Selector (Self.Selector);
      Empty (Self.RSet);
      Empty (Self.WSet);

      Self.Source.Set_Socket (Self.Sock);
      Self.Source.Object := Self.Target;
      Self.Target.On_Connect;

   exception
      when E : others =>
         Log (+Ada.Exceptions.Exception_Information (E));
   end Connect;

   ------------------
   --  Get_Socket  --
   ------------------
   function Get_Socket (Self : not null access Network'Class)
      return Socket_Type is
   begin
      return Self.Sock;
   end Get_Socket;

   ----------------
   -- Get_Source --
   ----------------

   function Get_Source (Self : not null access Network)
     return not null access XML.SAX.Input_Sources.SAX_Input_Source'Class is
   begin
      return Self.Source'Access;
   end Get_Source;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      --  Initializing gnutls
      GNUTLS.Global_Set_Log_Level (65537);
      GNUTLS.Global_Init;
   end Initialize;

   ------------------------
   -- Is_TLS_Established --
   ------------------------

   function Is_TLS_Established (Self : Network) return Boolean is
   begin
      return Self.Source.Is_TLS_Established;
   end Is_TLS_Established;

   -------------------------
   --  Read_Data_Wrapper  --
   -------------------------
   function Read_Data_Wrapper (Self : not null access Network'Class)
      return Boolean is
      --  for debug
      X  : GNAT.Sockets.Request_Type (GNAT.Sockets.N_Bytes_To_Read);
   begin
      delay (0.1);

      --  Getting how much data available in Socket
      GNAT.Sockets.Control_Socket (Self.Get_Socket, X);

      if X.Size = 0 then
         return False;
      else
         return Self.Target.Read_Data;
      end if;
   end Read_Data_Wrapper;

   ---------------
   --  Recieve  --
   ---------------
   function Recieve (Self : not null access Network'Class) return Boolean is
   begin
      Set (Self.RSet, Self.Sock);
      Log ("Waiting for data in select");

      --  multiplexed i/o, like select in C
      Check_Selector (Self.Selector, Self.RSet, Self.WSet, Self.Status);

      case Self.Status is
         when Completed =>
            if Is_Set (Self.RSet, Self.Sock) then
               return Self.Read_Data_Wrapper;
            else
               return False;
            end if;

         when Expired =>
            return True;

         when Aborted =>
            return False;

      end case;

      --  Set (Self.RSet, Self.Sock);
      --  Empty (Self.RSet);

   exception
      when E : others =>
         Log  (+Ada.Exceptions.Exception_Information (E));
         return False;
   end Recieve;

   ------------
   --  Send  --
   ------------
   procedure Send
    (Self   : not null access Network'Class;
     Data   : Ada.Streams.Stream_Element_Array) is
   begin
      if not Self.Source.Is_TLS_Established then
         Self.Channel.Write (Data);

      else
         Log ("Sendinging data via TLS");

         declare
            Tmp : Ada.Streams.Stream_Element_Array := Data;

            E   : constant GNAT.Sockets.Vector_Element :=
              (Base   => Tmp (Tmp'First)'Unchecked_Access,
               Length => Tmp'Length);

            P : GNAT.Sockets.Vector_Type (0 .. 0);
            L : Ada.Streams.Stream_Element_Count := 1;

         begin
            P (0) := E;
            GNUTLS.Record_Send (Self.TLS, P, L);
         end;
      end if;

   exception
      when E : others =>
         Log  (+Ada.Exceptions.Exception_Information (E));
   end Send;

   -----------------------
   --  Set_TLS_Session  --
   -----------------------
   procedure Set_TLS_Session
     (Self : not null access Network'Class;
      S    : GNUTLS.Session) is
   begin
      Self.TLS := S;
      Self.Source.Set_TLS_Session (S);
   end Set_TLS_Session;

   ---------------------
   -- Start_Handshake --
   ---------------------

   procedure Start_Handshake (Self : in out Network) is
   begin
      Self.Source.Start_Handshake;
   end Start_Handshake;

   --------------------
   --  Task_Stopped  --
   --------------------
   procedure Task_Stopped (Self : not null access Network'Class) is
   begin
      Close_Selector (Self.Selector);
      Close_Socket (Self.Sock);
      Self.Target.On_Disconnect;
   end Task_Stopped;

end XMPP.Networks;
