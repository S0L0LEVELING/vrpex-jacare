start C:\xampp\xampp-control.exe
start C:\HeidiSQL\HeidiSQL.exe
@echo off
color 0b
echo -
echo  Otimizando O Servidor E Deletando cache ...
echo -
rd /s /q "cache"
timeout 2
test&cls
color 0b  
echo \-------------------------------------------------------------------------/
echo \----                                                                 ----/
echo \---          BASE NOVA ERA BY Brito#5471                              ---/
echo \--                                                                     --/
echo \-------------------------------------------------------------------------/ 
echo Starting Resources...
pause
timeout 1
:loop
color 0b 
@echo (%time%) Starting The City ...
color 0b
@echo Pressione Enter nesta janela para reiniciar o servidor imediatamente, mantenha esta janela aberta para reinicializacoes automaticas do servidor de 5 em 5 horas.
start "Cidade Nova Era" start artifacts\FXServer.exe artifacts\FXServer.exe +set onesync on +set onesync_enableInfinity 1 +exec server.cfg
timeout /t 38000
taskkill /f /im FXServer.exe
@echo Encerramento do servidor com sucesso.
timeout /t 2 >nul
taskkill /F /FI "WindowTitle eq Server"
@echo Servidor esta reiniciando agora.
timeout /t 10
cls
goto loop

#@echo off
#+set onesync legacy +set onesync on +set onesync_enableInfinity 1 +set onesync_enableBeyond 1 +set onesync_population false +set onesync_forceMigration 1 +set onesync_distanceCullVehicles 1 +set sv_enforceGameBuild 2189 +exec config\server.cfg 
#Colocar linha de cima em produção
