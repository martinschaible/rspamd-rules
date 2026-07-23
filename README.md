# Curated Multimaps for Rspamd, second edition

**Rspamd** offers so-called **multimaps** and their maps. With them you can create rules with or without regular expressions.

I started developing the rules in early 2024 and i am now working on an improved second version.

Before Rspamd, I used an older product called **Declude** as a spam filtering system for our server as well as for customers. Declude also offered a rule system based on regular expressions. This experience is very useful to me here.

:bulb: The rules are updated at least once, but usually several times a day and are therefore sure to be accurate.

📢 If you have any questions or feedback drop me line at the [discussions](https://github.com/martinschaible/rspamd-rules/discussions).

🐛 Bugs and problems can be reported here: [Issues](https://github.com/martinschaible/rspamd-rules/issues).

🍀 Feel free to use these maps on your Rspamd server.

## Installation
The base is the file *multimap.conf* in the folder `/etc/rspamd/local.d`. This file includes all configuration files of the map files. These files are located in the same folder and must also be copied to the server.

The map files of the first generation begin with an underscore `_multimap....map`.
The second generation does not have the leading underscore.

Important: To be as effective as possible, both versions must be active until the migration is complete.

Finally, the Rspamd service must be restarted

```
systemctl restart rspamd
```

The map files in the folder `/etc/rspamd/maps.d` do not need to be copied. **Rspamd** loads them directly from Github and caches them locally. New versions are checked periodically.

## Configuration files: Changes and Updates
In the near future, I will be creating more map files.
It's necessary to split existing map files into smaller ones. Sometimes, when analyzing false positives, it's really difficult to find the underlying rule. Splitting them into smaller files will help with this.

:small_blue_diamond:  Please note: This means that the configuration files will need to be updated regularly, and the service will need to be restarted.<br>

:collision: Latest Changes:

| Date     | File                                       | Reason                        |
| -------- | -------------------------------------------| ----------------------------- |
| 20.07.26 | multimap.conf                              | New map files added           |

## Content
:point_right: All map files of the *first version* are stored in the folder `/etc/rspamd/maps.d/legacy`.<br>
:point_right: The files of the *second edition* are stored in subfolders according to the topic.

----

>The document below, which lists the files and directories, will be revised shortly.

### Setup for "base"

Description of the topic goes here.....

Folder structure:

```
base
  ├─ base.country.map
  ├─ base.body.charenc.koi8r.map              *
  ├─ base.body.charenc.windows1251.map        *
  ├─ base.body.markup.hidden.map
  ├─ base.body.markup.map
  │
  ├─ href
  │   ├─ base.body.href.domain.map            *
  │   ├─ base.body.href.domain.ip.map         *
  │   ├─ base.body.href.domain.tld.map        *
  │   ├─ base.body.href.domain.google.map     *
  │   ├─ base.body.href.nossl.map             *
  │   ├─ base.body.href.path.map              *
  │   ├─ base.body.href.path.filename.map     *
  │   └─ base.body.href.path.wordpress.map    *
  │
  └─ img
      ├─ base.body.img.domain.ip.map          *
      ├─ base.body.img.domain.tld.map         *
      ├─ base.body.img.domain.name.map        *
      ├─ base.body.img.nossl.map              *
      ├─ base.body.img.path.map               *
      └─ base.body.img.shortener.map          *

lists
  ├─ list.tld.map                             *
  │                                           *
  └─ list.url.shortener.map                   *
```

* -> "one_shot" is set

### Setup for "asia"

Description of the topic goes here.....

Folder structure:
```
body  
  └─ body.asia.map

sender  
  ├─ sender.from.asia.map
  └─ sender.from.phishing.orgbrandprod.asia.map

subject  
  └─ subject.asia.map
```

### Setup for "malware"

Description of the topic goes here.....

Folder structure:
```
body
  ├─ de
  │   └─ malware.de.map
  └─ en
      └─ ....

sender
  ├─ de
  │   └─ malware.de.map
  └─ en
      └─ ....

subject
  ├─ de
  │   └─ malware.de.map
  └─ en
      └─ ....
```

### Setup for "phishing"

Description of the topic goes here.....

Folder structure:
```
body
  ├─ de
  │   ├─ body.de.phishing.map
  │   │
  │   ├─ body.de.phishing.account.map
  │   ├─ body.de.phishing.alertaction.map
  │   ├─ body.de.phishing.banking.map
  │   ├─ body.de.phishing.card.map
  │   ├─ body.de.phishing.email.map
  │   ├─ body.de.phishing.it.map
  │   ├─ body.de.phishing.greetings.map
  │   ├─ body.de.phishing.obfuscation.map
  │   ├─ body.de.phishing.parcel.map
  │   ├─ body.de.phishing.password.map
  │   ├─ body.de.phishing.payment.map
  │   ├─ body.de.phishing.refund.map
  │   ├─ body.de.phishing.rewards.map
  │   ├─ body.de.phishing.subscription.map
  │   ├─ body.de.phishing.survey.map
  │   └─ body.de.phishing.wallet.map
  ├─ en
  │    └─ ....
  │
  └─ body.phishing.orgbrandprod.ucase.map                  **

sender
  ├─ de
  │   └─ sender.de.phishing.map
  ├─ en
  │   └─ ....
  │
  ├─ sender.from.phishing.orgbrandprod.map
  ├─ sender.from.phishing.orgbrandprod.account.map
  ├─ sender.from.phishing.orgbrandprod.banking.map
  ├─ sender.from.phishing.orgbrandprod.it.map
  ├─ sender.from.phishing.orgbrandprod.parcel.map
  ├─ sender.from.phishing.orgbrandprod.refund.map
  ├─ sender.from.phishing.orgbrandprod.rewards.map
  └─ sender.from.phishing.orgbrandprod.ucase.map

subject
  ├─ de
  │   ├─ subject.de.phishing.map
  │   │
  │   ├─ subject.de.phishing.account.map
  │   ├─ subject.de.phishing.alertaction.map
  │   ├─ subject.de.phishing.banking.map
  │   ├─ subject.de.phishing.card.map
  │   ├─ subject.de.phishing.email.map
  │   ├─ subject.de.phishing.it.map
  │   ├─ subject.de.phishing.parcel.map
  │   ├─ subject.de.phishing.password.map
  │   ├─ subject.de.phishing.payment.map
  │   ├─ subject.de.phishing.refund.map
  │   ├─ subject.de.phishing.rewards.map
  │   ├─ subject.de.phishing.subscription.map
  │   ├─ subject.de.phishing.survey.map
  │   └─ subject.de.phishing.wallet.map
  ├─ en
  │   └─ ....
  │
  ├─ subject.phishing.orgbrandprod.map
  └─ subject.phishing.orgbrandprod.ucase.map

```

### Setup for "sale"

Description of the topic goes here.....

Folder structure:
```
body
  ├─ de
  │   ├─ body.de.sale.map
  │   │
  │   ├─ body.de.sale.app.map
  │   ├─ body.de.sale.greetings.map
  │   ├─ body.de.sale.china.map
  │   ├─ body.de.sale.leads.map
  │   ├─ body.de.sale.media.map
  │   ├─ body.de.sale.seo.map
  │   ├─ body.de.sale.specific.map
  │   └─ body.de.sale.website.map
  ├─ en
  │    └─ ....
  │
  └─ body.sale.orgbrandproduct.map                         **

sender
  ├─ de
  │   ├─ sender.from.de.sale.map
  │   └─ sender.from.de.sale.specific.map
  └─ en
      └─ ....

subject  
  ├─ de
  │   ├─ subject.de.sale.map
  │   │
  │   ├─ subject.de.sale.app.map
  │   ├─ subject.de.sale.china.map
  │   ├─ subject.de.sale.greetings.map
  │   ├─ subject.de.sale.leads.map
  │   ├─ subject.de.sale.media.map
  │   ├─ subject.de.sale.seo.map
  │   ├─ subject.de.sale.specific.map
  │   └─ subject.de.sale.website.map
  ├─ en
  │    └─ ....
  │
  └─ subject.sale.orgbrandproduct.map
```

### Setup for "scam"

Description of the topic goes here.....

Folder structure:

```
body
  ├─ de
  │   ├─ body.de.scam.map
  │   │
  │   ├─ body.de.scam.awards.map                           **
  │   ├─ body.de.scam.business.map
  │   ├─ body.de.scam.bignumbers.map
  │   ├─ body.de.scam.donation.map
  │   ├─ body.de.scam.funds.map
  │   ├─ body.de.scam.heir.map                             **
  │   ├─ body.de.scam.investment.map
  │   ├─ body.de.scam.order.map
  │   ├─ body.de.scam.payment.map
  │   ├─ body.de.scam.ransom.map
  │   ├─ body.de.scam.transaction.map                      **
  │   └─ body.de.scam.winning.map
  └─ en
      └─ ....

sender
  ├─ de
  │   └─ sender.from.de.scam.map
  └─ en
      └─ ....

subject  
  ├─ de
  │   ├─ subject.de.scam.map
  │   ├─ subject.de.scam.awards.map                        **
  │   ├─ subject.de.scam.bignumbers.map
  │   ├─ subject.de.scam.business.map
  │   ├─ subject.de.scam.donation.map
  │   ├─ subject.de.scam.funds.map
  │   ├─ subject.de.scam.investment.map
  │   ├─ subject.de.scam.order.map
  │   ├─ subject.de.scam.payment.map
  │   └─ subject.de.scam.winning.map
  └─ en
      └─ ....
```

>Old description, needs to be changed...

### Setup for "body"

Folder structure:
```
body
  ├─ body.attachment.map
  ├─ body.attachment.ext.map
  ├─ body.emergency.map
  ├─ body.special.map
  │
  ├─ body.az.orgname.map 
  ├─ body.ch.orgname.map
  ├─ body.de.orgname.map
  ├─ body.us.orgname.map
  │
  ├─ href
  │   ├─ body.href.az.domain.name.map
  │   ├─ body.href.ch.domain.name.map
  │   ├─ body.href.de.domain.name.map
  │   ├─ body.href.us.domain.name.map
  │   ├─ body.href.domain.name.pattern.map
  │   └─ body.href.url.path.orgbrandprod.map
  │
  ├─ de
  │   ├─ body.de.map
  │   ├─ body.de.greetings.map
  │   ├─ body.de.intros.map
  │   ├─ body.de.message.map
  │   │    
  │   ├─ body.de.singleword.map
  │   ├─ body.de.singleword.special.map
  │   ├─ body.de.singleword.ucase.map
  │   │
  │   ├─ body.de.ucase.map
  │   ├─ body.de.unsubscribe.map
  │   │
  │   ├─ body.de.adult.map
  │   ├─ body.de.finance.map
  │   ├─ body.de.gambling.map
  │   ├─ body.de.health.map
  │   ├─ body.de.health.specific.map
  │   ├─ body.de.makemoney.map
  │   │
  │   └─ body.de.stocks.map
  │
  └─ en
      └─ ....
```

### Setup for "header"
```
header
  ├─ header.hostname.map
  ├─ header.ipaddress.map
  ├─ header.googlegroups.groupid.map
  └─ header.googlegroups.listpost.map
```

### Setup for "sender"

Folder structure:
```
sender
  ├─ sender.address.map
  ├─ sender.address.domain.name.map
  ├─ sender.address.orgbrandprod.map
  ├─ sender.address.people.map
  ├─ sender.address.tld.map
  │
  ├─ de
  │   └─ sender.address.de.map
  │
  ├─ sender.from.orgbrandprod.map
  ├─ sender.from.people.map
  ├─ sender.from.special.map
  ├─ sender.from.special.emoji.map **
  ├─ sender.from.title.map 
  │
  ├─ de
  │   ├─ sender.from.de.singleword.map
  │   ├─ sender.from.de.singleword.special.map
  │   ├─ sender.from.de.singleword.ucase.map
  │   │
  │   ├─ sender.from.de.map
  │   ├─ sender.from.de.adult.map
  │   ├─ sender.from.de.gambling.map
  │   ├─ sender.from.de.health.map
  │   ├─ sender.from.de.health.specific.map   **
  │   ├─ sender.from.de.lottery.map
  │   └─ sender.from.de.makemoney.map
  │
  └─ en
      └─ ....
```

### Setup for "subject"

Folder structure:
```
subject  
  ├─ subject.health.medname.map
  ├─ subject.orgbrandprod.map
  ├─ subject.special.map
  ├─ subject.special.emoji.map
  │
  ├─ de
  │   ├─ subject.de.map
  │   ├─ subject.de.greetings.map
  │   ├─ subject.de.message.map
  │   │
  │   ├─ subject.de.singleword.map
  │   ├─ subject.de.singleword.special.map
  │   ├─ subject.de.singleword.ucase.map
  │   │
  │   ├─ subject.de.ucase.map
  │   │
  │   ├─ subject.de.adult.map
  │   ├─ subject.de.finance.map
  │   ├─ subject.de.gambling.map
  │   ├─ subject.de.health.map
  │   ├─ subject.de.health.specific.map
  │   │
  │   └─ subject.de.stocks.map
  │
  └─ en
      └─ ....
```


### Setup for "whitelist"

Folder structure:
```
whitelist
  ├─ header
  │    ├─ header.ipaddress.map
  │    └─ header.hostname.map
  │
  ├─ body
  │    ├─ body.emergency.map
  │    ├─ body.az.orgname.map
  │    ├─ body.ch.orgname.map
  │    ├─ body.de.orgname.map
  │    ├─ body.us.orgname.map
  │    │
  │    ├─ href
  │    │   ├─ body.href.az.url.map
  │    │   ├─ body.href.ch.url.map
  │    │   ├─ body.href.de.url.map
  │    │   ├─ body.href.us.url.map
  │    │   └─ body.href.mailing.url.map
  │    │
  │    ├─ de
  │    │   ├─ body.de.singleword.map
  │    │   └─ body.de.map
  │    └─ en
  │        └─ ....
  │
  ├─ sender
  │    ├─ de
  │    │   └─ sender.from.de.map
  │    └─ en
  │        └─ ....
  │
  └─ subject
       ├─ de
       │   ├─ subject.de.map
       │   └─ subject.de.singleword.map
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

### Dealing with false/positives
No Great! Sometimes a rule is to restrictive and a good email was marked as spam.
Send it to the same mail address as above and add the word "NOSPAM" to the subject line.

<br>
<p align="center">Made with :heart: and :coffee:</p>
