--  xmpp-iq_uploads.adb ---

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

--  with XML.SAX.Attributes;

package body XMPP.IQ_Uploads is

    function Create return not null XMPP_IQ_Upload_Access is
    begin
        return new XMPP_IQ_Upload;
    end Create;

    function Get_Get_URL (Self : XMPP_IQ_Upload) return
      League.Strings.Universal_String is
    begin
        return Self.Get_URL;
    end Get_Get_URL;

    overriding function Get_Kind (Self : XMPP_IQ_Upload) return Object_Kind is
        pragma Unreferenced (Self);
    begin
        return IQ_Upload;
    end Get_Kind;

    function Get_Put_URL (Self : XMPP_IQ_Upload) return
      League.Strings.Universal_String is
    begin
        return Self.Put_URL;
    end Get_Put_URL;

    overriding procedure Serialize
      (Self : XMPP_IQ_Upload;
       Writer : in out XML.SAX.Pretty_Writers.XML_Pretty_Writer'Class) is

        --  Attrs : XML.SAX.Attributes.SAX_Attributes;

    begin
        Self.Start_IQ (Writer);

        --  Children tags : Slot

        Writer.Start_Prefix_Mapping (Namespace_URI => Slot_URI);

        Writer.Start_Element (Namespace_URI => Slot_URI,
                              Local_Name => Slot_Element);

        --  Tags : slot > get
        if not Self.Get_URL.Is_Empty then
            Writer.Start_Element (Qualified_Name => Get_Element);
            Writer.Characters (Self.Get_URL);
            Writer.End_Element (Qualified_Name => Get_Element);
        end if;

        --  Tags : slot > put
        if not Self.Put_URL.Is_Empty then
            Writer.Start_Element (Qualified_Name => Put_Element);
            Writer.Characters (Self.Put_URL);
            Writer.End_Element (Qualified_Name => Put_Element);
        end if;

        Writer.End_Element (Namespace_URI => Slot_URI,
                              Local_Name => Slot_Element);

        Self.End_IQ (Writer);
    end Serialize;

    overriding
    procedure Set_Content (Self      : in out XMPP_IQ_Upload;
                           Parameter : League.Strings.Universal_String;
                           Value     : League.Strings.Universal_String) is
        use League.Strings;

    begin
        if Parameter = To_Universal_String ("get") then
            Self.Get_URL := Value;
        elsif Parameter = To_Universal_String ("put") then
            Self.Put_URL := Value;
        elsif Parameter = To_Universal_String ("slot") then
            null; --  ignore <slot> tag.
        else
            XMPP.IQS.Set_Content
              (XMPP.IQS.XMPP_IQ (Self), Parameter, Value);
        end if;
    end Set_Content;

end XMPP.IQ_Uploads;
