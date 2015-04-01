##IPSpace.net YANG and NETCONF webinar files

This repository contains all the files used in the webinar.

Check the Links.md file for all of the links used in the webinar.


---

####File Description

__Links.md__ 					
File containing useful links from the webinar including RFCs

__Python-NETCONF-Demo01.py__	
This Python file changes a hostname on Junos via NETCONF

__Python-NETCONF-Demo02.py__ 	
This Python file gets terse interface configuration on Junos via NETCONF

__Python-NETCONF-Demo03.py__ 	
This Python file imports the automatically generated code from GenerateDS and imports NETCONF data

__YANG 101 Notes 01 - David-Gee - ipengineer.net__
This is a file containing my own YANG 101 notes. I found it serves as a helpful reminder when building YANG files

__ietf-ipspace@2015-03-31.yang__
This is our demo YANG file and it also runs on ConfD. Check it with pyang to validate and also with the --ietf flag :) Download and fix!

__ietfipspace.py__
This file is automtically generated from our YANG file XSD. It contains 'getters' and 'setters' for our YANG nodes

__ietfipspace.xsd__
Automatically generated XSD file derived from our YANG file

__ipspace.omni__
Our Omnigraffle file from pyang derived from our YANG file

__ipspace.scpt__
The Apple script file which runs Omnigraffle with the .omni file above

__ipspaceoutput.xml__
This file contains our original output from NETCONF. Note the two different XML namespaces?

__ipspaceoutput2.xml__
This file is almost the same as above, however the root is the \<system\> node and has a single XML namespace
								


