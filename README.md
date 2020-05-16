
# APEX Plugin Cav Success Message

[![APEX Community](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/78c5adbe/badges/apex-community-badge.svg)](https://github.com/Dani3lSun/apex-github-badges) [![APEX Plugin](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/b7e95341/badges/apex-plugin-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)
[![APEX Built with Love](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/7919f913/badges/apex-love-badge.svg)](https://github.com/Dani3lSun/apex-github-badges)


![preview](preview.gif)

This Process plugin was created and donated by my good friend [Gemma Wood](https://twitter.com/gemmawood) and she entrusted me with the maintence and publishing. The plugin will override the generic "Action Processed." message and provide a better user experience. Users will see a personalized Success Message when you Create, Save, or Delete records. 

Plugin File [process_type_plugin_cav_success_message.sql](process_type_plugin_cav_success_message.sql)


## Demo App

Live Demo [apex.oracle.com/pls/apex/f?p=146744](https://apex.oracle.com/pls/apex/f?p=146744)

Install Demo App [f130.sql](apex/f130.sql)

## How To Use

* Create an Application Item `PLUGIN_SUCCESS_MESSAGE`. This item is used to return a success message when using Modal Dialogs.
* Add a Process "Cav Success Message \[Plug-In\]" as the last page process (or second to last if there is a Close Dialog process).
* If there is a Close Dialog process, its success message should be set to `&PLUGIN_SUCCESS_MESSAGE.`
* Configure the plugin with the name of your "Entity".


