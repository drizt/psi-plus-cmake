cmake_minimum_required( VERSION 2.8.11 )

set( HAVE_ASPELL OFF CACHE BOOL "Use aspell spellcheck" )
set( HAVE_ENCHANT OFF CACHE BOOL "Use aspell spellcheck" )

set( libpsi_HDRS
	src/libpsi/tools/zip/minizip/other/zip.h
	src/libpsi/tools/zip/minizip/unzip.h
	src/libpsi/tools/zip/zip.h
	src/libpsi/tools/atomicxmlfile/atomicxmlfile.h
	src/libpsi/tools/iodeviceopener.h
	src/libpsi/tools/simplecli/simplecli.h
	src/libpsi/tools/maybe.h
	src/libpsi/tools/priorityvalidator.h
	src/libpsi/tools/globalshortcut/globalshortcutmanager.h
	src/libpsi/tools/globalshortcut/globalshortcuttrigger.h
	src/libpsi/tools/globalshortcut/NDKeyboardLayout.h
	src/libpsi/tools/systemwatch/systemwatch.h
	src/libpsi/tools/systemwatch/systemwatch_unix.h
	src/libpsi/tools/idle/idle.h
	src/libpsi/dialogs/grepshortcutkeydialog.h
	src/libpsi/widgets/groupchatbrowsewindow.h
)
set( libpsi_spellchecker_HDRS
	src/libpsi/tools/spellchecker/spellchecker.h
	src/libpsi/tools/spellchecker/spellhighlighter.h
)
set( libpsi_aspell_HDRS
	src/libpsi/tools/spellchecker/aspellchecker.h
)
set( libpsi_enchant_HDRS
	src/libpsi/tools/spellchecker/enchantchecker.h
)
if( APPLE )
	set( libpsi_HDRS
		${libpsi_HDRS}
		src/libpsi/tools/growlnotifier/growlnotifier.h
		src/libpsi/tools/spellchecker/macspellchecker.h
		src/libpsi/tools/mac_dock/privateqt_mac.h
		src/libpsi/tools/mac_dock/mac_dock.h
		src/libpsi/tools/systemwatch/systemwatch_mac.h
	)
elseif( WIN32 )
	set( libpsi_HDRS
		${libpsi_HDRS}
		src/libpsi/tools/systemwatch/systemwatch_win.h
		src/libpsi/tools/idle/win32/idleui.h
	)
elseif( UNIX )
	set( libpsi_HDRS
		${libpsi_HDRS}
		
	)
endif( APPLE )	

set( irisprotocol_HDRS
	src/irisprotocol/iris_discoinfoquerier.h
)
set( protocol_HRDS
	src/protocol/discoinfoquerier.h
)
set( sxe_HDRS
	src/sxe/sxeedit.h
	src/sxe/sxesession.h
	src/sxe/sxemanager.h
	src/sxe/sxeremoveedit.h
	src/sxe/sxerecord.h
	src/sxe/sxerecordedit.h
	src/sxe/sxenewedit.h
)
set( capabilities_HDRS
	src/capabilities/capsregistry.h
	src/capabilities/capsspec.h
	src/capabilities/capsmanager.h
)
set( tools_optionstree_HDRS
	src/tools/optionstree/optionstreewriter.h
	src/tools/optionstree/optionstree.h
	src/tools/optionstree/varianttree.h
	src/tools/optionstree/optionstreereader.h
	src/tools/optionstree/optionstreemodel.h
)
set( tools_iconset_HDRS
	src/tools/iconset/anim.h
	src/tools/iconset/iconset.h
)
set( tools_chash_HDRS
	src/tools/crash/crash.h
	src/tools/crash/crash_sigsegv.h
)
set( tools_tunecontroller_HDRS
	src/tools/tunecontroller/tunecontrollerplugin.h
	src/tools/tunecontroller/tune.h
	src/tools/tunecontroller/tunecontrollerinterface.h
	src/tools/tunecontroller/tunecontrollermanager.h
	src/tools/tunecontroller/filetunecontroller.h
	src/tools/tunecontroller/tunecontroller.h
	src/tools/tunecontroller/combinedtunecontroller.h
	src/tools/tunecontroller/pollingtunecontroller.h
	src/tools/tunecontroller/plugins/psifile/psifileplugin.h

)
set( tools_winampcontroller_HDRS
	src/tools/tunecontroller/winamptunecontroller.h
	src/tools/tunecontroller/plugins/winamp/winampplugin.h
	src/tools/tunecontroller/plugins/winamp/winampcontroller.h
	src/tools/tunecontroller/plugins/winamp/third-party/wa_ipc.h
)
set( tools_itunescontroller_HDRDS
	src/tools/tunecontroller/itunestunecontroller.h
	src/tools/tunecontroller/plugins/itunes/itunescontroller.h
)
set( tools_mpriscontroller_HDRS
	src/tools/tunecontroller/mpristunecontroller.h
)
set( tools_aimpcontroller_HDRS
	src/tools/tunecontroller/aimptunecontroller.h
	src/tools/tunecontroller/plugins/aimp/third-party/apiRemote.h
)
set( tools_advwidget_HDRS
	src/tools/advwidget/advwidget.h
)

if( WIN32 )
	set( tools_tunecontroller_HDRS
		${tools_tunecontroller_HDRS}
		${tools_aimpcontroller_HDRS}
		${tools_winampcontroller_HDRS}
	)
elseif( UNIX NOT APPLE )
	set( tools_tunecontroller_HDRS
		${tools_tunecontroller_HDRS}
		${tools_mpriscontroller_HDRS}
	)
elseif( APPLE )
	set( tools_tunecontroller_HDRS
		${tools_tunecontroller_HDRS}
		${tools_itunescontroller_HDRDS}
	)
endif( WIN32 )

set( options_HDRS
	src/options/optionsdlg.h
	src/options/optionsdlgiface.h
	src/options/opt_statuspep.h
	src/options/opt_toolbars.h
	src/options/opt_shortcuts.h
	src/options/opt_statusauto.h
	src/options/opt_iconset.h
	src/options/opt_appearance.h
	src/options/opt_advanced.h
	src/options/opt_events.h
	src/options/opt_popups.h
	src/options/opt_roster.h
	src/options/opt_groupchat.h
	src/options/opt_sound.h
	src/options/opt_avcall.h
	src/options/opt_chat.h
	src/options/optionstab.h
	src/options/opt_status.h
	src/options/opt_tree.h
	src/options/opt_application.h
	src/options/opt_plugins.h
	src/options/opt_statusgeneral.h
	src/options/opt_theme.h
)
set( cocoa_HDRS
	src/CocoaUtilities/cocoacommon.h
	src/CocoaUtilities/CocoaTrayClick.h
	src/CocoaUtilities/CocoaInitializer.h
)
set( mockQCA_HDRS
	src/MockQCA/QtCrypto.h
)
set( autoUpdater_HDRS
	src/AutoUpdater/AutoUpdater.h
	src/AutoUpdater/SparkleAutoUpdater.h
	src/AutoUpdater/QDChecker.h
)
set( contactmanager_HDRS
	src/contactmanager/contactmanagermodel.h
	src/contactmanager/contactmanagerview.h
	src/contactmanager/contactmanagerdlg.h
)
set( avcall_HDRS
	src/avcall/calldlg.h
	src/avcall/avcall.h
	src/avcall/jinglertptasks.h
	src/avcall/jinglertp.h
)
set( tabs_HDRS
	src/tabs/tabdlg.h
	src/tabs/tabbablewidget.h
	src/tabs/tabmanager.h
)
set( certificates_HDRS
	src/Certificates/CertificateErrorDialog.h
	src/Certificates/CertificateDisplayDialog.h
	src/Certificates/CertificateHelpers.h
)
set( privacy_HDRS
	src/privacy/privacydlg.h
	src/privacy/psiprivacymanager.h
	src/privacy/privacymanager.h
	src/privacy/privacyruledlg.h
	src/privacy/privacylistitem.h
	src/privacy/privacylist.h
	src/privacy/privacylistmodel.h
	src/privacy/guitest/mockprivacymanager.h
	src/privacy/privacylistblockedmodel.h
)
set( whiteboarding_HDRS
	src/whiteboarding/wbmanager.h
	src/whiteboarding/wbnewitem.h
	src/whiteboarding/wbwidget.h
	src/whiteboarding/wbscene.h
	src/whiteboarding/wbdlg.h
	src/whiteboarding/wbitem.h
	src/whiteboarding/wbnewimage.h
	src/whiteboarding/wbnewpath.h
)
set( widgets_HDRS
	src/widgets/iconselect.h
	src/widgets/iconwidget.h
	src/widgets/psitabwidget.h
	src/widgets/icontoolbutton.h
	src/widgets/psiwindowheader.h
	src/widgets/updatingcombobox.h
	src/widgets/fancypopup.h
	src/widgets/busywidget.h
	src/widgets/fancypopuplist.h
	src/widgets/iconsetdisplay.h
	src/widgets/private/qeffects_p.h
	src/widgets/stretchwidget.h
	src/widgets/iconsetselect.h
	src/widgets/iconaction.h
	src/widgets/actionlineedit.h
	src/widgets/fancylabel.h
	src/widgets/psirichtext.h
	src/widgets/psitabbar.h
	src/widgets/urllabel.h
	src/widgets/psitiplabel.h
	src/widgets/urlobject.h
	src/widgets/iconbutton.h
	src/widgets/psitooltip.h
	src/widgets/typeaheadfind.h
	src/widgets/iconlabel.h
	src/widgets/tabbar.h
	src/widgets/psiwidgets.h
	src/widgets/psitextview.h
)
set( psimedia_HDRS
	src/psimedia/psimediaprovider.h
	src/psimedia/psimedia.h
)
set( plugins_INCLUDES
	src/plugins/include/soundaccessor.h
	src/plugins/include/accountinfoaccessor.h
	src/plugins/include/iconfactoryaccessor.h
	src/plugins/include/popupaccessinghost.h
	src/plugins/include/popupaccessor.h
	src/plugins/include/eventfilter.h
	src/plugins/include/iqfilter.h
	src/plugins/include/shortcutaccessinghost.h
	src/plugins/include/iqnamespacefilter.h
	src/plugins/include/activetabaccessinghost.h
	src/plugins/include/iqfilteringhost.h
	src/plugins/include/toolbariconaccessor.h
	src/plugins/include/stanzasender.h
	src/plugins/include/contactinfoaccessor.h
	src/plugins/include/plugininfoprovider.h
	src/plugins/include/contactstateaccessinghost.h
	src/plugins/include/contactinfoaccessinghost.h
	src/plugins/include/applicationinfoaccessinghost.h
	src/plugins/include/eventcreatinghost.h
	src/plugins/include/accountinfoaccessinghost.h
	src/plugins/include/contactstateaccessor.h
	src/plugins/include/optionaccessor.h
	src/plugins/include/iconfactoryaccessinghost.h
	src/plugins/include/psiaccountcontroller.h
	src/plugins/include/activetabaccessor.h
	src/plugins/include/stanzafilter.h
	src/plugins/include/stanzasendinghost.h
	src/plugins/include/psiplugin.h
	src/plugins/include/chattabaccessor.h
	src/plugins/include/psiaccountcontrollinghost.h
	src/plugins/include/optionaccessinghost.h
	src/plugins/include/gctoolbariconaccessor.h
	src/plugins/include/shortcutaccessor.h
	src/plugins/include/soundaccessinghost.h
	src/plugins/include/menuaccessor.h
	src/plugins/include/eventcreator.h
	src/plugins/include/applicationinfoaccessor.h
)
set( psiplus_HDRS
	src/accountstatusmenu.h
	src/common.h
	src/ahcformdlg.h
	src/showtextdlg.h
	src/mainwin.h
	src/psioptionseditor.h
	src/contactlistgroupstate.h
	src/timeserver.h
	src/psithemeprovider.h
	src/psiactions.h
	src/proxy.h
	src/contactlistutil.h
	src/psithememodel.h
	src/ahcexecutetask.h
	src/gcuserview.h
	src/rc.h
	src/xdata_widget.h
	src/pluginhost.h
	src/tabcompletion.h
	src/hoverabletreeview.h
	src/contactlistdragview.h
	src/activitydlg.h
	src/accountregdlg.h
	src/contactlistviewdelegate.h
	src/networkaccessmanager.h
	src/ahcservermanager.h
	src/aboutdlg.h
	src/contactlistmodelupdater.h
	src/psiaccount.h
	src/contactlistnestedgroup.h
	src/chatviewcommon.h
	src/contactlistaccountmenu.h
	src/statusdlg.h
	src/mucaffiliationsmodel.h
	src/psicontactlistmodel.h
	src/pgptransaction.h
	src/pubsubsubscription.h
	src/htmltextcontroller.h
	src/ahcommanddlg.h
	src/contactlistitem.h
	src/contactview.h
	src/userlist.h
	src/contactlistitemmenu.h
	src/accountlabel.h
	src/psicontactlistviewdelegate.h
	src/activeprofiles.h
	src/profiledlg.h
	src/psichatdlg.h
	src/popupmanager.h
	src/accountadddlg.h
	src/alerticon.h
	src/profiles.h
	src/filetransdlg.h
	src/ahcommand.h
	src/psievent.h
	src/pixmaputil.h
	src/messageview.h
	src/accountloginpassword.h
	src/infodlg.h
	src/psithemeviewdelegate.h
	src/resourcemenu.h
	src/accountmanagedlg.h
	src/mooddlg.h
	src/miniclient.h
	src/pgpkeydlg.h
	src/psitrayicon.h
	src/psigrowlnotifier.h
	src/psicontactmenu.h
	src/bookmarkmanagedlg.h
	src/mcmdmanager.h
	src/contactlistview.h
	src/contactlistgroup.h
	src/textutil.h
	src/geolocationdlg.h
	src/pluginmanager.h
	src/ahcommandserver.h
	src/mucmanager.h
	src/psipopup.h
	src/discodlg.h
	src/activitycatalog.h
	src/mood.h
	src/dummystream.h
	src/contactlistproxymodel.h
	src/bobfilecache.h
	src/x11windowsystem.h
	src/adduserdlg.h
	src/contactlistaccountgroup.h
	src/theme.h
	src/activity.h
	src/chatview_te.h
	src/psiiconset.h
	src/pepmanager.h
	src/registrationdlg.h
	src/translationmanager.h
	src/psipopupinterface.h
	src/psihttpauthrequest.h
	src/chatview.h
	src/eventdb.h
	src/activecontactsmenu.h
	src/mucconfigdlg.h
	src/psifilteredcontactlistview.h
	src/legacypsiaccount.h
	src/chatview_webkit.h
	src/groupchatdlg.h
	src/contactlistmodel.h
	src/psiapplication.h
	src/contactupdatesmanager.h
	src/globalstatusmenu.h
	src/bytearrayreply.h
	src/httpauthmanager.h
	src/varlist.h
	src/vcardphotodlg.h
	src/shortcutmanager.h
	src/psithememanager.h
	src/jsutil.h
	src/main.h
	src/qwextend.h
	src/psiselfcontact.h
	src/serverinfomanager.h
	src/minicmd.h
	src/mucreasonseditor.h
	src/changepwdlg.h
	src/psicli.h
	src/contactlistgroupcache.h
	src/contactlistmodelselection.h
	src/globaleventqueue.h
	src/chatviewtheme.h
	src/bookmarkmanager.h
	src/psicon.h
	src/serverlistquerier.h
	src/lastactivitytask.h
	src/urlbookmark.h
	src/eventdlg.h
	src/jidutil.h
	src/desktoputil.h
	src/rtparse.h
	src/psiactionlist.h
	src/psitoolbar.h
	src/mucaffiliationsproxymodel.h
	src/physicallocation.h
	src/mucjoindlg.h
	src/systeminfo.h
	src/statuspreset.h
	src/chatviewthemeprovider.h
	src/chateditproxy.h
	src/dbus.h
	src/conferencebookmark.h
	src/tasklist.h
	src/moodcatalog.h
	src/statusmenu.h
	src/contactlistitemproxy.h
	src/homedirmigration.h
	src/chatsplitter.h
	src/psicontactlistview.h
	src/sendbuttonmenu.h
	src/rosteritemexchangetask.h
	src/vcardfactory.h
	src/alertmanager.h
	src/passdialog.h
	src/xmlconsole.h
	src/mcmdsimplesite.h
	src/voicecaller.h
	src/psidbusnotifier.h
	src/psirosterwidget.h
	src/pgputil.h
	src/psicontact.h
	src/googleftmanager.h
	src/geolocation.h
	src/removeconfirmationmessagebox.h
	src/adhoc_fileserver.h
	src/applicationinfo.h
	src/entitytimetask.h
	src/rosteravatarframe.h
	src/mcmdcompletion.h
	src/contactlistgroupmenu.h
	src/chatdlg.h
	src/accountscombobox.h
	src/contactlistspecialgroup.h
	src/fileutil.h
	src/psicontactlist.h
	src/statuscombobox.h
	src/filecache.h
	src/tipdlg.h
	src/webview.h
	src/mainwin_p.h
	src/alertable.h
	src/bosskey.h
	src/voicecalldlg.h
	src/jinglevoicecaller.h
	src/groupchattopicdlg.h
	src/msgmle.h
	src/psioptions.h
	src/contactlistdragmodel.h
	src/avatars.h
	src/actionlist.h
	src/passphrasedlg.h
	src/mucaffiliationsview.h
	src/coloropt.h
	src/historydlg.h
	src/accountmodifydlg.h
	src/searchdlg.h
	src/psiwkavatarhandler.h
)
