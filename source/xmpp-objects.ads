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
with Ada.Containers.Vectors;

with League.Strings;
with XML.SAX.Pretty_Writers;

package XMPP.Objects is

   type Object_Kind is
     (Bind,
      Challenge,
      Disco,
      IQ,
      IQ_Session,
      Error,
      Message,
      MUC,
      Null_Object,
      Presence,
      Roster,
      Roster_Item,
      Stream,
      Stream_Features,
      Version);

   type XMPP_Object is limited interface;

   type XMPP_Object_Access is access all XMPP_Object'Class;

   package Object_Vectors is new Ada.Containers.Vectors
     (Natural, XMPP_Object_Access);

   ----------------
   --  Get_Kind  --
   ----------------
   not overriding
   function Get_Kind (Self : XMPP_Object) return XMPP.Objects.Object_Kind
      is abstract;
   -----------------
   --  Serialize  --
   -----------------
   not overriding
   procedure Serialize
    (Self   : XMPP_Object;
     Writer : in out XML.SAX.Pretty_Writers.SAX_Pretty_Writer'Class)
       is abstract;

   -------------------
   --  Set_Content  --
   -------------------
   not overriding
   procedure Set_Content (Self      : in out XMPP_Object;
                          Parameter : League.Strings.Universal_String;
                          Value     : League.Strings.Universal_String)
      is abstract;

end XMPP.Objects;
