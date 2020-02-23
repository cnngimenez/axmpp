--  xmpp-iq_requests.adb ---

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

with XML.SAX.Attributes;

package body XMPP.IQ_Requests is

    function Create return not null XMPP_IQ_Request_Access is
        Request : constant XMPP_IQ_Request_Access
          := new XMPP_IQ_Request;
    begin
        Request.Set_IQ_Kind (Get);
        return Request;
    end Create;

    function Get_Content_Type (Self : XMPP_IQ_Request) return
      League.Strings.Universal_String is
    begin
        return Self.Content_Type;
    end Get_Content_Type;

    function Get_Filename (Self : XMPP_IQ_Request) return
      League.Strings.Universal_String is
    begin
        return Self.Filename;
    end Get_Filename;

    overriding function Get_Kind (Self : XMPP_IQ_Request) return Object_Kind is
        pragma Unreferenced (Self);
    begin
        return IQ_Request;
    end Get_Kind;

    function Get_Size (Self : XMPP_IQ_Request) return
      League.Strings.Universal_String is
    begin
        return Self.Size;
    end Get_Size;

    overriding procedure Serialize
      (Self : XMPP_IQ_Request;
       Writer : in out XML.SAX.Pretty_Writers.XML_Pretty_Writer'Class) is

        Attrs : XML.SAX.Attributes.SAX_Attributes;

    begin
        Self.Start_IQ (Writer);

        if not Self.Filename.Is_Empty then
            Attrs.Set_Value (Qualified_Name => Filename_Attribute,
                             Value => Self.Filename);
        end if;

        if not Self.Size.Is_Empty then
            Attrs.Set_Value (Qualified_Name => Size_Attribute,
                             Value => Self.Size);
        end if;

        if not Self.Content_Type.Is_Empty then
            Attrs.Set_Value (Qualified_Name => Content_Type_Attribute,
                             Value => Self.Content_Type);
        end if;

        Writer.Start_Prefix_Mapping (Namespace_URI => Request_URI);

        Writer.Start_Element (Namespace_URI => Request_URI,
                              Local_Name => Request_Element,
                              Attributes => Attrs);

        Writer.End_Element (Namespace_URI => Request_URI,
                            Local_Name => Request_Element);

        Self.End_IQ (Writer);
    end Serialize;

    overriding
    procedure Set_Content (Self      : in out XMPP_IQ_Request;
                           Parameter : League.Strings.Universal_String;
                           Value     : League.Strings.Universal_String) is
        use League.Strings;
    begin
        if Parameter = To_Universal_String ("size") then
            Self.Size := Value;
        elsif Parameter = To_Universal_String ("filename") then
            Self.Filename := Value;
        elsif Parameter = To_Universal_String ("content-type") then
            Self.Content_Type := Value;
        elsif Parameter = To_Universal_String ("request") then
            null; --  ignore <request> tag.
        else
            XMPP.IQS.Set_Content
              (XMPP.IQS.XMPP_IQ (Self), Parameter, Value);
        end if;
    end Set_Content;

    procedure Set_Content_Type (Self : in out XMPP_IQ_Request;
                                Value : League.Strings.Universal_String) is
    begin
        --  Ensure that the type is get.
        Self.Set_IQ_Kind (Get);
        Self.Content_Type := Value;
    end Set_Content_Type;

    procedure Set_Filename (Self : in out XMPP_IQ_Request;
                            Value : League.Strings.Universal_String) is
    begin
        --  Ensure that the type is get.
        Self.Set_IQ_Kind (Get);
        Self.Filename := Value;
    end Set_Filename;

    procedure Set_Size (Self : in out XMPP_IQ_Request;
                        Value : League.Strings.Universal_String) is
    begin
        --  Ensure that the type is get.
        Self.Set_IQ_Kind (Get);
        Self.Size := Value;
    end Set_Size;

end XMPP.IQ_Requests;
