#!/bin/python
import  xmltodict 
import hashlib
import requests
import sys

if len(sys.argv) != 6:
  print("profilechange.py user pwd ip profilename [never|unlimited]")
  exit(1)

(dummy, user, pwd, ip, profil, status) = sys.argv

def calcHash(challenge, pwd):
    cp = (challenge + "-" + pwd).encode("UTF-16LE")
    md5hash = hashlib.md5(cp).hexdigest()
    return challenge + "-" + md5hash

url=f"http://{ip}/login_sid.lua?username={user}"
r = requests.get(url)
dict_data = xmltodict.parse(r.content)
challenge = dict_data["SessionInfo"]["Challenge"]

md5 = calcHash(challenge, pwd)
r = requests.get(f"http://{ip}/login_sid.lua", params={
            "username": user,
            "response": md5
        })
dict_data = xmltodict.parse(r.content)
sid = dict_data["SessionInfo"]["SID"]
if (sid == "0000000000000000"):
    print("Login failed. (No SID)")
    exit(1)


r = requests.post(f"http://{ip}/data.lua", data={
    "sid": sid,
    "edit": profil,
    "time": status,
    "budget": "unlimited",
    "apply": "",
    "page": "kids_profileedit" 
    }, allow_redirects=False)
if r.json()["data"]["apply"] == "ok":
    print("ok")
else:
    print("failed")
