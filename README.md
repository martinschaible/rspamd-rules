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
These are the latest changes:

:point_right: A major migration of the configuration files is necessary:<br>
:small_blue_diamond: The naming of the "Sender" files was unfortunate and has now been corrected.<br>
:small_blue_diamond: New configuration files have also been added<br>

:small_blue_diamond: Maybe the easiest way is to re-copy all configuration files.<br>
:small_blue_diamond: After copying the files, the Rspamd service must be restarted.

| Date     | File                                       | Reason                        |
| -------- | -------------------------------------------| ----------------------------- |
| 02.08.25 | multimap.subject.de.scam.conf              | New map file added            |
|          | multimap.subject.en.scam.conf              | New map file added            |
|          | multimap.body.de.scam.conf                 | New map file added            |
|          | multimap.body.en.scam.conf                 | New map file added            |
|          | multimap.subject.de.conf                   | New map file added            |
|          | multimap.subject.en.conf                   | New map file added            |
| 08.08.25 | multimap.sender.address.conf               | New map file added, changes   |
|          | multimap.base.body.href.conf               | New map file added, changes   |
| 16.08.25 | multimap.sender.address.conf               | Configuration changed         |
| 20.08.25 | multimap.conf                              | Path of configuration files changed<br>New configuration files added |
| 20.08.25 | multimap.whitelist.conf                    | New configuration files added |
| 20.08.25 | multimap.whitelist.body.href.conf          | New configuration file        |
| 20.08.25 | multimap.whitelist.body.de.conf            | New configuration file        |
| 20.08.25 | multimap.whitelist.body.en.conf            | New configuration file        |
| 20.08.25 | multimap.whitelist.header.ip.conf          | New configuration file        |
| 08.09.25 | multimap.body.conf                         | New map file added            |
| 29.09.25 | multimap.body.de.sale.conf                 | New map file added            |
|          | multimap.body.en.sale.conf                 | New map file added            |
|          | multimap.subject.de.sale.conf              | New map file added            |
|          | multimap.subject.en.sale.conf              | New map file added            |
|          | multimap.sender.from.de.sale.conf          | New map file added            |
|          | multimap.sender.from.en.sale.conf          | New map file added            |
| 04.10.25 | multimap.body.de.health.conf               | New map file added            |
|          | multimap.body.en.health.conf               | New map file added            |
|          | multimap.subject.de.health.conf            | New map file added            |
|          | multimap.subject.en.health.conf            | New map file added            |
| 05.10.25 | multimap.whitelist.body.href.conf          | New map file added            |
|          | multimap.whitelist.body.conf               | New file                      |
|          | multimap.whitelist.conf                    | Map file removed              |
|          | multimap.conf                              | New configuration file added  |
| 06.10.25 | multimap.sender.from.de.scam.conf          | New map file added            |
|          | multimap.sender.from.en.scam.conf          | New map file added            |
|          | multimap.conf                              | New configuration file added  |
| 10.10.25 | multimap.whitelist.header.ip.conf          | Configuration changed         |
| 12.10.25 | multimap.body.de.conf                      | New configuration file        |
|          | multimap.body.en.conf                      | New configuration file        |
|          | multimap.sender.de.conf                    | New configuration file        |
|          | multimap.sender.en.conf                    | New configuration file        |
|          | multimap.whitelist.sender.from.de.conf     | New configuration file        |
|          | multimap.whitelist.sender.from.en.conf     | New configuration file        |
|          | multimap.whitelist.subject.de.conf         | New configuration file        |
|          | multimap.whitelist.subject.en.conf         | New configuration file        |
|          | multimap.whitelist.conf                    | File deleted                  |
|          | multimap.conf                              | New configuration files added |
| 14.10.25 | multimap.conf                              | New configuration file added  |
|          | multimap.header.conf                       | New configuration file        |
| 15.10.25 | multimap.conf                              | Mistakes fixed                |

## Content
:point_right: All map files of the *first version* are stored in the folder `/etc/rspamd/maps.d/legacy`.<br>
:point_right: The files of the *second edition* are stored in subfolders according to the topic.

### Setup for "base"

Folder structure:

```
base
  ├─ base.country.map                            ─┐
  ├─ base.body.charenc.koi8r.map              *   │
  ├─ base.body.charenc.windows1251.map        *   ├─ multimap.base.conf
  ├─ base.body.markup.hidden.map                  │
  ├─ base.body.markup.map                        ─┘
  │
  ├─ href
  │   ├─ base.body.href.domain.map            *  ─┐
  │   ├─ base.body.href.domain.ip.map         *   │
  │   ├─ base.body.href.domain.tld.map        *   │
  │   ├─ base.body.href.domain.google.map     *   │
  │   ├─ base.body.href.nossl.map             *   ├─ multimap.base.body.href.conf
  │   ├─ base.body.href.path.map              *   │
  │   ├─ base.body.href.path.filename.map     *   │
  │   └─ base.body.href.path.wordpress.map    *  ─┘
  │
  └─ img
      ├─ base.body.img.domain.ip.map          *  ─┐
      ├─ base.body.img.domain.tld.map         *   │
      ├─ base.body.img.domain.name.map        *   ├─ multimap.base.body.img.conf
      ├─ base.body.img.nossl.map              *   │
      ├─ base.body.img.path.map               *   │
      └─ base.body.img.shortener.map          *  ─┘

lists
  ├─ list.tld.map                             *  --- multimap.base.body.href.conf
  │                                           *  --- multimap.sender.address.conf
  └─ list.url.shortener.map                   *  --- multimap.base.body.href.conf
```

* -> "one_shot" is set

### Setup for "body"

Folder structure:
```
body
  ├─ body.attachment.map                         ─┐
  ├─ body.emergency.map                           │
  ├─ body.emergency.ext.map                       │
  ├─ body.orgbrandprod.map                      x │
  ├─ body.special.map                             │
  │                                               │
  ├─ body.az.orgname.map                          ├─ multimap.body.conf
  ├─ body.ch.orgname.map                          │
  ├─ body.de.orgname.map                          │
  ├─ body.us.orgname.map                         ─┘
  │
  ├─ href
  │   ├─ body.href.az.domain.name.map            ─┐
  │   ├─ body.href.ch.domain.name.map             │
  │   ├─ body.href.de.domain.name.map             ├─ multimap.body.href.conf
  │   ├─ body.href.us.domain.name.map             │
  │   ├─ body.href.domain.name.pattern.map        │
  │   └─ body.href.url.path.orgbrandprod.map     ─┘
  │
  ├─ de
  │   ├─ body.de.map                             ─┐
  │   ├─ body.de.greetings.map                    │
  │   ├─ body.de.intros.map                       │
  │   ├─ body.de.message.map                      │
  │   │                                           │      
  │   ├─ body.de.singleword.map                   │
  │   ├─ body.de.singleword.special.map           ├─ multimap.body.de.conf 
  │   ├─ body.de.singleword.ucase.map             │
  │   │                                           │
  │   ├─ body.de.ucase.map                      x │ 
  │   ├─ body.de.unsubscribe.map                 ─┘
  │   │
  │   ├─ body.de.adult.map                       --- multimap.body.de.adult.conf
  │   ├─ body.de.finance.map                     --- multimap.body.de.finance.conf
  │   ├─ body.de.gambling.map                    --- multimap.body.de.gambling.conf
  │   ├─ body.de.health.map                      --- multimap.body.de.health.conf
  │   ├─ body.de.health.specific.map             --- multimap.body.de.health.conf
  │   ├─ body.de.makemoney.map                   --- multimap.body.de.makemoney.conf
  │   │
  │   ├─ body.de.phishing.map                    ─┐
  │   ├─ body.de.phishing.account.map             │
  │   ├─ body.de.phishing.alertaction.map         │
  │   ├─ body.de.phishing.banking.map             │
  │   ├─ body.de.phishing.card.map                │
  │   ├─ body.de.phishing.email.map               │
  │   ├─ body.de.phishing.greetings.map           │
  │   ├─ body.de.phishing.malware.map             │
  │   ├─ body.de.phishing.parcel.map              │
  │   ├─ body.de.phishing.password.map            ├─ multimap.body.de.phishing.conf
  │   ├─ body.de.phishing.payment.map             │
  │   ├─ body.de.phishing.refund.map              │
  │   ├─ body.de.phishing.rewards.map             │
  │   ├─ body.de.phishing.rewards.products.map  x │
  │   ├─ body.de.phishing.sale.map              x │
  │   ├─ body.de.phishing.security.map          x │
  │   ├─ body.de.phishing.subscription.map        │
  │   ├─ body.de.phishing.survey.map              │
  │   ├─ body.de.phishing.wallet.map             ─┘
  │   │
  │   ├─ body.de.sale.map                        ─┐
  │   ├─ body.de.sale.app.map                     │
  │   ├─ body.de.sale.greetings.map               │
  │   ├─ body.de.sale.china.map                   ├─ multimap.body.de.sale.conf
  │   ├─ body.de.sale.media.map                   │
  │   ├─ body.de.sale.specific.map                │
  │   ├─ body.de.sale.seo.map                     │
  │   ├─ body.de.sale.website.map                ─┘
  │   │
  │   ├─ body.de.scam.map                        ─┐
  │   ├─ body.de.scam.business.map                │
  │   ├─ body.de.scam.bignumbers.map              │
  │   ├─ body.de.scam.choosen.map               x │
  │   ├─ body.de.scam.donation.map                │
  │   ├─ body.de.scam.funds.map                   ├─ multimap.body.de.scam.conf
  │   ├─ body.de.scam.investment.map              │
  │   ├─ body.de.scam.order.map                   │
  │   ├─ body.de.scam.payment.map                 │
  │   ├─ body.de.scam.ransom.map                  │
  │   ├─ body.de.scam.winning.map                ─┘
  │   │
  │   └─ body.de.stocks.map                      --- multimap.body.de.stocks.conf
  │
  └─ en
      └─ ....
```

* x -> Not yet implemented

### Setup for "sender"
```
header
  ├─ header.ipaddress.map                        --- multimap.header.conf
  └─ header.hostname.map                         --- multimap.header.conf 
```

### Setup for "sender"

Folder structure:
```
sender
  ├─ sender.address.map                          ─┐
  ├─ sender.address.orgbrandprod.map              ├─ multimap.sender.address.conf
  ├─ sender.address.people.map                    │
  ├─ sender.address.tld.map                      ─┘
  │
  ├─ de
  │   └─ sender.address.de.map                   --- multimap.sender.address.de.conf 
  │
  ├─ sender.from.phishing.orgbrandprod.map       ─┐
  ├─ sender.from.phishing.orgbrandprod.asia.map   ├─ multimap.sender.from.phishing.conf
  ├─ sender.from.phishing.orgbrandprod.ucase.map ─┘
  │
  ├─ sender.from.orgbrandprod.map                ─┐
  ├─ sender.from.people.map                       │
  ├─ sender.from.special.map                      ├─ multimap.sender.from.conf
  ├─ sender.from.special.emoji.map              X │
  ├─ sender.from.title.map                       ─┘
  │
  ├─ de
  │   ├─ sender.from.de.singleword.map           ─┐
  │   ├─ sender.from.de.singleword.special.map    ├─ multimap.sender.from.de.conf
  │   ├─ sender.from.de.singleword.ucase.map     ─┘
  │   │
  │   ├─ sender.from.de.map                      --- multimap.sender.from.de.conf 
  │   ├─ sender.from.de.adult.map                --- multimap.sender.from.de.adult.conf
  │   ├─ sender.from.de.finance.map              --- multimap.sender.from.de.finance.conf
  │   ├─ sender.from.de.gambling.map             --- multimap.sender.from.de.gambling.conf
  │   ├─ sender.from.de.health.map               --- multimap.sender.from.de.health.conf
  │   ├─ sender.from.de.lottery.map              --- multimap.sender.from.de.lottery.conf
  │   ├─ sender.from.de.makemoney.map            --- multimap.sender.from.de.makemoney.conf
  │   ├─ sender.from.de.phishing.map             --- multimap.sender.from.de.phishing.conf
  │   ├─ sender.from.de.phishing.malware.map     --- multimap.sender.from.de.phishing.malware.conf
  │   ├─ sender.from.de.sale.map                 --- multimap.sender.from.de.sale.conf
  │   ├─ sender.from.de.sale.specific.map        --- multimap.sender.from.de.sale.conf
  │   └─ sender.from.de.scam.map                 --- multimap.sender.from.de.scam.conf
  │
  └─ en
      └─ ....
```

### Setup for "subject"

Folder structure:
```
subject  
  ├─ subject.health.medname.map                  --- multimap.subject.health.conf
  ├─ subject.orgbrandprod.map                    ─┐
  ├─ subject.special.map                          ├─ multimap.subject.conf
  ├─ subject.special.emoji.map                   ─┘
  │
  ├─ de
  │   ├─ subject.de.map                          ─┐  
  │   ├─ subject.de.greetings.map                 │
  │   ├─ subject.de.message.map                   │
  │   │                                           │
  │   ├─ subject.de.singleword.map                ├─ multimap.subject.de.conf
  │   ├─ subject.de.singleword.special.map        │
  │   ├─ subject.de.singleword.ucase.map          │
  │   │                                           │
  │   ├─ subject.de.special.map                X  │
  │   ├─ subject.de.ucase.map                    ─┘
  │   │
  │   ├─ subject.de.adult.map                    --- multimap.subject.de.adult.conf
  │   ├─ subject.de.finance.map                  --- multimap.subject.de.finance.conf
  │   ├─ subject.de.gambling.map                 --- multimap.subject.de.gambling.conf
  │   ├─ subject.de.health.map                   --- multimap.subject.de.health.conf
  │   ├─ subject.de.health.specific.map          --- multimap.subject.de.health.conf
  │   │
  │   ├─ subject.de.phishing.map                 ─┐
  │   ├─ subject.de.phishing.account.map          │
  │   ├─ subject.de.phishing.alertaction.map      │
  │   ├─ subject.de.phishing.banking.map          │
  │   ├─ subject.de.phishing.card.map             │
  │   ├─ subject.de.phishing.email.map            │
  │   ├─ subject.de.phishing.malware.map          │
  │   ├─ subject.de.phishing.parcel.map           │
  │   ├─ subject.de.phishing.password.map         ├─ multimap.subject.de.phishing.conf
  │   ├─ subject.de.phishing.payment.map          │
  │   ├─ subject.de.phishing.refund.map           │
  │   ├─ subject.de.phishing.rewards.map          │
  │   ├─ subject.de.phishing.rewards.products.map │ X
  │   ├─ subject.de.phishing.sale.map             │ X
  │   ├─ subject.de.phishing.security.map         │ X
  │   ├─ subject.de.phishing.survey.map           │
  │   ├─ subject.de.phishing.wallet.map          ─┘
  │   │
  │   ├─ subject.de.sale.map                     ─┐
  │   ├─ subject.de.sale.app.map                  │
  │   ├─ subject.de.sale.china.map                │
  │   ├─ subject.de.sale.media.map                ├─ multimap.subject.de.sale.conf
  │   ├─ subject.de.sale.seo.map                  │
  │   ├─ subject.de.sale.specific.map             │
  │   ├─ subject.de.sale.website.map             ─┘
  │   │
  │   ├─ subject.de.scam.map                     ─┐
  │   ├─ subject.de.scam.bignumbers.map           │
  │   ├─ subject.de.scam.business.map             │
  │   ├─ subject.de.scam.choosen.map              │ X
  │   ├─ subject.de.scam.donation.map             │
  │   ├─ subject.de.scam.funds.map                ├─ multimap.subject.de.scam.conf
  │   ├─ subject.de.scam.investment.map           │
  │   ├─ subject.de.scam.order.map                │
  │   ├─ subject.de.scam.payment.map              │
  │   ├─ subject.de.scam.winning.map             ─┘
  │   │
  │   └─ subject.de.stocks.map                   --- multimap.subject.de.stocks.conf
  │
  └─ en
      └─ ....
```


### Setup for "whitelist"

Folder structure:
```
whitelist
  ├─ header
  │    ├─ header.ipaddress.map                   --- multimap.whitelist.header.conf
  │    └─ header.hostname.map                    --- multimap.whitelist.header.conf 
  │
  ├─ body
  │    ├─ body.emergency.map                     ─┐
  │    ├─ body.az.orgname.map                     │
  │    ├─ body.ch.orgname.map                     ├─ multimap.whitelist.body.conf
  │    ├─ body.de.orgname.map                     │
  │    ├─ body.us.orgname.map                    ─┘
  │    │
  │    ├─ href
  │    │   ├─ body.href.az.url.map               ─┐ 
  │    │   ├─ body.href.ch.url.map                │
  │    │   ├─ body.href.de.url.map                ├─ multimap.whitelist.body.href.conf
  │    │   ├─ body.href.us.url.map                │
  │    │   └─ body.href.mailing.url.map          ─┘
  │    │
  │    ├─ de
  │    │   ├─ body.de.orgbrandprod.map         X ─┐
  │    │   ├─ body.de.singleword.map              ├─ multimap.whitelist.body.de.conf
  │    │   └─ body.de.map                        ─┘
  │    │ 
  │    └─ en
  │        └─ ....
  ├─ sender
  │    ├─ de
  │    │   └─ sender.from.de.map                 --- multimap.whitelist.sender.from.de.conf
  │    │
  │    └─ en
  │        └─ ....
  │
  └─ subject
       ├─ de
       │   ├─ subject.de.map                     --- multimap.whitelist.subject.de.conf
       │   └─ subject.de.singleword.map       X  --- multimap.whitelist.subject.de.conf
       │
       └─ en
           └─ ....
```

## Tips and Tricks

### Scoring

If you want to increase or decrease a symbol's score, you can do so in the UI.
Click "Symbols" in the menu, then find the desired symbol and change the score.

Important
* You can change the scoring for a map file, or rather its **symbol**, and **not for a single rule**.
* The scoring for an individual rule can *only* be changed in the map file. Depending on the rule, I do it this way.

A score of 6 can be considered SPAM-LOW.
Using SmarterMail, this value is multiplied by 1.7 to reach 10 points.

I set most map files to score level 12.

### Which rule has fired?
Unfortunately, Rspamd is unable to log the rule(s) of a map file that fired.
This complicates the whole process in case of an error.

### Handling false/positives
There's always a risk that an email will be mistakenly marked as spam.

If a map file is to blame, I'm happy to change or remove a rule.
My rules are designed specifically for *German-speaking* countries.
Therefore, some phrases might be too strong for English-speaking countries.

Open an issue and I'll be happy to resolve the issue.

### When spam emails slip through
Great! I love fresh spam! To create one or more rules, I need the complete, unaltered email.
Send it to spamcop[ät]netfusion[döt]ch and add the word "SPAM" to the subject line.

<p align="center">Made with :heart: and :coffee:</p>
