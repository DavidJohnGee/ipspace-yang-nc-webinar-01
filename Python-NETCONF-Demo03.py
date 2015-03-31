#! /usr/bin/python

from lxml import etree

import ietfipspace

ifacetype = ""

print "===== XML Document Loaded ====="
rootObject = ietfipspace.parse('ipspaceoutput2.xml')

#print "===== Print DIR on rootObject ====="
#print dir(rootObject)

print "\n\n===== Host name currently set ====="
print rootObject.get_host_name()

# Get Interfaces list from the rootObject
interfaces = rootObject.get_interface()

print "\n\n===== Print settings for each interface ====="
# Iterate through them and print off detail
for interface in interfaces:
    print "Interface name is:\t\t" + interface.get_name()
    print "Interface description is:\t" + interface.get_description()
    print "Interface MTU is:\t\t" + str(interface.get_mtu())

    if interface.GigEthernet:
        ifacetype = "Gigabit Ethernet"
    if interface.FastEthernet:
        ifacetype = "FastEthernet"
        
    print "Interface type is:\t\t" + ifacetype
