cmake_minimum_required( VERSION 2.8.11 )

set( libpsi_tools_SRCS
	src/libpsi/tools/priorityvalidator.cpp
	src/libpsi/tools/iodeviceopener.cpp
)
set( libpsi_dialogs_SRCS
	src/libpsi/dialogs/grepshortcutkeydialog.cpp
)
set( libpsi_widgets_SRCS
	src/libpsi/widgets/groupchatbrowsewindow.cpp
)
set( libpsi_tools_zip_SRCS
	src/libpsi/tools/zip/zip.cpp
)
set( libpsi_tools_atomicxmlfile_SRCS
	src/libpsi/tools/atomicxmlfile/atomicxmlfile.cpp
)
set( libpsi_tools_simplecli_SRCS
	src/libpsi/tools/simplecli/simplecli.cpp
)
set( libpsi_tools_growlnotifier_SRCS
	src/libpsi/tools/growlnotifier/growltest.cpp
	src/libpsi/tools/growlnotifier/growlnotifier.cpp
)
set( libpsi_tools_spellchecker_SRCS
	src/libpsi/tools/spellchecker/spellchecker.cpp
	src/libpsi/tools/spellchecker/spellhighlighter.cpp
)
set( libpsi_aspell_SRCS
	src/libpsi/tools/spellchecker/aspellchecker.cpp
)
set( libpsi_enchant_SRCS
	src/libpsi/tools/spellchecker/enchantchecker.cpp
)
set( libpsi_tools_unittest_SRCS
	src/libpsi/tools/unittest/iodeviceopenertest.cpp
)
set( libpsi_tools_mac_dock_SRCS
	src/libpsi/tools/mac_dock/docktest.cpp
)
set( libpsi_tools_globalshortcut_SRCS
	src/libpsi/tools/globalshortcut/globalshortcutmanager.cpp
)
set( libpsi_tools_systemwatch_SRCS
	src/libpsi/tools/systemwatch/systemwatch.cpp
)
set( libpsi_tools_idle_SRCS
	src/libpsi/tools/idle/idle.cpp
)

if( WIN32 )
	set( libpsi_tools_globalshortcut_SRCS
		${libpsi_tools_globalshortcut_SRCS}
		src/libpsi/tools/globalshortcut/globalshortcutmanager_win.cpp
	)
	set( libpsi_tools_systemwatch_SRCS
		${set( libpsi_tools_systemwatch_SRCS}
		src/libpsi/tools/systemwatch/systemwatch_win.cpp
	)
	set( libpsi_tools_idle_SRCS
		${libpsi_tools_idle_SRCS}
		src/libpsi/tools/idle/win32/idleui.cpp
		src/libpsi/tools/idle/idle_win.cpp
	)
elseif( UNIX NOT APPLE )
	set( libpsi_tools_globalshortcut_SRCS
		${libpsi_tools_globalshortcut_SRCS}
		src/libpsi/tools/globalshortcut/globalshortcutmanager_x11.cpp
	)
	set( libpsi_tools_systemwatch_SRCS
		${set( libpsi_tools_systemwatch_SRCS}
		src/libpsi/tools/systemwatch/systemwatch_unix.cpp
	)
	set( libpsi_tools_idle_SRCS
		${libpsi_tools_idle_SRCS}
		src/libpsi/tools/idle/idle_x11.cpp
	)
elseif( APPLE )
	set( libpsi_tools_systemwatch_SRCS
		${set( libpsi_tools_systemwatch_SRCS}
		src/libpsi/tools/systemwatch/systemwatch_mac.cpp
	)
	set( libpsi_tools_idle_SRCS
		${libpsi_tools_idle_SRCS}
		src/libpsi/tools/idle/idle_mac.cpp
	)
endif( WIN32 )

set( irisprotocol_SRCS
	src/irisprotocol/iris_discoinfoquerier.cpp
)
set( sxe_SRCS
	src/sxe/sxeedit.cpp
	src/sxe/sxemanager.cpp
	src/sxe/sxenewedit.cpp
	src/sxe/sxerecord.cpp
	src/sxe/sxerecordedit.cpp
	src/sxe/sxeremoveedit.cpp
	src/sxe/sxesession.cpp
)
set( capabilities_SRCS
	src/capabilities/capsmanager.cpp
	src/capabilities/capsregistry.cpp
	src/capabilities/capsspec.cpp
)
set( capabilities_unittest_SRCS
	src/capabilities/unittest/capsmanagertest.cpp
	src/capabilities/unittest/capsspectest.cpp
)
set( tools_optionstree_SRCS
	src/tools/optionstree/optionstree.cpp
	src/tools/optionstree/optionstreemodel.cpp
	src/tools/optionstree/optionstreereader.cpp
	src/tools/optionstree/optionstreewriter.cpp
	src/tools/optionstree/varianttree.cpp
)
set( tools_optionstree_optionstreeviewtest_SRCS
	src/tools/optionstree/optionstreeviewtest/optionstreeviewtest.cpp
)
set( tools_optionstree_optionstest_SRCS
	src/tools/optionstree/optionstest/optionstest.cpp
)
set( tools_unittest_SRCS
	src/tools/optionstree/unittest/OptionsTreeMainTest.cpp
	src/tools/iconset/unittest/testiconset.cpp
)
set( tools_iconset_SRCS
	src/tools/iconset/anim.cpp
	src/tools/iconset/iconset.cpp
)
set( tools_crash_SRCS
	src/tools/crash/crash.cpp
	src/tools/crash/crash_dummy.cpp
	src/tools/crash/crash_kde.cpp
	src/tools/crash/crash_sigsegv.cpp
)
#deprecated
#src/tools/tunecontroller/combinedtunecontroller.cpp
set( tools_tunecontroller_SRCS
	src/tools/tunecontroller/filetunecontroller.cpp
	src/tools/tunecontroller/plugins/psifile/psifileplugin.cpp
	src/tools/tunecontroller/pollingtunecontroller.cpp
	src/tools/tunecontroller/tunecontrollermanager.cpp
)
set( tools_winamptunecontroller_SRCS
	src/tools/tunecontroller/plugins/winamp/winampcontroller.cpp
	src/tools/tunecontroller/plugins/winamp/winampplugin.cpp
	src/tools/tunecontroller/winamptunecontroller.cpp
)
set( tools_aimptunecontroller_SRCS
	src/tools/tunecontroller/aimptunecontroller.cpp
	src/tools/tunecontroller/plugins/aimp/aimpplugin.cpp
)
set( tools_mpristunecontroller_SRCS
	src/tools/tunecontroller/mpristunecontroller.cpp
	src/tools/tunecontroller/plugins/mpris/mprisplugin.cpp
)
set( tools_itunestunecontroller_SRCS
	src/tools/tunecontroller/itunestunecontroller.cpp
	src/tools/tunecontroller/plugins/itunes/itunesplugin.cpp
	src/tools/tunecontroller/plugins/itunes/itunescontroller.cpp
)
set( tools_advwidget_SRCS
	src/tools/advwidget/movetest/main.cpp
	src/tools/advwidget/advwidget.cpp
)
set( options_SRCS
	src/options/opt_advanced.cpp
	src/options/opt_appearance.cpp
	src/options/opt_application.cpp
	src/options/opt_avcall.cpp
	src/options/opt_chat.cpp
	src/options/opt_events.cpp
	src/options/opt_groupchat.cpp
	src/options/opt_iconset.cpp
	src/options/opt_plugins.cpp
	src/options/opt_popups.cpp
	src/options/opt_roster.cpp
	src/options/opt_shortcuts.cpp
	src/options/opt_sound.cpp
	src/options/opt_status.cpp
	src/options/opt_statusauto.cpp
	src/options/opt_statusgeneral.cpp
	src/options/opt_statuspep.cpp
	src/options/opt_theme.cpp
	src/options/opt_toolbars.cpp
	src/options/opt_tree.cpp
	src/options/optionsdlg.cpp
	src/options/optionstab.cpp
)
set( mockQCA_SRCS
	src/MockQCA/MockQCA.cpp
)
set( autoUpdater_SRCS
	src/AutoUpdater/QDChecker.cpp
	src/AutoUpdater/AutoUpdater.cpp
)
set( autoUpdater_test_SRCS
	src/AutoUpdater/guitest/testapp/main.cpp
	src/AutoUpdater/guitest/testapp-2.0/main.cpp
)
set( contactmanager_SRCS
	src/contactmanager/contactmanagermodel.cpp
	src/contactmanager/contactmanagerdlg.cpp
	src/contactmanager/contactmanagerview.cpp
)
set( avcall_SRCS
	src/avcall/avcall.cpp
	src/avcall/calldlg.cpp
	src/avcall/jinglertp.cpp
	src/avcall/jinglertptasks.cpp
)
set( tabs_SRCS
	src/tabs/tabbablewidget.cpp
	src/tabs/tabdlg.cpp
	src/tabs/tabmanager.cpp
)
set( growlnotifier_SRCS
	src/psigrowlnotifier.cpp
)
set( certificates_SRCS
	src/Certificates/CertificateDisplayDialog.cpp
	src/Certificates/CertificateErrorDialog.cpp
	src/Certificates/CertificateHelpers.cpp
	src/Certificates/unittest/CertificateHelpersTest.cpp
)
set( certificates_test_SRCS
	src/Certificates/guitest/main.cpp
)
set( privacy_SRCS
	src/privacy/privacydlg.cpp
	src/privacy/privacylist.cpp
	src/privacy/privacylistblockedmodel.cpp
	src/privacy/privacylistitem.cpp
	src/privacy/privacylistmodel.cpp
	src/privacy/privacyruledlg.cpp
	src/privacy/psiprivacymanager.cpp
)
set( privacy_test_SRCS
	src/privacy/guitest/mockprivacymanager.cpp
	src/privacy/guitest/privacydlgtest.cpp
	src/privacy/guitest/privacyruledlgtest.cpp
	src/privacy/unittest/privacylistitemtest.cpp
)
set( whiteboarding_SRCS
	src/whiteboarding/wbdlg.cpp
	src/whiteboarding/wbitem.cpp
	src/whiteboarding/wbmanager.cpp
	src/whiteboarding/wbnewimage.cpp
	src/whiteboarding/wbnewitem.cpp
	src/whiteboarding/wbnewpath.cpp
	src/whiteboarding/wbscene.cpp
	src/whiteboarding/wbwidget.cpp
)
set( unittest_SRCS 
	src/unittest/commontest.cpp
	src/unittest/psiiconset/testpsiiconset.cpp
	src/unittest/psipopup/testpsipopup.cpp
)
set( widgets_SRCS 
	src/widgets/actionlineedit.cpp
	src/widgets/busywidget.cpp
	src/widgets/fancylabel.cpp
	src/widgets/fancypopup.cpp
	src/widgets/iconaction.cpp
	src/widgets/iconselect.cpp
	src/widgets/iconwidget.cpp
	src/widgets/psirichtext.cpp
	src/widgets/psitabbar.cpp
	src/widgets/psitabwidget.cpp
	src/widgets/psitextview.cpp
	src/widgets/psitiplabel.cpp
	src/widgets/psitooltip.cpp
	src/widgets/psiwidgets.cpp
	src/widgets/psiwindowheader.cpp
	src/widgets/tabbar.cpp
	src/widgets/typeaheadfind.cpp
	src/widgets/urllabel.cpp
	src/widgets/urlobject.cpp
)
set( widgets_unittest_SRCS
	src/widgets/unittest/iconaction/testiconaction.cpp
	src/widgets/unittest/richtext/main.cpp
)
set( psimeida_SRCS
	src/psimedia/psimedia.cpp
)
set( psi_unix_SRCS
	src/x11windowsystem.cpp
)
set( psi_dbus_SRCS
	src/dbus.cpp
	src/psidbusnotifier.cpp
	src/activeprofiles_dbus.cpp
)
set( psi_win_SRCS
	src/activeprofiles_win.cpp
)
set( psi_SRCS
	src/aboutdlg.cpp
	src/accountadddlg.cpp
	src/accountlabel.cpp
	src/accountloginpassword.cpp
	src/accountmanagedlg.cpp
	src/accountmodifydlg.cpp
	src/accountregdlg.cpp
	src/accountscombobox.cpp
	src/accountstatusmenu.cpp
	src/actionlist.cpp
	src/activecontactsmenu.cpp
	src/activeprofiles.cpp
	src/activeprofiles_stub.cpp
	src/activity.cpp
	src/activitycatalog.cpp
	src/activitydlg.cpp
	src/adduserdlg.cpp
	src/adhoc_fileserver.cpp
	src/ahcexecutetask.cpp
	src/ahcformdlg.cpp
	src/ahcommand.cpp
	src/ahcommanddlg.cpp
	src/ahcommandserver.cpp
	src/ahcservermanager.cpp
	src/alertable.cpp
	src/alerticon.cpp
	src/alertmanager.cpp
	src/applicationinfo.cpp
	src/avatars.cpp
	src/bobfilecache.cpp
	src/bookmarkmanagedlg.cpp
	src/bookmarkmanager.cpp
	src/bosskey.cpp
	src/bytearrayreply.cpp
	src/changepwdlg.cpp
	src/chatdlg.cpp
	src/chateditproxy.cpp
	src/chatsplitter.cpp
	src/chatview_te.cpp
	src/chatview_webkit.cpp
	src/chatviewcommon.cpp
	src/chatviewtheme.cpp
	src/chatviewthemeprovider.cpp
	src/coloropt.cpp
	src/common.cpp
	src/conferencebookmark.cpp
	src/contactlistaccountgroup.cpp
	src/contactlistaccountmenu.cpp
	src/contactlistdragmodel.cpp
	src/contactlistdragview.cpp
	src/contactlistgroup.cpp
	src/contactlistgroupcache.cpp
	src/contactlistgroupmenu.cpp
	src/contactlistgroupstate.cpp
	src/contactlistitem.cpp
	src/contactlistitemmenu.cpp
	src/contactlistitemproxy.cpp
	src/contactlistmodel.cpp
	src/contactlistmodelselection.cpp
	src/contactlistmodelupdater.cpp
	src/contactlistnestedgroup.cpp
	src/contactlistproxymodel.cpp
	src/contactlistspecialgroup.cpp
	src/contactlistutil.cpp
	src/contactlistview.cpp
	src/contactlistviewdelegate.cpp
	src/contactupdatesmanager.cpp
	src/contactview.cpp
	src/desktoputil.cpp
	src/discodlg.cpp
	src/dummystream.cpp
	src/entitytimetask.cpp
	src/eventdb.cpp
	src/eventdlg.cpp
	src/filecache.cpp
	src/filetransdlg.cpp
	src/fileutil.cpp
	src/gcuserview.cpp
	src/geolocation.cpp
	src/geolocationdlg.cpp
	src/globaleventqueue.cpp
	src/globalstatusmenu.cpp
	src/googleftmanager.cpp
	src/groupchatdlg.cpp
	src/groupchattopicdlg.cpp
	src/historydlg.cpp
	src/homedirmigration.cpp
	src/hoverabletreeview.cpp
	src/htmltextcontroller.cpp
	src/httpauthmanager.cpp
	src/infodlg.cpp
	src/jidutil.cpp
	src/jinglevoicecaller.cpp
	src/jsutil.cpp
	src/lastactivitytask.cpp
	src/legacypsiaccount.cpp
	src/main.cpp
	src/mainwin.cpp
	src/mainwin_p.cpp
	src/mcmdcompletion.cpp
	src/mcmdmanager.cpp
	src/mcmdsimplesite.cpp
	src/messageview.cpp
	src/miniclient.cpp
	src/mood.cpp
	src/moodcatalog.cpp
	src/mooddlg.cpp
	src/msgmle.cpp
	src/mucaffiliationsmodel.cpp
	src/mucaffiliationsproxymodel.cpp
	src/mucaffiliationsview.cpp
	src/mucconfigdlg.cpp
	src/mucjoindlg.cpp
	src/mucmanager.cpp
	src/mucreasonseditor.cpp
	src/networkaccessmanager.cpp
	src/passdialog.cpp
	src/passphrasedlg.cpp
	src/pepmanager.cpp
	src/pgpkeydlg.cpp
	src/pgptransaction.cpp
	src/pgputil.cpp
	src/physicallocation.cpp
	src/pixmaputil.cpp
	src/pluginhost.cpp
	src/pluginmanager.cpp
	src/popupmanager.cpp
	src/profiledlg.cpp
	src/proxy.cpp
	src/psi_profiles.cpp
	src/psiaccount.cpp
	src/psiactionlist.cpp
	src/psiapplication.cpp
	src/psichatdlg.cpp
	src/psicon.cpp
	src/psicontact.cpp
	src/psicontactlist.cpp
	src/psicontactlistmodel.cpp
	src/psicontactlistview.cpp
	src/psicontactlistviewdelegate.cpp
	src/psicontactmenu.cpp
	src/psievent.cpp
	src/psifilteredcontactlistview.cpp
	src/psiiconset.cpp
	src/psioptions.cpp
	src/psioptionseditor.cpp
	src/psipopup.cpp
	src/psipopupinterface.cpp
	src/psirosterwidget.cpp
	src/psiselfcontact.cpp
	src/psithememanager.cpp
	src/psithememodel.cpp
	src/psithemeprovider.cpp
	src/psithemeviewdelegate.cpp
	src/psitoolbar.cpp
	src/psitrayicon.cpp
	src/psiwkavatarhandler.cpp
	src/pubsubsubscription.cpp
	src/qwextend.cpp
	src/rc.cpp
	src/registrationdlg.cpp
	src/removeconfirmationmessagebox.cpp
	src/resourcemenu.cpp
	src/rosteravatarframe.cpp
	src/rosteritemexchangetask.cpp
	src/rtparse.cpp
	src/searchdlg.cpp
	src/sendbuttonmenu.cpp
	src/serverinfomanager.cpp
	src/serverlistquerier.cpp
	src/shortcutmanager.cpp
	src/showtextdlg.cpp
	src/statuscombobox.cpp
	src/statusdlg.cpp
	src/statusmenu.cpp
	src/statuspreset.cpp
	src/systeminfo.cpp
	src/tabcompletion.cpp
	src/textutil.cpp
	src/theme.cpp
	src/timeserver.cpp
	src/tipdlg.cpp
	src/translationmanager.cpp
	src/urlbookmark.cpp
	src/userlist.cpp
	src/varlist.cpp
	src/vcardfactory.cpp
	src/vcardphotodlg.cpp
	src/voicecalldlg.cpp
	src/webview.cpp
	src/xdata_widget.cpp
	src/xmlconsole.cpp
)
