## Curated Multimaps for Rspamd, second edition

Rspamd offers so-called **multimaps** and their maps. With them you can create rules with or without regular expressions.

I started developing the rules in early 2024 and i am now working on an improved second version.

Before Rspamd, I used an older product called **Declude** as a spam filtering system for our server as well as for customers. Declude also offered a rule system based on regular expressions. This experience is very useful to me here.

The rules are updated at least once, but usually several times a day and are therefore sure to be accurate.

The installation is very simple, which I explain below.

🍀 Feel free to use these maps on your Rspamd server.

📢 If you have any questions or feedback drop me line at the [discussions](https://github.com/martinschaible/rspamd-rules/discussions).

🐛 Bugs and problems can be reported here: [Issues](https://github.com/martinschaible/rspamd-rules/issues).

# Installation
The base is the file *multimaps.conf* in the folder */etc/rspamd/local.d*. This file includes all configuration files of the map files. These files are located in the same folder and must also be copied to the server.

The map files of the first generation begin with an underscore `_multimap....map` . The second generation does not have the leading underscore.

Important: Both versions must be uploaded.

Finally, the Rspamd service must be restarted

`systemctl restart rspamd`

# Content
