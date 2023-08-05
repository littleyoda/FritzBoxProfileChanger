# FritzBoxProfileChanger
Switch the online time of access profiles in the AVM FritzBox on (=unlimited) or off (=never).

This tool allows you to activate or deactivate the Internet connection for a group of devices.

To do this, a access profile must be created in the FritzBox, devices must be assigned to this access profile and the name of the access profile must be extracted. See the first three steps of [this howto](https://community.openhab.org/t/disable-internet-connection-of-specific-echo-device-on-fritz-box-via-script/91374).

I have two versions in different "languages":
* bash script (profilechange.bash)
* Python (profilechange.py)

The passed parameters are the same for both programmes:
```
 profilechange.py username password ip_of_the_fritz_box profile_name unlimited_or_never  
 profilechange.bash username password ip_of_the_fritz_box profile_name unlimited_or_never  
```



There are a number of scripts that are supposed to provide this function, unfortunately none of them work for me (as of Aug 2023).
That is why I have developed my own solution. 

# References
* https://github.com/AaronDavidSchneider/fritzprofiles
* https://community.openhab.org/t/disable-internet-connection-of-specific-echo-device-on-fritz-box-via-script/91374
