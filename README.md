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

The map files of the first generation begin with an underscore `_multimap....map`.
The second generation does not have the leading underscore.

Important: To be as effective as possible, both versions must be active until the migration is complete.

Finally, the Rspamd service must be restarted

```
systemctl restart rspamd
```

The map files in the folder `/etc/rspamd/maps.d` do not need to be copied. **Rspamd** loads them directly from Github and caches them locally. New versions are checked periodically.

## Updates configuration files
If I add new map files, the configuration files must be updated accordingly.
These must then be manually copied to the Rspamd server and the Rspamd service must be restarted.

| Date     | File                         | Reason                             |
| -------- | -----------------------------| ---------------------------------- |
| 09.05.25 | multimap.subject.conf        | New file for Emojis                |
| 10.05.25 | All configuration files!     | Splitted in DE and EN versions     |
| 13.05.25 | multimap.conf                | New files added, old files removed |
|          | multimap.body.de.scam.conf   | New file                           |
|          | multimap.body.en.scam.conf   | New file                           |
|          | multimap.body.de.stocks.conf | New file                           |
|          | multimap.body.en.stocks.conf | New file                           |
|          | _multimap_stocks.conf        | Old file deleted                   |
|          | _multimap_winning.conf       | Old file deleted                   |

## Content
All map files of the *first version* are in the folder `/etc/rspamd/maps.d`. The files of the *second edition* are stored in subfolders according to the topic.

### Setup for "base"

Folder structure:

```
base
  ├─ base.country.map                            ─┐
  ├─ base.body.charenc.koi8r.map              *   │
  ├─ base.body.charenc.windows1251.map        *   ├─ multimap.base.conf
  ├─ base.body.markup.hidden.map                  │
  ├─ base.body.markup.map                        ─┘
  ├─ href
  │   ├─ base.body.href.domain.map            *  ─┐
  │   ├─ base.body.href.domain.ip.map         *   │
  │   ├─ base.body.href.domain.google.map     *   │
  │   ├─ base.body.href.nossl.map             *   ├─ multimap.base.body.href.conf
  │   ├─ base.body.href.path.map              *   │
  │   ├─ base.body.href.path.filename.map     *   │
  │   └─ base.body.href.path.wordpress.map    *  ─┘
  └─ img
      ├─ base.body.img.domain.ip.map          *  ─┐
      ├─ base.body.img.domain.tld.map         *   │
      ├─ base.body.img.domain.name.map        *   ├─ multimap.base.body.img.conf
      ├─ base.body.img.nossl.map              *   │
      ├─ base.body.img.path.map               *   │
      └─ base.body.img.shortener.map          *  ─┘
lists
  ├─ list.tld.map                             *    - multimap.base.body.href.conf
  └─ list.url.shortener.map                   *    - multimap.base.body.href.conf
```

* -> "one_shot" is set

### Setup for "body"

Folder structure:
```
body
  ├─ body.attachment.map                         ─┐
  ├─ body.emergency.map                           │
  ├─ body.special.map                             │
  ├─ body.az.orgname.map                          │
  ├─ body.ch.orgname.map                          ├─ multimap.body.conf
  ├─ body.de.orgname.map                          │
  ├─ body.us.orgname.map                         ─┘
  ├─ de
  │   ├─ body.de.map                             ─┐
  │   ├─ body.de.greetings.map                    │
  │   ├─ body.de.intros.map                       │
  │   ├─ body.de.message.map                      ├─ multimap.body.de.conf
  │   ├─ body.de.singleword.map                   │
  │   ├─ body.de.singleword.ucase.map             │
  │   ├─ body.de.unsubscribe.map                 ─┘
  │   │
  │   ├─ body.de.phishing.map                    ─┐
  │   ├─ body.de.phishing.account.map             │
  │   ├─ body.de.phishing.alertaction.map         │
  │   ├─ body.de.phishing.banking.map             │
  │   ├─ body.de.phishing.email.map               │
  │   ├─ body.de.phishing.greetings.map           │
  │   ├─ body.de.phishing.malware.map             ├─ multimap.body.de.phishing.conf
  │   ├─ body.de.phishing.parcel.map              │  (Not yet implemented)
  │   ├─ body.de.phishing.password.map            │
  │   ├─ body.de.phishing.payment.map             │
  │   ├─ body.de.phishing.rewards.map             │
  │   ├─ body.de.phishing.subscription.map        │
  │   ├─ body.de.phishing.survey.map             ─┘
  │   │
  │   ├─ body.de.scam.map                        ─┐
  │   ├─ body.de.scam.bignumbers.map              │
  │   ├─ body.de.scam.donations.map               ├─ multimap.body.de.scam.conf
  │   ├─ body.de.scam.order.map                   │
  │   └─ body.de.scam.winning.map                ─┘
  ├─ en
  │   └─ ....
  ├─ href
  │   ├─ body.href.az.domain.name.map            ─┐
  │   ├─ body.href.ch.domain.name.map             │
  │   ├─ body.href.de.domain.name.map             ├─ multimap.body.href.conf
  │   ├─ body.href.us.domain.name.map             │
  │   ├─ body.href.domain.name.pattern.map        │
  │   └─ body.href.url.path.orgbrandprod.map     ─┘
```

### Setup for "sender"

Folder structure:
```
sender
  ├─ de
  │   ├─ sender.from.de.map                        - multimap.sender.de.conf 
  │   ├─ sender.from.de.adult.map                  - multimap.sender.de.adult.conf
  │   ├─ sender.from.de.finance.map                - multimap.sender.de.finance.conf
  │   ├─ sender.from.de.gambling.map               - multimap.sender.de.gambling.conf
  │   ├─ sender.from.de.health.map                 - multimap.sender.de.health.conf
  │   ├─ sender.from.de.lottery.map                - multimap.sender.de.lottery.conf
  │   ├─ sender.from.de.makemoney.map              - multimap.sender.de.makemoney.conf
  │   ├─ sender.from.de.phishing.map               - multimap.sender.de.phishing.conf
  │   ├─ sender.from.de.phishing.malware.map       - multimap.sender.de.phishing.malware.conf
  │   ├─ sender.from.de.sale.map                   - multimap.sender.de.sale.conf
  │   │
  │   ├─ sender.from.de.singleword.map             - multimap.sender.de.conf
  │   └─ sender.from.de.singleword.ucase.map       - multimap.sender.de.conf
  ├─ en
  │   └─ ....
  ├─ sender.from.phishing.orgbrandprod.map         - multimap.sender.phishing.conf
  │
  ├─ sender.address.map                          ─┐
  ├─ sender.from.orgbrandprod.map                 │
  ├─ sender.from.people.map                       ├─ multimap.sender.conf
  └─ sender.from.special.map                     ─┘
```

### Setup for "subject"

Folder structure:
```
subject
  ├─ de
  │   ├─ subject.de.map                          ─┐  
  │   ├─ subject.de.greetings.map                 │
  │   ├─ subject.de.message.map                   ├─ multimap.subject.de.conf
  │   ├─ subject.de.singleword.map                │
  │   ├─ subject.de.singleword.ucase.map         ─┘
  │   │
  │   ├─ subject.de.adult.map                      - multimap.subject.de.adult.conf
  │   ├─ subject.de.finance.map                    - multimap.subject.de.finance.conf
  │   ├─ subject.de.gambling.map                   - multimap.subject.de.gambling.conf
  │   ├─ subject.de.health.map                     - multimap.subject.de.health.conf
  │   │
  │   ├─ subject.de.phishing.map                 ─┐
  │   ├─ subject.de.phishing.account.map          │
  │   ├─ subject.de.phishing.alertaction.map      │
  │   ├─ subject.de.phishing.banking.map          │
  │   ├─ subject.de.phishing.email.map            │
  │   ├─ subject.de.phishing.malware.map          ├─ multimap.subject.de.phishing.conf
  │   ├─ subject.de.phishing.parcel.map           │
  │   ├─ subject.de.phishing.password.map         │
  │   ├─ subject.de.phishing.payment.map          │
  │   ├─ subject.de.phishing.rewards.map          │
  │   ├─ subject.de.phishing.subscription.map     │
  │   ├─ subject.de.phishing.survey.map          ─┘
  │   │
  │   ├─ subject.de.sale.map                     ─┐
  │   ├─ subject.de.sale.app.map                  ├─ multimap.subject.de.sale.conf
  │   ├─ subject.de.sale.seo.map                  │
  │   ├─ subject.de.sale.website.map             ─┘
  │   │
  │   ├─ subject.de.scam.map                     ─┐
  │   ├─ subject.de.scam.bignumbers.map           │
  │   ├─ subject.de.scam.donation.map             ├─ multimap.subject.de.scam.conf
  │   ├─ subject.de.scam.order.map                │
  │   └─ subject.de.scam.winning.map             ─┘
  ├─ en
  │   └─ ....
  ├─ subject.health.medname.map                    - multimap.subject.health.conf
  ├─ subject.orgbrandprod.map                    ─┐
  └─ subject.special.map                          ├─ multimap.subject.conf
  └─ subject.special.emoji.map                   ─┘
```


### Setup for "whitelist"

Folder structure:
```
whitelist
  ├─ de
  │   ├─ body.de.whitelist.map                   ─┐
  │   ├─ sender.from.de.whitelist.map             │
  │   └─ subject.de.whitelist.map                 │
  ├─ en                                           │
  │   └─ ....                                     │
  ├─ body.href.url.az.whitelist.map           +   ├─ multimap.whitelist.conf  
  ├─ body.href.url.ch.whitelist.map           +   │ 
  ├─ body.href.url.de.whitelist.map           +   │ 
  ├─ body.href.url.us.whitelist.map           +   │ 
  └─ header.ip.whitelist.map                  +  ─┘

```

+ -> "prefilter" is set

Unfortunately, whitelisting with the prefilter option set doesn't work. I don't know why, and I can't find any help in the community. What a pity!

## Tips and Tricks

### Scoring
If you want to increase or decrease a symbol's score, you can do so in the UI.
Click "Symbols" in the menu, then find the desired symbol and change the score.
