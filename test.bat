@rem test batch file

@rem set DETAILS_FILE=svnfile_85869
@rem set LOG_FILE=svnfile_85869_Log
@rem echo p_JonghoonPark >> DETAILS_FILE%
@rem echo issue #000001  [프로그램][파티레이드UI][124]  >>  %DETAILS_FILE%
@rem echo - blah blah blah blah blah blah.  >> %DETAILS_FILE%
@rem echo - blah blah blah.  >> %DETAILS_FILE%
@rem echo SVN Revision:85869    >> %DETAILS_FILE%
@rem C:\APM_Setup\Server\PHP5\php.exe C:\APM_Setup\htdocs\scripts\checkin.php <%DETAILS_FILE% >%LOG_FILE%
curl -d "user=administrator&log=fixed #2 register issue and notify telegram." http://localhost/scripts/checkincurl.php
@rem curl -d "user=administrator&log=issue #2 한글 테스트" http://localhost/scripts/checkincurl.php
