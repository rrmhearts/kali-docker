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