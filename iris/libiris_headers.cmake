cmake_minimum_required( VERSION 2.8.11 ) 

set( irisnet_CORELIB_HDRS
	src/irisnet/corelib/objectsession.h
	src/irisnet/corelib/netnames.h
	src/irisnet/corelib/irisnetglobal_p.h
	src/irisnet/corelib/irisnetexport.h
	src/irisnet/corelib/netavailability.h
	src/irisnet/corelib/addressresolver.h
	src/irisnet/corelib/irisnetplugin.h
	src/irisnet/corelib/irisnetglobal.h
	src/irisnet/corelib/netinterface.h
)
set( irisnet_NONCORE_HDRS
	src/irisnet/noncore/iceturntransport.h
	src/irisnet/noncore/icetransport.h
	src/irisnet/noncore/stuntransaction.h
	src/irisnet/noncore/stunbinding.h
	src/irisnet/noncore/processquit.h
	src/irisnet/noncore/stuntypes.h
	src/irisnet/noncore/ice176.h
	src/irisnet/noncore/icelocaltransport.h
	src/irisnet/noncore/udpportreserver.h
	src/irisnet/noncore/turnclient.h
	src/irisnet/noncore/stunutil.h
	src/irisnet/noncore/stunallocate.h
	src/irisnet/noncore/legacy/servsock.h
	src/irisnet/noncore/legacy/safedelete.h
	src/irisnet/noncore/legacy/ndns.h
	src/irisnet/noncore/legacy/srvresolver.h
	src/irisnet/noncore/stunmessage.h
	src/irisnet/noncore/icecomponent.h
	src/irisnet/noncore/cutestuff/httppoll.h
	src/irisnet/noncore/cutestuff/networkaccessmanager.h
	src/irisnet/noncore/cutestuff/httpstream.h
	src/irisnet/noncore/cutestuff/httpconnect.h
	src/irisnet/noncore/cutestuff/bsocket.h
	src/irisnet/noncore/cutestuff/bytestream.h
	src/irisnet/noncore/cutestuff/socks.h
)
set( irsinet_APPLEDNS_HDRS
	src/irisnet/appledns/qdnssd.h
)
set( xmpp_BASE_HDRS
	src/xmpp/base/randrandomnumbergenerator.h
	src/xmpp/base/randomnumbergenerator.h
	src/xmpp/base/unittest/incrementingrandomnumbergenerator.h
)
set( xmpp_SASL_HDRS
	src/xmpp/sasl/scramsha1response.h
	src/xmpp/sasl/digestmd5proplist.h
	src/xmpp/sasl/scramsha1message.h
	src/xmpp/sasl/plainmessage.h
	src/xmpp/sasl/digestmd5response.h
	src/xmpp/sasl/scramsha1signature.h
)
set( xmpp_ZLIB_HDRS
	src/xmpp/zlib/common.h
	src/xmpp/zlib/zlibcompressor.h
	src/xmpp/zlib/zlibdecompressor.h
)
set( xmpp_IM_HDRS
	src/xmpp/xmpp-im/xmpp_features.h
	src/xmpp/xmpp-im/xmpp_bytestream.h
	src/xmpp/xmpp-im/xmpp_tasks.h
	src/xmpp/xmpp-im/xmpp_ibb.h
	src/xmpp/xmpp-im/xmpp_url.h
	src/xmpp/xmpp-im/xmpp_liveroster.h
	src/xmpp/xmpp-im/im.h
	src/xmpp/xmpp-im/xmpp_agentitem.h
	src/xmpp/xmpp-im/xmpp_chatstate.h
	src/xmpp/xmpp-im/xmpp_muc.h
	src/xmpp/xmpp-im/xmpp_xdata.h
	src/xmpp/xmpp-im/xmpp_task.h
	src/xmpp/xmpp-im/xmpp_htmlelement.h
	src/xmpp/xmpp-im/xmpp_resourcelist.h
	src/xmpp/xmpp-im/xmpp_resource.h
	src/xmpp/xmpp-im/xmpp_rosterx.h
	src/xmpp/xmpp-im/xmpp_liverosteritem.h
	src/xmpp/xmpp-im/xmpp_pubsubitem.h
	src/xmpp/xmpp-im/xmpp_roster.h
	src/xmpp/xmpp-im/filetransfer.h
	src/xmpp/xmpp-im/s5b.h
	src/xmpp/xmpp-im/xmpp_status.h
	src/xmpp/xmpp-im/xmpp_vcard.h
	src/xmpp/xmpp-im/xmpp_httpauthrequest.h
	src/xmpp/xmpp-im/xmpp_address.h
	src/xmpp/xmpp-im/xmpp_client.h
	src/xmpp/xmpp-im/xmpp_discoitem.h
	src/xmpp/xmpp-im/xmpp_bitsofbinary.h
	src/xmpp/xmpp-im/xmpp_xmlcommon.h
	src/xmpp/xmpp-im/xmpp_rosteritem.h
	src/xmpp/xmpp-im/xmpp_discoinfotask.h
	src/xmpp/xmpp-im/xmpp_receipts.h
	src/xmpp/xmpp-im/xmpp_pubsubretraction.h
	src/xmpp/xmpp-im/xmpp_message.h
)
set( xmpp_CORE_HDRS
	src/xmpp/xmpp-core/xmpp_stream.h
	src/xmpp/xmpp-core/td.h
	src/xmpp/xmpp-core/compressionhandler.h
	src/xmpp/xmpp-core/xmlprotocol.h
	src/xmpp/xmpp-core/xmpp.h
	src/xmpp/xmpp-core/parser.h
	src/xmpp/xmpp-core/xmpp_stanza.h
	src/xmpp/xmpp-core/simplesasl.h
	src/xmpp/xmpp-core/securestream.h
	src/xmpp/xmpp-core/protocol.h
	src/xmpp/xmpp-core/xmpp_clientstream.h
)
set( xmpp_JID_HDRS
	src/xmpp/jid/jid.h
)
set( xmpp_QA_HDRS
	src/xmpp/qa/qttestutil/testregistry.h
	src/xmpp/qa/qttestutil/testregistration.h
	src/xmpp/qa/qttestutil/qttestutil.h
)
set( iris_HDRS
	${irisnet_CORELIB_HDRS}
	${irisnet_NONCORE_HDRS}
	${xmpp_BASE_HDRS}
	${xmpp_SASL_HDRS}
	${xmpp_ZLIB_HDRS}
	${xmpp_IM_HDRS}
	${xmpp_CORE_HDRS}
	${xmpp_JID_HDRS}
)

if( APPLE )
	set( iris_HDRS ${iris_HDRS} ${irsinet_APPLEDNS_HDRS} )
endif( APPLE )