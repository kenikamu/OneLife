echo "" 
echo "Shutting down server"
echo ""

serverPID=`pgrep OneLifeServer`

if [ -z $serverPID ]
then
	echo "Server not running!"
else

	echo -n "0" > ~/keepServerRunning.txt

	echo -n "1" > ~/checkout/OneLife/server/settings/shutdownMode.ini

	echo "" 
	echo "Set server shutdownMode, waiting for server to exit"
	echo ""

        while kill -CONT $serverPID 1>/dev/null 2>&1; do sleep 1; done

	echo "" 
	echo "Server has shutdown"
	echo ""
fi


echo "" 
echo "Updating live server data"
echo ""


cd ~/checkout/OneLifeData7
git checkout master
git pull
rm */cache.fcz


echo "" 
echo "Re-compiling server"
echo ""

cd ~/checkout/minorGems
git pull


cd ~/checkout/OneLife/server
git pull

./configure 1
make



echo "" 
echo "Re-launching server"
echo ""


echo -n "0" > ~/checkout/OneLife/server/settings/shutdownMode.ini



cd ~/checkout/OneLife/server/

sh ./runHeadlessServerLinux.sh

echo -n "1" > ~/keepServerRunning.txt

