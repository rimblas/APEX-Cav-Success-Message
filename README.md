
# APEX Plugin Cav Success Message

[![APEX Community](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/78c5adbe/badges/apex-community-badge.svg)](https://github.com/Dani3lSun/apex-github-badges) [![APEX Plugin](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/b7e95341/badges/apex-plugin-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)
[![APEX Built with Love](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/7919f913/badges/apex-love-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)


![preview](preview.gif)

This Process plugin was originally imagined and created by my good friend [Gemma Wood](https://twitter.com/gemmawood) of Cavanti. Gemma entrusted me with the maintenance and publishing of the plugin. I then ported it to APEX 5.1 (I'm pretty sure it would even work on APEX 4.2) so it would be compatible with as many versions of APEX as possible. 

The plugin will override the generic "Action Processed." message that we normally see from the regular Automatic DML Process and provide a better user experience by prooviding a more specific message. Users will see a personalized Success Message when you Create, Save, or Delete records. 

Plugin File [process_type_plugin_cav_success_message.sql](process_type_plugin_cav_success_message.sql)


## Demo App

Live Demo [apex.oracle.com/pls/apex/f?p=146744](https://apex.oracle.com/pls/apex/f?p=146744)

Install Demo App [f130.sql](apex/f130.sql)

## How To Use

* Create an Application Item `PLUGIN_SUCCESS_MESSAGE`. This item is used to return a success message when using Modal Dialogs.
* Add a Process "Cav Success Message \[Plug-In\]" as the last page process (or second to last if there is a Close Dialog process).
* If there is a Close Dialog process, its success message should be set to `&PLUGIN_SUCCESS_MESSAGE.`
* Configure the plugin with the name of your "Entity".

## How it works

At the most basic level, the plugin maps a REQUEST value to a message. These are the default values:

| Request   |  Message          |
|:----------|-------------------|
| CREATE    | New #ENTITY# created. |
| SAVE      | #ENTITY# saved.   |
| DELETE    | #ENTITY# deleted. |

You can change all thesde default vaules as needed, translate them, and even map 3 more request values to messages.

The `#ENTITY#` is also defined per plugin implementation.

Finally the "Behavior" attribute can be "Replace", the default, which means the original Success Message (normally "Action Processed.") will be replaced by the plugin.  However, you could use "Append" in which case the plugin will preserve the previously set Success Message and append the new message based on the mapped request.


