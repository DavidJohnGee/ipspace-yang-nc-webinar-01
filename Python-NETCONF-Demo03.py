#! /usr/bin/Python

from lxml import etree
import ietfipspace

rootObject = ietfipspace.parse('ipspaceoutput.xml')

print "===== Print DIR on rootObject ====="
print dir(rootObject)

print "===== Print host name currently set ====="
print rootObject.get_host_name()

print "===== Set hostname and print ====="
rootObject.set_host_name("Test01")
print rootObject.get_host_name()
print "\n\n\n"

rootObj, rootElement, mapping, reverse_mapping = ietfipspace.parseEtree('ipspaceoutput.xml')
