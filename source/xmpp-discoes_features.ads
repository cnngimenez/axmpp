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
--  <Unit> XMPP.Discoes.Features
--  <ImplementationNotes>
--
------------------------------------------------------------------------------
--  $Revision$ $Author$
--  $Date$
------------------------------------------------------------------------------
with Ada.Containers.Vectors;

package XMPP.Discoes_Features is

   type Feature is
     (DNS_Srv,
      --  Support for DNS SRV lookups of XMPP services.
      --  RFC 3920: XMPP Core, RFC 3921: XMPP IM

      Full_Unicode,
      --  Support for Unicode characters, including in displayed text,
      --  JIDs, and passwords.

      GC_1_0,
      --  Support for the "groupchat 1.0" protocol.
      --  XEP-0045: Multi-User Chat

      IPV6,
      --  Application supports IPv6.

      Jabber_Client,
      --  See RFC 3921
      --  RFC 3921: XMPP IM

      Jabber_Component_Accept,
      --  See XEP-0114
      --  XEP-0114: Existing Component Protocol

      Jabber_Component_Connect,
      --  See XEP-0114
      --  XEP-0114: Existing Component Protocol

      Jabber_Iq_Auth,
      --  See XEP-0078
      --  XEP-0078: Non-SASL Authentication

      Jabber_Iq_Browse,
      --  See XEP-0011
      --  XEP-0011 (DEPRECATED)

      Jabber_Iq_Gateway,
      --  See XEP-0100
      --  XEP-0100: Gateway Interaction

      Jabber_Iq_Last,
      --  See XEP-0012
      --  XEP-0012: Last Activity

      Jabber_Iq_Oob,
      --  See XEP-0066
      --  XEP-0066: Out of Band Data

      Jabber_Iq_Pass,
      --  See XEP-0003
      --  XEP-0003 (DEPRECATED)

      Jabber_Iq_Privacy,
      --  See RFC 3921
      --  RFC 3921: XMPP IM

      Jabber_Iq_Private,
      --  See XEP-0049
      --  XEP-0049: Private XML Storage

      Jabber_Iq_Register,
      --  See XEP-0077
      --  XEP-0077: In-Band Registration

      Jabber_Iq_Roster,
      --  See RFC 3921
      --  RFC 3921: XMPP IM

      Jabber_Iq_Rpc,
      --  See XEP-0009
      --  XEP-0009: Jabber-RPC

      Jabber_Iq_Search,
      --  See XEP-0055
      --  XEP-0055: Jabber Search

      Jabber_Iq_Time,
      --  DEPRECATED
      --  XEP-0202: Entity Time

      Jabber_Iq_Version,
      --  See XEP-0092
      --  XEP-0092: Software Version

      Jabber_Server,
      --  See RFC 3921
      --  RFC 3921: XMPP IM

      Jabber_X_Data,
      --  See XEP-0004
      --  XEP-0004: Data Forms

      Jabber_X_Delay,
      --  DEPRECATED
      --  XEP-0203: Delayed Delivery

      Jabber_X_Encrypted,
      --  See XEP-0027
      --  XEP-0027: Current OpenPGP Usage

      Jabber_X_Event,
      --  See XEP-0022
      --  XEP-0022 (DEPRECATED)

      Jabber_X_Expire,
      --  See XEP-0023
      --  XEP-0023 (DEPRECATED)

      Jabber_X_Oob,
      --  See XEP-0066
      --  XEP-0066: Out of Band Data

      Jabber_X_Roster,
      --  See XEP-0093
      --  XEP-0093 (DEPRECATED)

      Jabber_X_Signed,
      --  See XEP-0027
      --  XEP-0027: Current OpenPGP Usage

      Msglog,
      --  Application performs logging or archiving of messages.

      Msgoffline,
      --  Server stores messages offline for later delivery.
      --  XEP-0160: Best Practices for Handling Offline Messages

      Muc_Hidden,
      --  Hidden room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Membersonly,
      --  Members-only room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Moderated,
      --  Moderated room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Nonanonymous,
      --  Non-anonymous room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Open,
      --  Open room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Passwordprotected,
      --  Password-protected room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Persistent,
      --  Persistent room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Public,
      --  Public room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Rooms,
      --  List of MUC rooms (each as a separate item)
      --  XEP-0045: Multi-User Chat

      Muc_Semianonymous,
      --  Semi-anonymous room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Temporary,
      --  Temporary room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Unmoderated,
      --  Unmoderated room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Muc_Unsecured,
      --  Unsecured room in Multi-User Chat (MUC)
      --  XEP-0045: Multi-User Chat

      Protocol_Activity,
      --  See XEP-0108
      --  XEP-0108: User Activity

      Protocol_Pubsub_Publish,
      --  Publishing items is supported.
      --  XEP-0060

      Protocol_Pubsub_Subscribe,
      --  Subscribing and unsubscribing are supported.
      --  XEP-0060

      Protocol_Rosterx,
      --  See XEP-0144
      --  XEP-0144: Roster Item Exchange

      Protocol_Sipub,
      --  See XEP-0137
      --  XEP-0137: Publishing SI Requests

      Protocol_Soap,
      --  See XEP-0072
      --  XEP-0072: SOAP Over XMPP

      Protocol_Soap_Fault,
      --  See XEP-0072
      --  XEP-0072: SOAP Over XMPP

      Protocol_Waitinglist,
      --  See XEP-0130
      --  XEP-0130: Waiting Lists


      Protocol_Address,
      --  See XEP-0033
      --  XEP-0033: Extended Stanza Addressing

      Protocol_Amp,
      --  See XEP-0079
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Action_Alert,
      --  Support for the "alert" action in Advanced Message Processing.
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Action_Drop,
      --  Support for the "drop" action in Advanced Message Processing.
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Action_Error,
      --  Support for the "error" action in Advanced Message Processing.
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Action_Notify,
      --  Support for the "notify" action in Advanced Message Processing.
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Condition_Deliver,
      --  Support for the "deliver" condition in Advanced Message Processing.
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Condition_Expire_At,
      --  Support for the "expire-at" condition in Advanced Message Processing.
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Condition_Match_Resource,
      --  Support for the "match-resource" condition
      --  in Advanced Message Processing.
      --  XEP-0079: Advanced Message Processing

      Protocol_Amp_Errors,
      --  See XEP-0079
      --  XEP-0079: Advanced Message Processing

      Protocol_Bytestreams,
      --  See XEP-0065
      --  XEP-0065: SOCKS5 Bytestreams

      Protocol_Bytestreams_UDP,
      --  See XEP-0065
      --  XEP-0065: SOCKS5 Bytestreams

      Protocol_Caps,
      --  See XEP-0115
      --  XEP-0115: Entity Capabilities

      Protocol_Chatstates,
      --  See XEP-0085
      --  XEP-0085: Chat State Notifications

      Protocol_Commands,
      --  See XEP-0050
      --  XEP-0050: Ad-Hoc Commands

      Protocol_Compress,
      --  See XEP-0138
      --  XEP-0138: Stream Compression

      Protocol_Disco_Info,
      --  See XEP-0030
      --  XEP-0030: Service Discovery

      Protocol_Disco_Items,
      --  See XEP-0030
      --  XEP-0030: Service Discovery

      Protocol_Feature_Neg,
      --  See XEP-0020
      --  XEP-0020: Feature Negotiation

      Protocol_Geoloc,
      --  See XEP-0080
      --  XEP-0080: User Geolocation

      Protocol_HTTP_Auth,
      --  See XEP-0072
      --  XEP-0072: SOAP Over XMPP

      Protocol_HTTP_BIND,
      --  See XEP-0124
      --  XEP-0124: Bidirectional-streams Over Synchronous HTTP

      Protocol_Ibb,
      --  See XEP-0047
      --  XEP-0047: In-Band Bytestreams

      Protocol_MUC,
      --  See XEP-0045
      --  XEP-0045: Multi-User Chat

      Protocol_Mood,
      --  See XEP-0107
      --  XEP-0107: User Mood

      Protocol_Muc_Admin,
      --  See XEP-0045
      --  XEP-0045: Multi-User Chat

      Protocol_Muc_Owner,
      --  See XEP-0045
      --  XEP-0045: Multi-User Chat

      Protocol_Muc_Register,
      --  Support for the muc#register FORM_TYPE in Multi-User Chat.
      --  XEP-0045: Multi-User Chat

      Protocol_Muc_Room_Config,
      --  Support for the muc#roomconfig FORM_TYPE in Multi-User Chat.
      --  XEP-0045: Multi-User Chat

      Protocol_Muc_Room_Info,
      --  Support for the muc#roominfo FORM_TYPE in Multi-User Chat.
      --  XEP-0045: Multi-User Chat

      Protocol_Muc_User,
      --  See XEP-0045
      --  XEP-0045: Multi-User Chat

      Protocol_Offline,
      --  See XEP-0013
      --  XEP-0013: Flexible Offline Message Retrieval

      Protocol_Physloc,
      --  DEPRECATED
      --  XEP-0080: User Geolocation

      Protocol_Pubsub_Access_Authorize,
      --  The default node access model is authorize.
      --  XEP-0060

      Protocol_Pubsub_Access_Open,
      --  The default node access model is open.
      --  XEP-0060

      Protocol_Pubsub_Access_Presence,
      --  The default node access model is presence.
      --  XEP-0060

      Protocol_Pubsub_Access_Roster,
      --  The default node access model is roster.
      --  XEP-0060

      Protocol_Pubsub_Access_Whitelist,
      --  The default node access model is whitelist.
      --  XEP-0060

      Protocol_Pubsub_Auto_Create,
      --  The service supports automatic creation of nodes on first publish.
      --  XEP-0060

      Protocol_Pubsub_Auto_Subscribe,
      --  The service supports automatic subscription to a nodes based
      --  on presence subscription.
      --  XEP-0060

      Protocol_Pubsub_Collections,
      --  Collection nodes are supported.
      --  XEP-0060

      Protocol_Pubsub_Config_Node,
      --  Configuration of node options is supported.
      --  XEP-0060

      Protocol_Pubsub_Create_And_Configure,
      --  Simultaneous creation and configuration of nodes is supported.
      --  XEP-0060

      Protocol_Pubsub_Create_Nodes,
      --  Creation of nodes is supported.
      --  XEP-0060

      Protocol_Pubsub_Delete_Any,
      --  Any publisher may delete an item
      --  (not only the originating publisher).
      --  XEP-0060

      Protocol_Pubsub_Delete_Nodes,
      --  Deletion of nodes is supported.
      --  XEP-0060

      Protocol_Pubsub_Filtered_Notifications,
      --  The service supports filtering of notifications based
      --  on Entity Capabilities.
      --  XEP-0060

      Protocol_Pubsub_Get_Pending,
      --  Retrieval of pending subscription approvals is supported.
      --  XEP-0060

      Protocol_Pubsub_Instant_Nodes,
      --  Creation of instant nodes is supported.
      --  XEP-0060

      Protocol_Pubsub_Item_Ids,
      --  Publishers may specify item identifiers.
      --  XEP-0060

      Protocol_Pubsub_Last_Published,
      --  The service supports sending of the last published item to new
      --  subscribers and to newly available resources.
      --  XEP-0060

      Protocol_Pubsub_Leased_Subscription,
      --  Time-based subscriptions are supported.
      --  XEP-0060

      Protocol_Pubsub_Manage_Subscription,
      --  Node owners may manage subscriptions.
      --  XEP-0060

      Protocol_Pubsub_Member_Affiliation,
      --  The member affiliation is supported.
      --  XEP-0060

      Protocol_Pubsub_Meta_Data,
      --  Node meta-data is supported.
      --  XEP-0060

      Protocol_Pubsub_Modify_Affiliations,
      --  Node owners may modify affiliations.
      --  XEP-0060

      Protocol_Pubsub_Multi_Collection,
      --  A single leaf node may be associated with multiple collections.
      --  XEP-0060

      Protocol_Pubsub_Multi_Subscribe,
      --  A single entity may subscribe to a node multiple times.
      --  XEP-0060

      Protocol_Pubsub_Outcast_Affiliation,
      --  The outcast affiliation is supported.
      --  XEP-0060

      Protocol_Pubsub_Persistent_Items,
      --  Persistent items are supported.
      --  XEP-0060

      Protocol_Pubsub_Presence_Notifications,
      --  Presence-based delivery of event notifications is supported.
      --  XEP-0060

      Protocol_Pubsub_Presence_Subscribe,
      --  Implicit presence-based subscriptions are supported.
      --  XEP-0060

      Protocol_Pubsub_Publish_Options,
      --  Publication with publish options is supported.
      --  XEP-0060

      Protocol_Pubsub_Publisher_Affiliation,
      --  The publisher affiliation is supported.
      --  XEP-0060

      Protocol_Pubsub_Purge_Nodes,
      --  Purging of nodes is supported.
      --  XEP-0060

      Protocol_Pubsub_Retract_Items,
      --  Item retraction is supported.
      --  XEP-0060

      Protocol_Pubsub_Retrieve_Affiliations,
      --  Retrieval of current affiliations is supported.
      --  XEP-0060

      Protocol_Pubsub_Retrieve_Default,
      --  Retrieval of default node configuration is supported.
      --  XEP-0060

      Protocol_Pubsub_Retrieve_Items,
      --  Item retrieval is supported.
      --  XEP-0060

      Protocol_Pubsub_Retrieve_Subscriptions,
      --  Retrieval of current subscriptions is supported.
      --  XEP-0060

      Protocol_Pubsub_Subscription_Notifications,
      --  Notification of subscription state changes is supported.
      --  XEP-0060

      Protocol_Pubsub_Subscription_Options,
      --  Configuration of subscription options is supported.
      --  XEP-0060

      Protocol_Waitinglist_Schemes_Mailto,
      --  Waiting list service supports the mailto: URI scheme.
      --  XEP-0130: Waiting Lists

      Protocol_Waitinglist_Schemes_Tel,
      --  Waiting list service supports the tel: URI scheme.
      --  XEP-0130: Waiting Lists

      Protocol_Xdata_Layout,
      --  See XEP-0141
      --  XEP-0141: Data Forms Layout

      Protocol_Xdata_Validate,
      --  See XEP-0122
      --  XEP-0122: Data Forms Validation

      Protocol_Xhtml_Im,
      --  See XEP-0071
      --  XEP-0071: XHTML-IM

      Roster_Delimiter,
      --  See XEP-0083
      --  XEP-0083: Nested Roster Groups

      SSLC2S,
      --  Application supports old-style (pre-TLS)
      --  SSL connections on a dedicated port.

      String_Prep,
      --  Application supports the nameprep, nodeprep,
      --  and resourceprep profiles of stringprep.
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Bind,
      --  See RFC 3920
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_E2e,
      --  See RFC 3921
      --  RFC 3923: XMPP E2E

      Urn_Ietf_Params_Xml_Ns_Xmpp_Sasl,
      --  See RFC 3920
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Sasl_C2s,
      --  Application supports client-to-server SASL.
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Sasl_S2s,
      --  Application supports server-to-server SASL.
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Session,
      --  See RFC 3921
      --  RFC 3921: XMPP IM

      Urn_Ietf_Params_Xml_Ns_Xmpp_Stanzas,
      --  See RFC 3920
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Streams,
      --  See RFC 3920
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Tls,
      --  See RFC 3920
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Tls_C2s,
      --  Application supports client-to-server TLS.
      --  RFC 3920: XMPP Core

      Urn_Ietf_Params_Xml_Ns_Xmpp_Tls_S2s,
      --  Application supports server-to-server TLS.
      --  RFC 3920: XMPP Core

      Urn_Xmpp_Archive_Manage,
      --  Server supports management of archived messages
      --  XEP-0136: Message Archiving

      Vcard_Temp,
      --  See XEP-0054
      --  XEP-0054: vcard-temp

      Urn_Ietf_Rfc_3264,
      --  See XEP-0176
      --  XEP-0176: Jingle ICE-UDP Transport Method

      Urn_Xmpp_Archive_Auto,
      --  Server supports automatic message archiving
      --  XEP-0136_ Message Archiving

      Urn_Xmpp_Archive_Manual,
      --  Server supports manual message archiving
      --  XEP-0136: Message Archiving

      Urn_Xmpp_Archive_Pref,
      --  Server supports message archiving preferences
      --  XEP-0136: Message Archiving

      Urn_Xmpp_Avatar_Data,
      --  See XEP-0084
      --  XEP-0084: User Avatars

      Urn_Xmpp_Avatar_Metadata,
      --  See XEP-0084
      --  XEP-0084: User Avatars

      Urn_Xmpp_Delay,
      --  See XEP-0203
      --  XEP-0203: Delayed Delivery

      Urn_Xmpp_Jingle_Apps_Rtp_Audio,
      --  See XEP-0167
      --  XEP-0167: Jingle RTP Sessions

      Urn_Xmpp_Jingle_Apps_Rtp_Video,
      --  See XEP-0167
      --  XEP-0167: Jingle RTP Sessions

      Urn_Xmpp_Ping,
      --  See XEP-0199
      --  XEP-0199: XMPP Ping

      Urn_Xmpp_Receipts,
      --  See XEP-0199
      --  XEP-0199: XMPP Ping

      Urn_Xmpp_Ssn,
      --  Support for Stanza Session Negotiation and its FORM_TYPE
      --  XEP-0155: Stanza Session Negotiation

      Urn_Xmpp_Time,
      --  See XEP-0202
      --  XEP-0202: Entity Time

      Xmllang);
      --  Application supports the 'xml:lang' attribute
      --  as described in RFC 3920.
      --  RFC 3920: XMPP Core

   package Features_Vectors is
      new Ada.Containers.Vectors (Natural, Feature);

   subtype Features_Vector is Features_Vectors.Vector;

end XMPP.Discoes_Features;