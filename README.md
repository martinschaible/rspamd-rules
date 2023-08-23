## rspamd-rules - Curated Multimaps with Rules for Rspamd

Even in 2023 an accurate content filtering is the last resort of a spam filtering system.

Rspamd offers so called **Multimaps** and their **Maps**. This allows with or without regex to create any rule we want.

As i did it in *Declude* i created maps related to different categories mostly for two languages:

### Base:
* \_base_bad\_attachment_*lang*
* \_base_bad\_file_*lang*
* \_base_bad\_sender_*lang*
* \_base_bad\_tld
* \_base_bad\_url_shortener
* \_base_bad\_url_wordpress
* \_base_bad\_url
* \_base_image_only_link
* \_base_ip_as_host
* \_base_markup
* \_base_markup_image_map

### Base Phrases:
* \_base_phrases_greeting_*lang*
* \_base_phrases_h_*lang*
* \_base_phrases_m_*lang*
* \_base_phrases_l_*lang*
* \_base_phrases_subject_*lang*
* \_base_phrases_unsub_*lang*

### Domains:
* \_domain_bitly
* \_domain_google
* \_domain_tinyurl

### Advertising:
* \_ad_agency\_*lang*
* \_ad_country\_*lang*

### Adult:
* \_adult_subject_*lang*
* \_adult_s*lang*

### Finance:
* \_finance_subject_*lang*

### Health:
* \_health_sender_*lang*
* \_health_subject_*lang*
* \_health_med_name
* \_health_men_*lang*
* \_health_wl_*lang*
* \_health_*lang*
* \_finance_*lang*

### Makemoney:
* \_makemoney_btc_*lang*
* \_makemoney_*lang*

### Phishing:
* \_phishing_sender_*lang*
* \_phishing_subject_*lang*
* \_phishing_account_*lang*
* \_phishing_banking_*lang*
* \_phishing_parcel_*lang*
* \_phishing_*lang*

### Winning:
* \_winning_*lang*
* \_winning_subject_*lang*

### Sale:
* \_sale_sender_*lang*
* \_sale_subject_*lang*
* \_sale_*lang*

### Scam:
* \_scam_sender_*lang*
* \_scam_subject_*lang*
* \_scam_donation_*lang*
* \_scam_*lang*

### Virus:
* \_virus_subject_*lang*
* \_virus_*lang*

### Special categories for experimental rules:
* \_experimental_c_body
* \_experimental_c_full
* \_experimental_c_oneline
* \_experimental_c_rawtext
* \_experimental_c_text

I will add a description and details about the files in the next few days.

**The rules will be updated on a daily base.**

To be honest, I haven't understood everything yet and therefore not every rules is perfect.
Sometimes it is hard to understand the documentation for me.

Feel free to use these maps on your Rspamd server.

If you have any question or feedback then drop me line at the [discussions](https://github.com/martinschaible/rspamd-rules/discussions).
