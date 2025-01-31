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

### Folder base

```
|- base
     |- base.country.map
     |- base.body.charenc.koi8r.map
     |- base.body.charenc.windows1251.map
     |- base.body.markup.hidden.map
     |- base.body.markup.map
     |- href
     |   |- base.body.href.domain.map
     |   |- base.body.href.domain.ip.map
     |   |- base.body.href.domain.google.map
     |   |- base.body.href.nossl.map
     |   |- base.body.href.path.map
     |   |- base.body.href.path.filename.map
     |   |- base.body.href.path.wordpress.map
     |- img
         |- base.body.img.domain.ip.map
         |- base.body.img.domain.tld.map
         |- base.body.img.domain.name.map
         |- base.body.img.nossl.map
         |- base.body.img.path.map
         |- base.body.img.shortener.map
```

### Folder body
Please be patient. Text will follow soon.

### Folder lists
Please be patient. Text will follow soon.

### Folder sender
Please be patient. Text will follow soon.

### Folder subject
Please be patient. Text will follow soon.

### Folder whitelist
Please be patient. Text will follow soon.
