<%!
    import datetime
    import re
    from medusa import app, logger
    from medusa.helper.common import pretty_file_size
    from medusa.show.show import Show
    from time import time
%>
<!-- BEGIN HEADER -->
<nav class="navbar navbar-default navbar-fixed-top hidden-print" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main_nav">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <app-link class="navbar-brand" href="home/" title="Medusa"><img alt="Medusa" src="images/medusa.png" style="height: 50px;" class="img-responsive pull-left" /></app-link>
        </div>
    % if loggedIn:
        <div class="collapse navbar-collapse" id="main_nav">
            <ul class="nav navbar-nav navbar-right">
                <li id="NAVhome" class="navbar-split dropdown${' active' if topmenu == 'home' else ''}">
                    <app-link href="home/" class="dropdown-toggle" aria-haspopup="true" data-toggle="dropdown" data-hover="dropdown"><span>Shows</span>
                    <b class="caret"></b>
                    </app-link>
                    <ul class="dropdown-menu">
                        <li><app-link href="home/"><i class="menu-icon-home"></i>&nbsp;Show List</app-link></li>
                        <li><app-link href="addShows/"><i class="menu-icon-addshow"></i>&nbsp;Add Shows</app-link></li>
                        <li><app-link href="addRecommended/"><i class="menu-icon-addshow"></i>&nbsp;Add Recommended Shows</app-link></li>
                        <li><app-link href="home/postprocess/"><i class="menu-icon-postprocess"></i>&nbsp;Manual Post-Processing</app-link></li>
                        % if app.SHOWS_RECENT:
                            <li role="separator" class="divider"></li>
                            % for recentShow in app.SHOWS_RECENT:
                                <li><app-link indexer-id="${recentShow['indexer']}" href="home/displayShow?indexername=indexer-to-name&seriesid=${recentShow['indexerid']}"><i class="menu-icon-addshow"></i>&nbsp;${recentShow['name']|trim,h}</app-link></li>
                            % endfor
                        % endif
                    </ul>
                    <div style="clear:both;"></div>
                </li>
                <li id="NAVschedule"${' class="active"' if topmenu == 'schedule' else ''}>
                    <app-link href="schedule/">Schedule</app-link>
                </li>
                <li id="NAVhistory"${' class="active"' if topmenu == 'history' else ''}>
                    <app-link href="history/">History</app-link>
                </li>
                <li id="NAVmanage" class="navbar-split dropdown${' active' if topmenu == 'manage' else ''}">
                    <app-link href="manage/episodeStatuses/" class="dropdown-toggle" aria-haspopup="true" data-toggle="dropdown" data-hover="dropdown"><span>Manage</span>
                    <b class="caret"></b>
                    </app-link>
                    <ul class="dropdown-menu">
                        <li><app-link href="manage/"><i class="menu-icon-manage"></i>&nbsp;Mass Update</app-link></li>
                        <li><app-link href="manage/backlogOverview/"><i class="menu-icon-backlog-view"></i>&nbsp;Backlog Overview</app-link></li>
                        <li><app-link href="manage/manageSearches/"><i class="menu-icon-manage-searches"></i>&nbsp;Manage Searches</app-link></li>
                        <li><app-link href="manage/episodeStatuses/"><i class="menu-icon-manage2"></i>&nbsp;Episode Status Management</app-link></li>
                    % if app.USE_PLEX_SERVER and app.PLEX_SERVER_HOST != []:
                        <li><app-link href="home/updatePLEX/"><i class="menu-icon-plex"></i>&nbsp;Update PLEX</app-link></li>
                    % endif
                    % if app.USE_KODI and app.KODI_HOST != []:
                        <li><app-link href="home/updateKODI/"><i class="menu-icon-kodi"></i>&nbsp;Update KODI</app-link></li>
                    % endif
                    % if app.USE_EMBY and app.EMBY_HOST != "" and app.EMBY_APIKEY != "":
                        <li><app-link href="home/updateEMBY/"><i class="menu-icon-emby"></i>&nbsp;Update Emby</app-link></li>
                    % endif
                    ## Avoid mixed content blocking by open manage torrent in new tab
                    % if app.USE_TORRENTS and app.TORRENT_METHOD != 'blackhole':
                        <li><app-link href="manage/manageTorrents/" target="_blank"><i class="menu-icon-bittorrent"></i>&nbsp;Manage Torrents</app-link></li>
                    % endif
                    % if app.USE_FAILED_DOWNLOADS:
                        <li><app-link href="manage/failedDownloads/"><i class="menu-icon-failed-download"></i>&nbsp;Failed Downloads</app-link></li>
                    % endif
                    % if app.USE_SUBTITLES:
                        <li><app-link href="manage/subtitleMissed/"><i class="menu-icon-backlog"></i>&nbsp;Missed Subtitle Management</app-link></li>
                    % endif
                    % if app.POSTPONE_IF_NO_SUBS:
                        <li><app-link href="manage/subtitleMissedPP/"><i class="menu-icon-backlog"></i>&nbsp;Missed Subtitle in Post-Process folder</app-link></li>
                    % endif
                    </ul>
                    <div style="clear:both;"></div>
                </li>
                <li id="NAVconfig" class="navbar-split dropdown${' active' if topmenu == 'config' else ''}">
                    <app-link href="config/" class="dropdown-toggle" aria-haspopup="true" data-toggle="dropdown" data-hover="dropdown"><span class="visible-xs-inline">Config</span><img src="images/menu/system18.png" class="navbaricon hidden-xs" />
                    <b class="caret"></b>
                    </app-link>
                    <ul class="dropdown-menu">
                        <li><app-link href="config/"><i class="menu-icon-help"></i>&nbsp;Help &amp; Info</app-link></li>
                        <li><app-link href="config/general/"><i class="menu-icon-config"></i>&nbsp;General</app-link></li>
                        <li><app-link href="config/backuprestore/"><i class="menu-icon-backup"></i>&nbsp;Backup &amp; Restore</app-link></li>
                        <li><app-link href="config/search/"><i class="menu-icon-manage-searches"></i>&nbsp;Search Settings</app-link></li>
                        <li><app-link href="config/providers/"><i class="menu-icon-provider"></i>&nbsp;Search Providers</app-link></li>
                        <li><app-link href="config/subtitles/"><i class="menu-icon-backlog"></i>&nbsp;Subtitles Settings</app-link></li>
                        <li><app-link href="config/postProcessing/"><i class="menu-icon-postprocess"></i>&nbsp;Post Processing</app-link></li>
                        <li><app-link href="config/notifications/"><i class="menu-icon-notification"></i>&nbsp;Notifications</app-link></li>
                        <li><app-link href="config/anime/"><i class="menu-icon-anime"></i>&nbsp;Anime</app-link></li>
                    </ul>
                    <div style="clear:both;"></div>
                </li>
                <li id="NAVsystem" class="navbar-split dropdown${' active' if topmenu == 'system' else ''}">
                    <app-link href="home/status/" class="padding-right-15 dropdown-toggle" aria-haspopup="true" data-toggle="dropdown" data-hover="dropdown"><span class="visible-xs-inline">Tools</span><img src="images/menu/system18-2.png" class="navbaricon hidden-xs" />${toolsBadge}
                    <b class="caret"></b>
                    </app-link>
                    <ul class="dropdown-menu">
                        <li><app-link href="news/"><i class="menu-icon-news"></i>&nbsp;News${newsBadge}</app-link></li>
                        <li><app-link href="IRC/"><i class="menu-icon-irc"></i>&nbsp;IRC</app-link></li>
                        <li><app-link href="changes/"><i class="menu-icon-changelog"></i>&nbsp;Changelog</app-link></li>
                        <li><app-link href="${app.DONATIONS_URL}"><i class="menu-icon-support"></i>&nbsp;Support Medusa</app-link></li>
                        <li role="separator" class="divider"></li>
                        %if numErrors:
                            <li><app-link href="errorlogs/"><i class="menu-icon-error"></i>&nbsp;View Errors <span class="badge btn-danger">${numErrors}</span></app-link></li>
                        %endif
                        %if numWarnings:
                            <li><app-link href="errorlogs/?level=${logger.WARNING}"><i class="menu-icon-viewlog-errors"></i>&nbsp;View Warnings <span class="badge btn-warning">${numWarnings}</span></app-link></li>
                        %endif
                        <li><app-link href="errorlogs/viewlog/"><i class="menu-icon-viewlog"></i>&nbsp;View Log</app-link></li>
                        <li role="separator" class="divider"></li>
                        <li><app-link href="home/updateCheck?pid=${sbPID}"><i class="menu-icon-update"></i>&nbsp;Check For Updates</app-link></li>
                        <li><app-link href="home/restart/?pid=${sbPID}" class="confirm restart"><i class="menu-icon-restart"></i>&nbsp;Restart</app-link></li>
                        <li><app-link href="home/shutdown/?pid=${sbPID}" class="confirm shutdown"><i class="menu-icon-shutdown"></i>&nbsp;Shutdown</app-link></li>
                        % if loggedIn is not True:
                            <li><app-link href="logout" class="confirm logout"><i class="menu-icon-shutdown"></i>&nbsp;Logout</app-link></li>
                        % endif
                        <li role="separator" class="divider"></li>
                        <li><app-link href="home/status/"><i class="menu-icon-info"></i>&nbsp;Server Status</app-link></li>
                    </ul>
                    <div style="clear:both;"></div>
                </li>
            </ul>
    % endif
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<!-- END HEADER -->