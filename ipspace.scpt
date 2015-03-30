
tell application id "com.omnigroup.OmniGraffle6"
    activate
	make new document with properties {name:"ietf-ipspace"}
    set bounds of window 1 to {50, 50, 1200, 800}
	tell first canvas of document "ietf-ipspace"
		set canvasSize to {600, 600}
		set name to "YANG Model"
		set adjusts pages to true
		make new shape at end of graphics with properties {autosizing: vertically only, size: {139.500000, 14.000000}, text: {alignment: center, font: "Helvetica-Bold", text: "Legend"}, text placement: top, origin: {5800.000000, 32.000000}, vertical padding: 0}
		make new shape at end of graphics with properties {autosizing: vertically only, size: {139.500000, 56.000000}, text: {{color: {0.600000, 0.152941, 0.152941}, text: "Mandatory config
"}, {color: {0.129412, 0.501961, 0.254902}, text: "Optional config
"}, {color: {0.129412, 0.501961, 0.254902}, text: "Key leaf", underlined: true}, {color: {0.129412, 0.501961, 0.254902}, text: "
"}, {color: {0.549020, 0.486275, 0.133333}, text: "Not config"}}, text placement: top, origin: {5800.000000, 46.000000}, vertical padding: 0}
		assemble graphics -2 through -1 table shape { 2, 1 }
make new shape at end of graphics with properties {fill: no fill, draws stroke: false, draws shadow: false, autosizing: full, size: {57.000000, 30.000000}, text: {size: 16, alignment: center, font: "HelveticaNeue", text: "ietf-ipspace"}, origin: {100, 4.500000}}
make new shape at end of graphics with properties {autosizing: full, size: {187.500000, 14.000000}, text: {{alignment: center, font: "Helvetica-Bold", text: "container "}, {alignment: center, color: {0.113725, 0.352941, 0.670588}, font: "Helvetica-Bold", text: "system "}}, text placement: top, origin: {150.000000, 11.500000}, vertical padding: 0}
make new shape at end of graphics with properties {autosizing:full, size:{187.5, 28.0}, text:{{font: "Helvetica-Oblique", color:  {0.129412, 0.501961, 0.254902}, text: "host-name? (rw) string
"}}, text placement:top, origin:{150.0, 25.5}, vertical padding:0}
local ietf_ipspace_system
set ietf_ipspace_system to assemble ( graphics -2 through -1 ) table shape {2, 1}
make new shape at end of graphics with properties {autosizing: full, size: {187.500000, 14.000000}, text: {{alignment: center, font: "Helvetica-Bold", text: "list "}, {alignment: center, color: {0.113725, 0.352941, 0.670588}, font: "Helvetica-Bold", text: "interface "}}, text placement: top, origin: {150.000000, 11.500000}, vertical padding: 0}
make new shape at end of graphics with properties {autosizing:full, size:{187.5, 28.0}, text:{{font: "Helvetica-Oblique", color:  {0.129412, 0.501961, 0.254902}, underlined: true, text: "name? (rw) string
"}, {font: "Helvetica-Oblique", color:  {0.129412, 0.501961, 0.254902}, text: "description? (rw) string
"}, {font: "Helvetica-Oblique", color:  {0.129412, 0.501961, 0.254902}, text: "mtu? (rw) int32
"}}, text placement:top, origin:{150.0, 25.5}, vertical padding:0}
local ietf_ipspace_system_interface
set ietf_ipspace_system_interface to assemble ( graphics -2 through -1 ) table shape {2, 1}
connect ietf_ipspace_system to ietf_ipspace_system_interface with properties {tail type: "FilledDiamond", head type: "None"} 
make new shape at end of graphics with properties {autosizing: full, size: {187.500000, 14.000000}, text: {{alignment: center, font: "Helvetica-Bold", text: "choice "}, {alignment: center, color: {0.113725, 0.352941, 0.670588}, font: "Helvetica-Bold", text: "interface-type "}}, text placement: top, origin: {150.000000, 11.500000}, vertical padding: 0}
local ietf_ipspace_system_interface_interface_type
set ietf_ipspace_system_interface_interface_type to assemble ( graphics -1 through -1 ) table shape {1, 1}
connect ietf_ipspace_system_interface to ietf_ipspace_system_interface_interface_type with properties {tail type: "FilledDiamond", head type: "None"} 
make new shape at end of graphics with properties {autosizing: full, size: {187.500000, 14.000000}, text: {{alignment: center, font: "Helvetica-Bold", text: "case "}, {alignment: center, color: {0.113725, 0.352941, 0.670588}, font: "Helvetica-Bold", text: "FastEthernet "}}, text placement: top, origin: {150.000000, 11.500000}, vertical padding: 0}
make new shape at end of graphics with properties {autosizing:full, size:{187.5, 28.0}, text:{{font: "Helvetica-Oblique", color:  {0.129412, 0.501961, 0.254902}, text: "FastEthernet? (rw) empty
"}}, text placement:top, origin:{150.0, 25.5}, vertical padding:0}
local ietf_ipspace_system_interface_interface_type_FastEthernet_case
set ietf_ipspace_system_interface_interface_type_FastEthernet_case to assemble ( graphics -2 through -1 ) table shape {2, 1}
connect ietf_ipspace_system_interface_interface_type to ietf_ipspace_system_interface_interface_type_FastEthernet_case with properties {tail type: "FilledDiamond", head type: "None"} 
make new shape at end of graphics with properties {autosizing: full, size: {187.500000, 14.000000}, text: {{alignment: center, font: "Helvetica-Bold", text: "case "}, {alignment: center, color: {0.113725, 0.352941, 0.670588}, font: "Helvetica-Bold", text: "GigEthernet "}}, text placement: top, origin: {150.000000, 11.500000}, vertical padding: 0}
make new shape at end of graphics with properties {autosizing:full, size:{187.5, 28.0}, text:{{font: "Helvetica-Oblique", color:  {0.129412, 0.501961, 0.254902}, text: "GigEthernet? (rw) empty
"}}, text placement:top, origin:{150.0, 25.5}, vertical padding:0}
local ietf_ipspace_system_interface_interface_type_GigEthernet_case
set ietf_ipspace_system_interface_interface_type_GigEthernet_case to assemble ( graphics -2 through -1 ) table shape {2, 1}
connect ietf_ipspace_system_interface_interface_type to ietf_ipspace_system_interface_interface_type_GigEthernet_case with properties {tail type: "FilledDiamond", head type: "None"} 

    layout
    end tell
end tell
