<div alt="vDDoS-Auto-Switch Logo" class="separator" style="clear: both; text-align: center;">
<a href="https://lh4.googleusercontent.com/-4Q9alJIq6t4/WxJvtkED6lI/AAAAAAAAB7M/mX3JTKXyNyQcKUBNsrEQNaX98UkUQQkNACEwYBhgL/s1600/vDDoS-Auto-Switch-vDDoS-Proxy-Protection-Icon-Logo-voduy.com.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img align="right" border="0" src="https://lh4.googleusercontent.com/-4Q9alJIq6t4/WxJvtkED6lI/AAAAAAAAB7M/mX3JTKXyNyQcKUBNsrEQNaX98UkUQQkNACEwYBhgL/s333/vDDoS-Auto-Switch-vDDoS-Proxy-Protection-Icon-Logo-voduy.com.png" /></a></div>

vDDoS Auto Switch
===================


vDDoS Auto Switch is a addon support for vDDoS Proxy Protection - Automatically identifies **overloaded websites** and changes their **Security Mode**.

----------

1/ Install vDDoS Proxy Protection:
-------------
To install vDDoS Proxy Protection please visit this site: http://vddos.voduy.com

----------


2/ Install vDDoS Auto Switch:
-------------
```
curl -L https://github.com/duy13/vDDoS-Auto-Switch/archive/master.zip -o vddos-auto-switch.zip ; unzip vddos-auto-switch.zip ; rm -f vddos-auto-switch.zip
mv vDDoS-Auto-Switch-master /vddos/auto-switch
chmod 700 /vddos/auto-switch/cron.sh; chmod 700 /vddos/auto-switch/vddos-switch.sh
ln -s /vddos/auto-switch/cron.sh /usr/bin/vddos-autoswitch
ln -s /vddos/auto-switch/vddos-switch.sh /usr/bin/vddos-switch

```

----------

3/ Using vDDoS Auto Switch:
-------------

*/usr/bin/vddos-autoswitch* automatically *identifies* **overloaded websites**  (if the website can not respond **200 HTTP Status** after 2 seconds - it mean they are too slow or high load...) And after that *vddos-autoswitch* will *changes* their **Security Mode** in */vddos/conf.d/website.conf*:

**WARNING: Please remove [...] in all the below commands!**

Auto check/switch for a domain:
-------------

Auto check/switch security mode for a domain (already in the *website.conf* file) to 5s mode (if it is being slow/high load):
```
/usr/bin/vddos-autoswitch [checkdomain] your-domain.com 5s

```

Auto check/switch for a list domains:
-------------

Auto check/switch security mode for each all domains (already in the *website.conf* file) to 5s mode (if it is being slow/high load):
```
/usr/bin/vddos-autoswitch [checkalldomain] 5s

```

Auto check/switch security mode for each domain in the list domains to 5s mode (if it is being slow/high load):
```
/usr/bin/vddos-autoswitch [checklist] /etc/listdomains.txt 5s

```

Flush all security mode for all domain (already in the *website.conf* file) if they are not slow/high load:
```
/usr/bin/vddos-autoswitch [flushalldomain] /etc/listdomains.txt no

```

4/ Crontab vDDoS Auto Switch:
-------------

If you want to automate the inspection and changes website's **Security Mode**. You can configure vDDoS Auto Switch to crontab as follows:

For example, check the status of every website every 3 minutes and automatically flush all security mode for them (if their **security mode** have been switch) every 30 minutes:
```
echo '*/3  *  *  *  * root /usr/bin/vddos-autoswitch checkalldomain high' >> /etc/crontab
echo '*/30  *  *  *  * root /usr/bin/vddos-autoswitch flushalldomain /vddos/conf.d/website.conf no' >> /etc/crontab

```
Or you have a list of special domains that need to check the status of every website every 3 minutes and automatically flush all security mode for them every 30 minutes: 
```
echo '*/3  *  *  *  * root /usr/bin/vddos-autoswitch checklist /etc/listspecialdomains.txt captcha' >> /etc/crontab
echo '*/30  *  *  *  * root /usr/bin/vddos-autoswitch flushalldomain /etc/listspecialdomains.txt no' >> /etc/crontab

```


5/ More Config:
---------------
Document: http://vddos.voduy.com
```
Still in beta, use at your own risk! It is provided without any warranty!
```