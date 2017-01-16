@echo off
cd /d G:\SteamLibrary\SteamApps\common\GarrysMod\bin
gmad.exe create -folder "D:/Github/UnoLimited" -out "D:/Github/UnoLimited.gma"
gmpublish.exe update -addon "D:/Github/UnoLimited.gma" -id 187192556
pause