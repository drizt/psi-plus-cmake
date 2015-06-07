cmake_minimum_required( VERSION 2.8.11 )

set( irisnet_CORELIB
	src/irisnet/corelib/irisnetplugin.cpp
	src/irisnet/corelib/netavailability.cpp
	src/irisnet/corelib/addressresolver.cpp
	src/irisnet/corelib/objectsession.cpp
	src/irisnet/corelib/irisnetglobal.cpp
	src/irisnet/corelib/netinterface.cpp
	src/irisnet/corelib/netnames_jdns.cpp
	src/irisnet/corelib/netnames.cpp
)
if( WIN32 )
	set( irisnet_CORELIB
		${irisnet_CORELIB}
		src/irisnet/corelib/netinterface_win.cpp
	)
else( WIN32 )
	set( irisnet_CORELIB
		${irisnet_CORELIB}
		src/irisnet/corelib/netinterface_unix.cpp
	)
endif( WIN32 )
set( irisnet_APPLEDNS
	src/irisnet/appledns/sdtest.cpp
	src/irisnet/appledns/appledns.cpp
	src/irisnet/appledns/qdnssd.cpp
)
set( irisnet_NONCORE
	src/irisnet/noncore/ice176.cpp
	src/irisnet/noncore/stuntypes.cpp
	src/irisnet/noncore/processquit.cpp
	src/irisnet/noncore/icecomponent.cpp
	src/irisnet/noncore/stunutil.cpp
	src/irisnet/noncore/stuntransaction.cpp
	src/irisnet/noncore/stunallocate.cpp
	src/irisnet/noncore/icetransport.cpp
	src/irisnet/noncore/udpportreserver.cpp
	src/irisnet/noncore/turnclient.cpp
	src/irisnet/noncore/stunbinding.cpp
	src/irisnet/noncore/stunmessage.cpp
	src/irisnet/noncore/icelocaltransport.cpp
	src/irisnet/noncore/iceturntransport.cpp
	src/irisnet/noncore/legacy/ndns.cpp
	src/irisnet/noncore/legacy/servsock.cpp
	src/irisnet/noncore/legacy/srvresolver.cpp
	src/irisnet/noncore/legacy/safedelete.cpp
	src/irisnet/noncore/cutestuff/httppoll.cpp
	src/irisnet/noncore/cutestuff/httpstream.cpp
	src/irisnet/noncore/cutestuff/socks.cpp
	src/irisnet/noncore/cutestuff/bsocket.cpp
	src/irisnet/noncore/cutestuff/networkaccessmanager.cpp
	src/irisnet/noncore/cutestuff/bytestream.cpp
	src/irisnet/noncore/cutestuff/httpconnect.cpp
)
set( xmpp_BASE
	src/xmpp/base/randomnumbergenerator.cpp
)
set( xmpp_SASL
	src/xmpp/sasl/scramsha1response.cpp
	src/xmpp/sasl/plainmessage.cpp
	src/xmpp/sasl/digestmd5proplist.cpp
	src/xmpp/sasl/scramsha1message.cpp
	src/xmpp/sasl/digestmd5response.cpp
	src/xmpp/sasl/scramsha1signature.cpp
)
set( xmpp_ZLIB
	src/xmpp/zlib/zlibcompressor.cpp
	src/xmpp/zlib/zlibdecompressor.cpp
)
set( xmpp_IM
	src/xmpp/xmpp-im/xmpp_tasks.cpp
	src/xmpp/xmpp-im/xmpp_discoitem.cpp
	src/xmpp/xmpp-im/filetransfer.cpp
	src/xmpp/xmpp-im/types.cpp
	src/xmpp/xmpp-im/xmpp_xmlcommon.cpp
	src/xmpp/xmpp-im/s5b.cpp
	src/xmpp/xmpp-im/xmpp_discoinfotask.cpp
	src/xmpp/xmpp-im/xmpp_ibb.cpp
	src/xmpp/xmpp-im/xmpp_task.cpp
	src/xmpp/xmpp-im/client.cpp
	src/xmpp/xmpp-im/xmpp_bytestream.cpp
	src/xmpp/xmpp-im/xmpp_vcard.cpp
	src/xmpp/xmpp-im/xmpp_features.cpp
	src/xmpp/xmpp-im/xmpp_xdata.cpp
	src/xmpp/xmpp-im/xmpp_bitsofbinary.cpp
)
set( xmpp_CORE
	src/xmpp/xmpp-core/xmlprotocol.cpp
	src/xmpp/xmpp-core/simplesasl.cpp
	src/xmpp/xmpp-core/stream.cpp
	src/xmpp/xmpp-core/xmpp_stanza.cpp
	src/xmpp/xmpp-core/tlshandler.cpp
	src/xmpp/xmpp-core/securestream.cpp
	src/xmpp/xmpp-core/connector.cpp
	src/xmpp/xmpp-core/compressionhandler.cpp
	src/xmpp/xmpp-core/parser.cpp
	src/xmpp/xmpp-core/protocol.cpp
)
set( xmpp_JID
	src/xmpp/jid/jid.cpp
)
#set( jdns_SRC
	#src/jdns/src/qjdns/qjdnsshared.cpp
	#src/jdns/src/qjdns/qjdns_sock.cpp
	#src/jdns/src/qjdns/qjdns.cpp
	#src/jdns/tools/jdns/main.cpp
#)
#Temporary unused
set( xmpp_UNITTESTS
	src/xmpp/base/unittest/randrandomnumbergeneratortest.cpp
	src/xmpp/base/unittest/randomnumbergeneratortest.cpp
	src/xmpp/sasl/unittest/scramsha1responsetest.cpp
	src/xmpp/sasl/unittest/plainmessagetest.cpp
	src/xmpp/sasl/unittest/scramsha1messagetest.cpp
	src/xmpp/sasl/unittest/digestmd5responsetest.cpp
	src/xmpp/qa/qttestutil/testregistry.cpp
	src/xmpp/qa/qttestutil/example/myfirstclasstest.cpp
	src/xmpp/qa/qttestutil/example/mysecondclasstest.cpp
	src/xmpp/qa/qttestutil/simplechecker.cpp
	src/xmpp/qa/unittest.template/myclasstest.cpp
	src/xmpp/jid/unittest/jidtest.cpp
)
set( iris_SRCS
	${irisnet_CORELIB}
	${irisnet_NONCORE}
	${xmpp_BASE}
	${xmpp_SASL}
	${xmpp_ZLIB}
	${xmpp_IM}
	${xmpp_CORE}
	${xmpp_JID}
	${xmpp_QA}
)
if( APPLE )
	set( iris_SRCS
		${iris_SRCS}
		${irisnet_APPLEDNS}
	)
endif( APPLE )

