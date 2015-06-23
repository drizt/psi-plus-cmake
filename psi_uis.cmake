cmake_minimum_required( VERSION 2.8.11 )

set( main_UIS
	src/about.ui
	src/accountadd.ui
	src/accountmanage.ui
	src/accountmodify.ui
	src/accountreg.ui
	src/accountremove.ui
	src/activity.ui
	src/addurl.ui
	src/adduser.ui
	src/ahcformdlg.ui
	src/ahcommanddlg.ui
	src/bookmarkmanage.ui
	src/changepw.ui
	src/chatdlg.ui
	src/disco.ui
	src/filetrans.ui
	src/geolocation.ui
	src/groupchatdlg.ui
	src/groupchattopicdlg.ui
	src/history.ui
	src/homedirmigration.ui
	src/info.ui
	src/mood.ui
	src/mucconfig.ui
	src/mucjoin.ui
	src/mucreasonseditor.ui
	src/optioneditor.ui
	src/passphrase.ui
	src/pgpkey.ui
	src/profilemanage.ui
	src/profilenew.ui
	src/profileopen.ui
	src/proxy.ui
	src/rosteravatarframe.ui
	src/search.ui
	src/sendbuttontemplateseditor.ui
	src/tip.ui
	src/voicecall.ui
	src/xmlconsole.ui
)

set( libpsi_UIS
	src/libpsi/dialogs/grepshortcutkeydialog.ui
	src/libpsi/widgets/groupchatbrowsewindow.ui
)

set( options_UIS
	src/options/opt_advanced.ui
	src/options/opt_appearance.ui
	src/options/opt_appearance_misc.ui
	src/options/opt_application.ui
	src/options/opt_avcall.ui
	src/options/opt_chat.ui
	src/options/opt_events.ui
	src/options/opt_general_groupchat.ui
	src/options/opt_iconset_activity.ui
	src/options/opt_iconset_affiliation.ui
	src/options/opt_iconset_client.ui
	src/options/opt_iconset_emo.ui
	src/options/opt_iconset_mood.ui
	src/options/opt_iconset_roster.ui
	src/options/opt_iconset_system.ui
	src/options/opt_lookfeel_toolbars.ui
	src/options/opt_plugins.ui
	src/options/opt_popups.ui
	src/options/opt_roster.ui
	src/options/opt_shortcuts.ui
	src/options/opt_sound.ui
	src/options/opt_status.ui
	src/options/opt_statusauto.ui
	src/options/opt_statusgeneral.ui
	src/options/opt_statuspep.ui
	src/options/opt_theme.ui
	src/options/plugininfodialog.ui
	src/options/pluginsettsdialog.ui
	src/options/ui_isdetails.ui
	src/options/ui_options.ui
)
set( autoupdater_UIS
	src/AutoUpdater/QDChangeLog.ui
)
set( contactmanager_UIS
	src/contactmanager/contactmanagerdlg.ui
)
set( avcall_UIS
	src/avcall/call.ui
)
set( certificates_UIS
	src/Certificates/CertificateDisplay.ui
)
set( privacy_UIS
	src/privacy/privacy.ui
	src/privacy/privacyrule.ui
)
set( widgets_UIS
	src/widgets/fancypopup.ui
	src/widgets/psiwindowheader.ui
)
set( psi_UIS
	${main_UIS}
	${libpsi_UIS}
	${options_UIS}
	${autoupdater_UIS}
	${contactmanager_UIS}
	${avcall_UIS}
	${certificates_UIS}
	${privacy_UIS}
	${widgets_UIS}
)