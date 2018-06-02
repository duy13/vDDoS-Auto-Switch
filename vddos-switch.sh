#!/bin/bash
# Auto switch security mode for a website
# Example Command:
# vddos-switch allsite [no]
# vddos-switch your-domain.com [no]
# ...
# vddos-switch your-domain.com [high]


if [ ! -f /usr/bin/vddos-switch ] || [ ! -f /usr/bin/vddos-autoswitch ]; then
chmod 700 /vddos/auto-switch/cron.sh
ln -s /vddos/auto-switch/cron.sh /usr/bin/vddos-autoswitch
chmod 700 /vddos/auto-switch/vddos-switch.sh
ln -s /vddos/auto-switch/vddos-switch.sh /usr/bin/vddos-switch
fi

if [ ! -f /vddos/conf.d/website.conf ]; then
echo 'ERROR!

/vddos/conf.d/website.conf not found! 
Please Install vDDoS Proxy Protection!'|tee -a /vddos/auto-switch/log.txt
exit 0
fi


Issetting="$2" ;

if [ "$Issetting" != "" ] && [ "$1" != "" ] && [ "$2" != "" ]; then
	Website="$1"
	switch_to_mode="$2"
fi

if [ "$Issetting" = "" ]; then
	Website="$1"
	switch_to_mode=`awk -F: '/^SecuritySwitchIfMax/' /vddos/auto-switch/setting.conf | awk 'NR==1 {print $2}'`  ;
fi

function showerror()
{
echo 'ERROR!

Website is ['$Website'] ...

# Example Command:
 vddos-switch allsite [no]
 vddos-switch your-domain.com [no]
 ...
 vddos-switch your-domain.com [high]


'|tee -a /vddos/auto-add/log.txt
return 0
}

if [ "$Website" = "" ] || [ "$switch_to_mode" = "" ]; then
	showerror
	exit 0
fi
if [ "$Website" = "allsite" ]; then
	data1=`cat /vddos/conf.d/website.conf| grep .|grep '^#'`
	data2=`cat /vddos/conf.d/website.conf| grep .|grep -v '^#' | awk '{$5="'$switch_to_mode'"; print $0}'`

	echo "$data1
$data2
" >  /vddos/conf.d/website.conf
	echo '+ New-Switch: [All existing websites] has switched to ['$switch_to_mode'] security mode ===> Done!'|tee -a /vddos/auto-switch/log.txt
	exit 0
fi

Available=`awk -F: "/^$Website/" /vddos/conf.d/website.conf`
if [ "$Available" = "" ]; then
	echo '- Re-check: ['$Website'] is not available in /vddos/conf.d/website.conf ===> Skip!'|tee -a /vddos/auto-switch/log.txt
	exit 0
fi

if [ "$Available" != "" ]; then

	data=`awk -F: "/^$Website/" /vddos/conf.d/website.conf| grep .| awk '{$5="'$switch_to_mode'"; print $0}'`
	sed -i "/^$Website.*/d" /vddos/conf.d/website.conf

	echo "
$data" >>  /vddos/conf.d/website.conf
	echo '+ New-Switch: ['$Website'] has switched to ['$switch_to_mode'] security mode ===> Done!'|tee -a /vddos/auto-switch/log.txt
	exit 0
fi

