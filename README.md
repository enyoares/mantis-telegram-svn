# mantis-telegram-svn
Environments : Window OS, APM

## mantis 
- cacert.pem
  - copy '\mantis\
- telegramapi.php 
  - copy '\mantis\core\'
  - edit BOT_TOKEN
  - edit WEBHOOK_URL
- custom_function_api.php
  - add to code:
```
//{{ ejlee
function custom_function_default_fixin( $p_issue_id, $p_comment, $p_file, $p_new_version, $p_fixed ) {
	if( bug_exists( $p_issue_id ) ) {
		history_log_event_special( $p_issue_id, CHECKIN, $p_file, $p_new_version );
		$t_private = false;
		if( VS_PRIVATE == config_get( 'source_control_notes_view_status' ) ) {
			$t_private = true;
		}
		bugnote_add( $p_issue_id, $p_comment, 0, $t_private );

		$t_bug_data = bug_get( $p_issue_id, true );
		$t_bug_data->status = 80;
		$t_bug_data->Update( true, true);
		form_security_purge( 'bug_update' );
	}
}
//}}
```
- config_inc.php
  - edit to code:
```
$g_source_control_regexp = "/\bissue [#]{0,1}(\d+)\b/i";
$g_source_control_fixed_regexp ="/\bfixed [#]{0,1}(\d+)\b/i";
```
- checkincurl.php
  - copy '\mantis\scripts\'
  - edit BOT_TOKEN
  - edit chatID number

##telegram
make a bot id
- https://www.youtube.com/watch?v=hJBYojK7DO4
- https://core.telegram.org/bots#botfather

##svn
- Post-commit hook
```
c:
cd \VisualSVNServer\bin
hook %1 %2
```

- hook.bat
```
@echo off
cls
set REPOS=%1
set REV=%2

set auth =
set log =
set changed =
set dt =
set n='\n'

FOR /F "tokens=*" %%i in ('svnlook author -r %REV% %REPOS%') do SET auth=%%i
FOR /F "tokens=*" %%i in ('svnlook date -r %REV% %REPOS%') do SET dt=%%i
FOR /F "tokens=*" %%i in ('svnlook changed -r %REV% %REPOS% ') do SET changed=%%i
FOR /F "tokens=*" %%i in ('svnlook log -r %REV% %REPOS%') do SET log=%%i

curl -s -d user="%auth% %log%=Changeset [%REV%] %log%%changed%" http://mysite.com/core/checkincurl.php

echo --- debug output info ---
echo *
echo %auth%
echo %dt%
echo %log%
echo %changed%
echo *
```


##cURL
- https://curl.haxx.se/download.html
