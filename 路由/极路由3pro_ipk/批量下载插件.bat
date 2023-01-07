@echo off
setlocal enabledelayedexpansion
for /f %%i in (.\Packages_url.txt) do (

for /f "tokens=7 delims=/" %%a in ("%%i") do (
set i=%%a
echo ÕıÔÚÏÂÔØ¡¾!i!¡¿
)

curl %%i -o !i!
	
)
pause