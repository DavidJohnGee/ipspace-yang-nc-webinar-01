####David Gee - ipengineer.net YANG Notes


YANG - RFC3535 - transactional management for configuration

YANG models represent configuration in a standard way
NETCONF acts as a configuration substrate for YANG

YANG Data Model describes a device

NETCONF - remote primitives to view and manipulate the data
encoding of the data as defined by the data model

NETCONF is a domain specific network management protocol
SNMP can be used
CORBA, SOAP, REST are general RPC

NETCONF: Understands configuration management and is a standard

SNMP is used globally for monitoring but fails horrifically for configuration management.
CLI scripting was the primary method of configuration management.

1.	Ease of use
2.	Clear distinction between confiugration data, operational state and statistics
3.	Fetch separately confiugration data, operational state and statistics from devices
4.	Necessary to allow operators to concentrate on the confiugration of the network as a whole rather than individual devices
5.	Configuration transactions - across a single or number of devices
6.	Delta based configurations A to B - minimise the impact caused by software changes
7.	Be able to dump and restore configurations is a primitive operation needed by operators.
	Standards to pull/push configuration 
	Backup restore confiugration

	The litmus-test of a management interface - check across all devices etc

8.	Easy to do consistency checks of configurations over time and between the ends of a link to determine changes and consistency
9.	No common database schema, network configurations are stored in a central DB, then processed in to CLI commands or RPC calls
	to roll-out configuration. Desirable to extract, document and standardize the common parts of these network wide config databases schemas.
10.	Text processing tools can be used to process configurations
11.	Distinguish between distribution and activation of certain configurations. Devices should be able to hold multiple configurations.

*	Support for delayed, orchestrated activation
*	Multiple configuration sets

*	Four properties define a transaction known as ACID:

	- Atomicity - transactions are indivisible - all or nothing
	- Consistency - All at once, no internal order, it's a set and not a sequence
	  	Implies that a system that behaves differently with respect to the sequence is not transactional
	- Independence - Parallel transactions do not interfere with each other, and transactions appear in sequence
	- Durability - Committed data always sticks and is persistent

	Order matters of course in execution, but not transaction

NETCONF messages are encoded in XML - 
*	NETCONF 1.0 ]]>]]>
*	NETCONF 1.1 - a line with the number of characters to read in ASCII

NETCONF typically goes over SSH (TCP), although SOAP, BEEP and TLS are also defined.


open phase:

<hello> message decalres capabilities. Some are defined in the base NETCONF spec, some are private. Roughly equates to each model the device knows is a capability.

Extensions go in separate XML namespaces which makes it easier for backwards compatibility

NETCONF has a simple view on the world:

	Startup
	Running (mandatory)
	Candidate
	Files/URL

<edit-config> allows a manager to send down config changes
Manager doesn't need to worry about order
If it fails, simply the transaction content hasn't been activated

Using the candidate data store, a NETCONF manager can implement a network wide transaction.
*	Send config change to each relevan device
*	Validate config
*	If all are fine, tell participating devices to commit

Confirmed-commit allows a manager to activate a change and test for a while.
If satisfactory - commit. If not drop the connection to the devices (equates to abort) and all devices roll back

NETCONF Base Operations

<get>
<get-config>
<edit-config> (Don't forget <target> and <config> sections)
	test-option (:validate)
		test-then-set
		set
		test-only
	error-option
		stop-on-error (default)
		continue-on-error
		rollback-on-error
	operation
		merge
		replace
		create
		delete
		remove (:base:1.1)
<copy-config> 
<commit> (:candidate, :confirmed)
<discard-changes> (:candidate)
<cancel-commit> (:candidate)
<delete-config>
<lock>
<unlock>
<close-session>
<kill-session>

Operational capabilities:

:writable-running
:candidate
:confirmed-commit
:rollback-on-error
:validate
:startup
:url (scheme=http, ftp, file...)
:xpath

Non-base NETCONF capabilities:

:notification :interleave (RFC 5277)
:partial-lock (RFC 5717)
:with-defaults (RFC 6243)
:ietf-netconf-monitoring (RFC 6022)

And you can define your own like:

:actions
:inactive


YANG works better when a module represents functionality

use Pyang to validaet data models
Pyang has different output modules - such as tree <code>pyang -f tree acme-box.yang</code>

datatracker.ietf.org/wg/netmod < YANG models for IP management, interface management, routing, SNMP etc etc
netconfcentral.org/modulelist

Every model has a unique namespace to avoid nameclash

modules & submodules:

modules can import submodules, but submodules cannot reference definitions in the main module
import just imports a reference
include includes the whole lot

YANG base types: int8/16/32/64
uint8/16/32/64
decimal64
string
enumeration
boolean
bits
binary
leafref
identifyref
empty

You can do typedefs, so for example:

typedef percent {
	type unit16 {
		range "0 .. 100";
	}
	description "Percentage";
}

Use like:

leaf completed {
	type percent;
}


You can also do unions:

typedef threshold {
	description "Threshold value in percent";
	type union {
		type uint16 {
			range "0 .. 100";
		}
		type enumaration {
			enum disabled {
				description "No threshold";
			}
		}
	}
}

There are YANG types you can import, such as,

counter32/64
gauge32/64
object-identifier
date-and-time
timeticks
timestamp
phs-address
ip-version
flow-label
port-number
ip-address
ipv4-address
ipv6-address
ip-prefix
ipv4-prefix
ipv6-prefix
domain-name
uri
mac-address
bridgeid
vlanid

use with prefix:

import "ietf-yang-types" { RFC6021
	prefix yang;
}

type yang:counter64



Grouping: re-usable sub-tree structure

grouping target {
	leaf address {
		type inet:ip-address
		description "Target IP";
	}
	leaf port {
		type inet:port-number;
		description "Target port number";
	}
}
container peer {
	container destination {
		uses target;
	}
}

Groupings can be refiend:

container servers {
	container http {
		uses target {
			refine port {
				default port 80;
			}
		}
	}
}


LEAF definitions hold a single value of a particular type and have no children

leaf host-name {
	type string;
	mandatory true;
	config true;
	description "Hostname for this sytem";
}

leaf cpu-temp {
	type int32;
	units degrees-celcius;
	config false;
	description "Current temperature in CPU";
}

Attributes for leaf:

config - Is this value configurable? True or false. Inherited from parent container if not specified.
default - Specifies default value for this leaf. Implies that leaf is optional
mandatory - Whether the elaf is mandatory (true) or optional (false)
must - XPath constraint that will be enforced for this leaf
type - The data type and range of this leaf
when - Only present if XPath expression is true
description - Human readable definition
reference - Human readable reference
units - Hz, MB/s, F - human readable
status - current, deprecated, obsolete


Containers allow your data to be put in to trees called presence containers. NETCONF client creates containers...enables the SSH subsystem

container system {
	container services {
		container ssh {
			presence "Enables SSH";
			description "SSH service specific configuration";
			// more leafs, containers and other things here...
		}
	}
}

Leaf-list holds multiple values of a particular type and has no children.

leaf-list domain-search {
	type string;
	ordered-by user;
	description "List of domain names to search";
}

Better to include typedefs than include enums inline within a leaf or container.

Don't forget, if a statement section doesn't have 'config', then it's evaluated to be true!

leaf-list is a list of things...list of users, interfaces etc


List statement can be of any structure. Tables for example.

list user {
	key name;
	leaf name {
		type string;
	}
	leaf uid {
		type uint32;
	}
	leaf full-name {
		type string;
	}
	leaf class {
		type string;
		default viewer;
	}
}


Can have lists of lists, containers of lists...things can be arbitrarily complex.

Attributes for list and leaf-list

max-elements (if not listed, there is no upper bound)
min-elements (if not listed, there is no lower limit)
ordered-by (system or user, 'ordered-by user' is great for firewall rules etc)

Non-key fields can also be declared unique:

list user {
	key uid;
	unique name;
}

With leaf ref's, you can't delete data that is being referred to, such as the mgmt-if case discussed earlier.

Let's take a RIP example:

container rip {
	list network-ifname {
		key ifname
	}

	leaf ifname {
		type leafref {
			path "/interface/name";
		}
	}
}

(XPATH = /name['keyname']/uid = 101)

REFER TO DIAGRAM FOR LEAFPATHRIP REFERENCE

YANG RPCs and Notifications

YANG RPCs - explicit actions: reboot, do X, blah

rpc activate-software-image {
	input {
		leaf image {
			type binary;
		}
	}
	output {
		leaf status {
			type string;
		}
	}
}



Notification statement

notification config-change {
	description "The configuration changed";
	leaf operator-name {
		type string;
	}
	leaf-list change {
		type instance-identifier;
	}
}

A NETCONF client subscribes to notifications and those notifications are sent over the subsystem channel

Instance-identifiers are references into a tree...any path in to the model

Must Statement

Restricts valid values by XPath 1.0 expression...very cool.

container timeout {
	leaf access-timeout {
		description "Max time without server response";
		units seconds;
		mandatory true;
		type uint32;
	}
	leaf retry-timer {
		description "Period to retry";
		units seconds;
		type uin32;
		must "current() < ../access-timeout" {
			error-app-tag retry-timer-invalid;
			error-message "The retry timer must be less than the access timeout"
		}
	}
}

Another cool must XPath: 

leaf max-weight {
	type uint32 {
		range "0 ..1000";
	}
	default 100;

	must "sum(/sys:sys/interface[enabled='true']/weight) < current()" {
		error message "The total weight exceeds the configured max weight";
	}
}

Augment:

Allows you to augment bits of the model on to another

augment /sys:system/sys:user { 
	leaf expire {
		type yang:date-and-time;
	}
}	

augment /sys:system/sys:user {
	when "sys:class = 'wheel' ";
	leaf shell {
		type string;
	}
}

Choice Statement: Do not confuse with union

Choice allows one of several alternatives:::part of the configuration subtree:

choice transfer-method {
	leaf transfer-interval {
		description "Frequency at which file transfer happens";
		type uint16 {
			range "15 .. 2880";
		}
		units minutes;
	}
	leaf transfer-on-commit {
		description "Transfer after each commit";
		type empty;
	}
}

Can also do something like this:

choice counters {
	case four-counters {
		leaf threshold {}
		leaf ignore-count {}
		leaf ignore-time {}
		leaf reset-time {}
	}
	container warning-only {

	}
	default four-counters;
}

Identity Statement

Identities for modeling families of related enumaration constants

module phs-if {
	identity ethernet {
		description "Ethernet family of PHY interfaces"
	}
	identity eth-1G {	< sub identity
		base ethernet;	< base type of identity
		description "1 GigEth";
	}
	identity eth-10G {
		base ethernet;
		description "10 GigEth"
	}
}

module newer {
	identity eth-40G {
		base phs-if:ethernet
		description "40 GigEth";
	}
	identity eth-100G {
		base phs-if:ethernet;
		description "100 GigEth";
	}
	leaf eth-type {
		type identityref {
			base "phs-if:ethernet"
		}
	}
}


Feature Statement

feature has-local-disk {
	description "System has a local file system that can be used for storing logs";
}

container system {
	container logging {
		if-feature has-local-disk;
		presence "Logging enabled";
		leaf buffer-size {
			type filesize;
		}
	}
}

Features are exchanged in the hello message







module acme-system {
	namespace "http://acme.example.com/system";
	prefix "acme";

	organization "ACME Inc.";
	contact "me@acme.com";

	description "The module for entities implementing the ACME system";
	revision 2207-11-05 {
		description "Initial revision.";
	}
	container system {
		leaf host-name {
			type string;
			description "Hostname for the system";
		}
		list interface {
			key "name";
			description "Listof interfaces in the system";
			leaf name {
				type string;
			}
			leaf type {
				type string;
			}
			leaf mtu {
				type int32;
			}
		}
	}
}