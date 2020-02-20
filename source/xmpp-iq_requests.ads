--  xmpp-iq_requests.ads ---

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

with XML.SAX.Pretty_Writers;

with XMPP.IQS;

with League.Strings;

--
--  IQ Request Slot for HTTP File Upload (XEP-0363)
--
package XMPP.IQ_Requests is

    Request_URI : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String
      ("urn:xmpp:http:upload:0");

    Request_Element : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String ("request");

    Filename_Attribute : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String ("filename");

    Size_Attribute : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String ("size");

    Content_Type_Attribute : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String ("content-type");

    type XMPP_IQ_Request is new XMPP.IQS.XMPP_IQ with private;

    type XMPP_IQ_Request_Access is access all XMPP_IQ_Request'Class;

    function Get_Filename (Self : XMPP_IQ_Request) return
      League.Strings.Universal_String;

    procedure Set_Filename (Self : in out XMPP_IQ_Request;
                            Value : League.Strings.Universal_String);

    function Get_Size (Self : XMPP_IQ_Request) return
      League.Strings.Universal_String;

    procedure Set_Size (Self : in out XMPP_IQ_Request;
                        Value : League.Strings.Universal_String);

    function Get_Content_Type (Self : XMPP_IQ_Request) return
      League.Strings.Universal_String;

    procedure Set_Content_Type (Self : in out XMPP_IQ_Request;
                                Value : League.Strings.Universal_String);

    overriding function Get_Kind (Self : XMPP_IQ_Request) return Object_Kind;

    overriding procedure Serialize
      (Self : XMPP_IQ_Request;
     Writer : in out XML.SAX.Pretty_Writers.XML_Pretty_Writer'Class);

    overriding
    procedure Set_Content (Self      : in out XMPP_IQ_Request;
                           Parameter : League.Strings.Universal_String;
                           Value     : League.Strings.Universal_String);

    function Create return not null XMPP_IQ_Request_Access;

private

    type XMPP_IQ_Request is new XMPP.IQS.XMPP_IQ with record
        Filename : League.Strings.Universal_String;
        Size : League.Strings.Universal_String;
        Content_Type : League.Strings.Universal_String;
    end record;

end XMPP.IQ_Requests;
