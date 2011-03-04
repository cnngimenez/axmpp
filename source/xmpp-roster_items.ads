------------------------------------------------------------------------------
--                                                                          --
--                                 AXMPP                                    --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010 Alexander Basov <coopht@gmail.com>                      --
--                                                                          --
-- This is free software;  you can  redistribute it and/or modify it under  --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion. UIM is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License distributed with UIM;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
------------------------------------------------------------------------------
--
--  <Unit> XMPP.Roster_Items
--  <ImplementationNotes>
--
------------------------------------------------------------------------------
--  $Revision$ $Author$
--  $Date$
------------------------------------------------------------------------------
with League.String_Vectors;
with League.Strings;

with XML.SAX.Pretty_Writers;

with XMPP.Objects;

package XMPP.Roster_Items is

   Item_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("item");

   Group_Element : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("group");

   JID_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("jid");

   Name_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("name");

   Subscription_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("subscription");

   type Subscription_Type is (Both, None);

   type XMPP_Roster_Item is new XMPP.Objects.XMPP_Object with private;

   type XMPP_Roster_Item_Access is access all XMPP_Roster_Item'Class;

   --  Public API
   procedure Set_Subscription (Self  : in out XMPP_Roster_Item;
                               Value : Subscription_Type);
   --  Sets subscribtion type

   function Get_Subscription (Self : XMPP_Roster_Item)
      return Subscription_Type;
   --  Returns subscribtion type

   function Get_JID (Self : XMPP_Roster_Item)
      return League.Strings.Universal_String;
   --  Returns items identifier

   function Get_Name (Self : XMPP_Roster_Item)
      return League.Strings.Universal_String;
   --  Returns items name

   procedure Set_JID (Self : in out XMPP_Roster_Item;
                      Value : League.Strings.Universal_String);
   --  Sets items id

   procedure Set_Name (Self  : in out XMPP_Roster_Item;
                       Value : League.Strings.Universal_String);
   --  Sets items name

   function Create return not null XMPP_Roster_Item_Access;
   --  returns heap allocated object

   procedure Append_Group (Self  : in out XMPP_Roster_Item;
                           Value : League.Strings.Universal_String);

   function Get_Groups (Self : XMPP_Roster_Item)
     return League.String_Vectors.Universal_String_Vector;

   --  Private API
   --  Should not be used in application
   overriding function Get_Kind (Self : XMPP_Roster_Item)
      return Objects.Object_Kind;

   overriding procedure Serialize
    (Self : XMPP_Roster_Item;
     Writer : in out XML.SAX.Pretty_Writers.SAX_Pretty_Writer'Class);

   overriding
   procedure Set_Content (Self      : in out XMPP_Roster_Item;
                          Parameter : League.Strings.Universal_String;
                          Value     : League.Strings.Universal_String);

private

   type XMPP_Roster_Item is new XMPP.Objects.XMPP_Object with
   record
      JID          : League.Strings.Universal_String;
      Name         : League.Strings.Universal_String;
      Subscription : Subscription_Type := None;
      Groups       : League.String_Vectors.Universal_String_Vector;
   end record;

end XMPP.Roster_Items;
