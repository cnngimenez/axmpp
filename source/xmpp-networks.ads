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
with Ada.Streams;

with GNAT.Sockets;

with GNUTLS;

package XMPP.Networks is

   use GNAT.Sockets;

   type Network is abstract tagged limited private;

   type Network_Access is access all Network'Class;

   --  functions, which should be overriden
   not overriding
   procedure On_Connect (Self : not null access Network) is abstract;

   not overriding
   procedure On_Disconnect (Self : not null access Network) is abstract;

   not overriding function Read_Data (Self : not null access Network)
      return Boolean is abstract;
   --  This function is called (from Receive) when there is some data in
   --  the socket. It should read the data from the socket and return True if
   --  ok or False in case of an unrecoverable error.

   --  end of functions, which should be overriden

   procedure Connect (Self : not null access Network'Class;
                      Host : String;
                      Port : Natural);

   procedure Send (Self    : not null access Network'Class;
                   Data    : Ada.Streams.Stream_Element_Array;
                   Via_TLS : Boolean := False);

   --  These two subprograms are called by Idle task
   function Recieve (Self : not null access Network'Class) return Boolean;
   --  Wait for some data in the socket and read them. Return False is error
   procedure Task_Stopped (Self : not null access Network'Class);
   --  Close socket and call On_Disconnect

   --  XXX: this function must be removed.
   function Get_Socket (Self : not null access Network'Class)
      return Socket_Type;

   procedure Set_TLS_Session (Self : not null access Network'Class;
                              S    : GNUTLS.Session);

private

   type Network is abstract tagged limited record
      Addr         : Sock_Addr_Type;
      Sock         : Socket_Type;
      Channel      : Stream_Access;
      Selector     : Selector_Type;
      WSet         : Socket_Set_Type;
      RSet         : Socket_Set_Type;
      Status       : Selector_Status;
      TLS          : GNUTLS.Session;
   end record;

   function Read_Data_Wrapper (Self : not null access Network'Class)
      return Boolean;

end XMPP.Networks;
