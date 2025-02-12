# Curated Multimaps for Rspamd, second edition

**Rspamd** offers so-called **multimaps** and their maps. With them you can create rules with or without regular expressions.

I started developing the rules in early 2024 and i am now working on an improved second version.

Before Rspamd, I used an older product called **Declude** as a spam filtering system for our server as well as for customers. Declude also offered a rule system based on regular expressions. This experience is very useful to me here.

:bulb: The rules are updated at least once, but usually several times a day and are therefore sure to be accurate.

📢 If you have any questions or feedback drop me line at the [discussions](https://github.com/martinschaible/rspamd-rules/discussions).

🐛 Bugs and problems can be reported here: [Issues](https://github.com/martinschaible/rspamd-rules/issues).

🍀 Feel free to use these maps on your Rspamd server.

## Installation
The base is the file *multimaps.conf* in the folder `/etc/rspamd/local.d`. This file includes all configuration files of the map files. These files are located in the same folder and must also be copied to the server.

The map files of the first generation begin with an underscore `_multimap....map` . The second generation does not have the leading underscore.

Important: Both versions must be uploaded.

Finally, the Rspamd service must be restarted

```
systemctl restart rspamd
```

The map files in the folder `/etc/rspamd/maps.d` do not need to be copied. **Rspamd** loads them directly from Github and caches them locally. New versions are checked periodically.

## Content

All map files of the *first version* are in the folder `/etc/rspamd/maps.d`. The files of the *second edition* are stored in subfolders according to the topic.

### Setup for "base"

Folder structure:

```
|- base
|    |- base.country.map                            -|
|    |- base.body.charenc.koi8r.map                  |
|    |- base.body.charenc.windows1251.map            |- multimap.base.conf
|    |- base.body.markup.hidden.map                  |
|    |- base.body.markup.map                        -|
|    |- href
|    |   |- base.body.href.domain.map               -|
|    |   |- base.body.href.domain.ip.map             |
|    |   |- base.body.href.domain.google.map         |
|    |   |- base.body.href.nossl.map                 |- multimap.base.body.href.conf
|    |   |- base.body.href.path.map                  |
|    |   |- base.body.href.path.filename.map         |
|    |   |- base.body.href.path.wordpress.map       -|
|    |- img
|        |- base.body.img.domain.ip.map             -|
|        |- base.body.img.domain.tld.map             |
|        |- base.body.img.domain.name.map            |- multimap.base.body.img.conf
|        |- base.body.img.nossl.map                  |
|        |- base.body.img.path.map                   |
|        |- base.body.img.shortener.map             -|
|- lists
     |- list.tld.map                                -|- multimap.base.body.href.conf
     |- url.shortener.map                           -|
```

### Setup for "body"

Folder structure:
```
|- body
     |- body.attachment.map                         -|
     |- body.emergency.map                           |
     |- body.az.orgname.map                          |
     |- body.ch.orgname.map                          |
     |- body.de.orgname.map                          |
     |- body.us.orgname.map                          |
     |- de                                           |- multimap.body.conf
     |   |- body.de.greetings.map                    |
     |   |- body.de.singleword.map                   |
     |   |- body.de.singleword.ucase.map             |
     |   |- body.de.unsubscribe.map                  |
     |- en                                           |
     |   |- ....                                    -|
     |- href
     |    |- body.href.az.domain.name.map           -|
     |    |- body.href.ch.domain.name.map            |
     |    |- body.href.de.domain.name.map            |- multimap.body.href.conf
     |    |- body.href.us.domain.name.map            |
     |    |- body.href.domain.name.pattern.map       |
     |    |- body.href.url.path.orgbrandprod        -|
```

More content will follow soon.

### Setup for "sender"

Folder structure:
```
|- sender
     |- de
     |   |- sender.from.de.map
     |   |- sender.from.de.adult.map
     |   |- sender.from.de.finance.map
     |   |- sender.from.de.gambling.map
     |   |- sender.from.de.health.map
     |   |- sender.from.de.lottery.map
     |   |- sender.from.de.makemoney.map
     |   |- sender.from.de.malwaremap
     |   |- sender.from.de.phishing.map
     |   |- sender.from.de.sale.map
     |   |- sender.from.de.singleword.map
     |   |- sender.from.de.singleword.ucase.map
     |- en
     |   |- ....
     |- sender.address.map
     |- sender.from.orgbrandprod.map
     |- sender.from.people.map
     |- sender.from.phishing.orgbrandprod.map
     |- sender.from.special.map
```

More content will follow soon.

### Setup for "subject"

Folder structure:
```
|- subject
     |- de
     |   |- subject.de.map
     |   |- subject.de.adult.map
     |   |- subject.de.finance.map
     |   |- subject.de.greetings.map
     |   |- subject.de.health.map
     |   |- subject.de.phishing.map
     |   |- subject.de.phishing.account.map
     |   |- subject.de.phishing.alertaction.map
     |   |- subject.de.phishing.banking.map
     |   |- subject.de.phishing.email.map
     |   |- subject.de.phishing.malware.map
     |   |- subject.de.phishing.parcel.map
     |   |- subject.de.phishing.payment.map
     |   |- subject.de.phishing.rewards.map
     |   |- subject.de.sale.map
     |   |- subject.de.sale.app.map
     |   |- subject.de.sale.seo.map
     |   |- subject.de.sale.website.map
     |   |- subject.de.scam.map
     |   |- subject.de.scam.bignumbers.map
     |   |- subject.de.scam.donation.map
     |   |- subject.de.scam.winning.map
     |   |- subject.de.singleword.map
     |   |- subject.de.singleword.ucase.map
     |- en
     |   |- ....
     |- subject.health.medname.map
     |- subject.orgbrandprod.map
     |- subject.special.map
```

More content will follow soon.

### Setup for "whitelist"

Folder structure:
```
|- whitelist
     |- de
     |   |- body.de.whitelist.map
     |   |- subject.de.whitelist.map
     |- en
     |   |- ....
```

More content will follow soon.
