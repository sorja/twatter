#Twatter
School project for course [582203/2016/s/a/1](https://www.cs.helsinki.fi/courses/582203/2016/s/a/1)  

Cheap knock off of Twitter which is probably created around whining (valitus)  

**See it live**: https://www.valit.us/

---

[Documentation](doc/Documentation.pdf)  

---
##Running locally
*You need postgres SQL server running and update connections*  
*It's better to use virtualenvwrapper instead of globally installing packages!*  
1. pip install -r requirements.txt  
2. npm install -g bower  
3. bower install *for frontend (css) libs*  
4. update config.py  
5. chmod +x dev.sh (optional, if missing)  
6. ./dev  
