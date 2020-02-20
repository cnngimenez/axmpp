--  xmpp-iq_uploads.ads ---

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

with League.Strings;

with XML.SAX.Pretty_Writers;

with XMPP.IQS;

--
--  Implementation of the File Upload IQs (XEP-0363)
--
package XMPP.IQ_Uploads is

    Slot_URI : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String
      ("urn:xmpp:http:upload:0");

    Slot_Element : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String ("slot");

    Get_Element : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String ("get");

    Put_Element : constant League.Strings.Universal_String
      := League.Strings.To_Universal_String ("put");

    type XMPP_IQ_Upload is new XMPP.IQS.XMPP_IQ with private;

    type XMPP_IQ_Upload_Access is access all XMPP_IQ_Upload'Class;

    function Get_Get_URL (Self : XMPP_IQ_Upload) return
      League.Strings.Universal_String;

    function Get_Put_URL (Self : XMPP_IQ_Upload) return
      League.Strings.Universal_String;

    overriding function Get_Kind (Self : XMPP_IQ_Upload) return Object_Kind;

    overriding procedure Serialize
      (Self : XMPP_IQ_Upload;
     Writer : in out XML.SAX.Pretty_Writers.XML_Pretty_Writer'Class);

    overriding
    procedure Set_Content (Self      : in out XMPP_IQ_Upload;
                           Parameter : League.Strings.Universal_String;
                           Value     : League.Strings.Universal_String);

    function Create return not null XMPP_IQ_Upload_Access;

private

    type XMPP_IQ_Upload is new XMPP.IQS.XMPP_IQ with record
        Get_URL : League.Strings.Universal_String;
        Put_URL : League.Strings.Universal_String;
    end record;

end XMPP.IQ_Uploads;
