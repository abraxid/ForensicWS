#!/bin/bash
apt-get install dialog
dialog --checklist "Choose your favorite distribution:" 60 60 8 \
1 ARGUS on \
2 Bro off \
3 ntop on \
4 pasco off \
5 shoki off \
6 SNORT on \
7 tcpdstat on \
8 trafshow on \
$(cat /tmp/output.txt) 2> /tmp/output2.txt

#echo you chose $(cat /tmp/output2.txt)
#clear

packages=`cat /tmp/output2.txt`
for package in $packages; do
    #echo $package
    case $package in
    "1")
        echo "Installing ARGUS"
        apt-get install argus-server -y
        ;;
    "2")
        echo "Installing Bro Dependencies"
        apt-get install bison cmake flex g++ gdb make libmagic-dev libpcap-dev libgeoip-dev libss$
        echo "Downloading a GeoIP Database"
        wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
        wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCityv6-beta/GeoLiteCityv6.$
        gzip -d GeoLiteCity.dat.gz
        gzip -d GeoLiteCityv6.dat.gz
        sudo mv GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat
        sudo mv GeoLiteCityv6.dat /usr/share/GeoIP/GeoIPCityv6.dat
        echo "Cloning Bro from Git"
        git clone --recursive git://git.bro.org/bro
        cd bro
        echo "Installing Bro from source"
        ./configure
        make
        make install

        export PATH=$PATH:/usr/local/bro/bin
        source /etc/profile.d/3rd-party.sh
        echo "For documentation on configuring Bro go to https://www.digitalocean.com/community/tutorials/how-to-install-bro-on-ubuntu-16-04"
        #echo "Configuring Bro"

        #dialog --title "Define Interface" --inputbox "This modifies the nodes Bro monitors. By default it is eth0 of your Ubuntu 16.04 server. If it's not, make sure to update it." 8 40 eth0 2>ans.txt
        #val=$(<ans.txt)
        #sed -i -e 's/eth0/$val/g' /usr/local/bro/etc/node.cfg



        ;;
    "3")
        echo "Installing ntop"
        apt-get install ntop -y
        ;;
    "4")
        echo "pasco now requires you to agree to term and conditions, you can downlaod it from https://www.mcafee.com/hk/downloads/free-tools/pasco.aspx"
        #echo "Installing pasco"
        #apt-get install argus-server -y
        ;;
    "5")
        echo "Installing shoki"
        echo "We were not able to find where to download it from"
        echo "http://shoki.sourceforge.net/users_guide.html "
        ;;
    "6")
        echo "Installing SNORT"
        apt-get install snort -y
        ;;
    "7")
        echo "Installing tcpdstat"
        apt-get install gcc make libpcap0.8-dev unzip
        wget https://github.com/netik/tcpdstat/archive/master.zip
        unzip master.zip
        cd tcpdstat-master
        make
        sudo make install
        ;;
    "8")
        echo "Installing trafshow"
        apt-get install netdiag
        ;;
    *)
        echo "don't know that option"
        ;;

    esac

done


#rm /tmp/output*