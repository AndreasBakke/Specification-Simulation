
?
Command: %s
1870*	planAhead2?
nread_checkpoint -auto_incremental -incremental /home/andreasb/Lab2/Lab2.srcs/utils_1/imports/synth_1/mux_8.dcp2default:defaultZ12-2866h px? 
?
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2S
?/home/andreasb/Lab2/Lab2.srcs/utils_1/imports/synth_1/mux_8.dcp2default:defaultZ12-5825h px? 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px? 
?
Command: %s
53*	vivadotcl2P
<synth_design -top priority_encoder_4_2 -part xc7k70tfbv676-12default:defaultZ4-113h px? 
:
Starting synth_design
149*	vivadotclZ4-321h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7k70t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7k70t2default:defaultZ17-349h px? 
?
csynth_design options have changed between reference and incremental; A full resynthesis will be run632*	vivadotclZ4-1810h px? 
?
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
42default:defaultZ8-7079h px? 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px? 
`
#Helper process launched with PID %s4824*oasys2
462712default:defaultZ8-7075h px? 
?
%s*synth2?
?Starting Synthesize : Time (s): cpu = 00:00:02 ; elapsed = 00:00:03 . Memory (MB): peak = 2627.160 ; gain = 0.000 ; free physical = 2611 ; free virtual = 10874
2default:defaulth px? 
?
synthesizing module '%s'638*oasys2(
priority_encoder_4_22default:default2Z
D/home/andreasb/Lab2/Lab2.srcs/sources_1/new/priority_encoder_4_2.vhd2default:default2
542default:default8@Z8-638h px? 
?
#case item %s will never be executed153*oasys2
4'b1xxx2default:default2Z
D/home/andreasb/Lab2/Lab2.srcs/sources_1/new/priority_encoder_4_2.vhd2default:default2
582default:default8@Z8-153h px? 
?
#case item %s will never be executed153*oasys2
4'b01xx2default:default2Z
D/home/andreasb/Lab2/Lab2.srcs/sources_1/new/priority_encoder_4_2.vhd2default:default2
582default:default8@Z8-153h px? 
?
#case item %s will never be executed153*oasys2
4'b001x2default:default2Z
D/home/andreasb/Lab2/Lab2.srcs/sources_1/new/priority_encoder_4_2.vhd2default:default2
582default:default8@Z8-153h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2(
priority_encoder_4_22default:default2
02default:default2
12default:default2Z
D/home/andreasb/Lab2/Lab2.srcs/sources_1/new/priority_encoder_4_2.vhd2default:default2
542default:default8@Z8-256h px? 
?
+design %s has port %s driven by constant %s3447*oasys20
priority_encoder_4_2_behav_22default:default2
o[1]2default:default2
02default:defaultZ8-3917h px? 
?
+design %s has port %s driven by constant %s3447*oasys20
priority_encoder_4_2_behav_22default:default2
o[0]2default:default2
02default:defaultZ8-3917h px? 
?
%s*synth2?
?Finished Synthesize : Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 2627.160 ; gain = 0.000 ; free physical = 3650 ; free virtual = 11913
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Constraint Validation : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 2627.160 ; gain = 0.000 ; free physical = 3711 ; free virtual = 11973
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Loading part: xc7k70tfbv676-1
2default:defaulth p
x
? 
V
Loading part %s157*device2#
xc7k70tfbv676-12default:defaultZ21-403h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Loading Part and Timing Information : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3709 ; free virtual = 11971
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
I
%s
*synth21
Start Preparing Guide Design
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Doing Graph Differ : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3707 ; free virtual = 11971
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Preparing Guide Design : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3707 ; free virtual = 11971
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3701 ; free virtual = 11964
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
U
%s
*synth2=
)

Incremental Synthesis Report Summary:

2default:defaulth p
x
? 
N
%s
*synth26
"1. Incremental synthesis run: no

2default:defaulth p
x
? 
?
%s
*synth2?
x   Reason for not running incremental synthesis : synth_design options have changed between reference and incremental


2default:defaulth p
x
? 
?
?Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}4868*oasysZ8-7130h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 1     
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2k
WPart Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB18 80 RAMB36 40)
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px? 
?
+design %s has port %s driven by constant %s3447*oasys2(
priority_encoder_4_22default:default2
o[1]2default:default2
02default:defaultZ8-3917h px? 
?
+design %s has port %s driven by constant %s3447*oasys2(
priority_encoder_4_22default:default2
o[0]2default:default2
02default:defaultZ8-3917h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:06 ; elapsed = 00:00:07 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3421 ; free virtual = 11687
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Timing Optimization : Time (s): cpu = 00:00:07 ; elapsed = 00:00:07 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3421 ; free virtual = 11687
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Technology Mapping : Time (s): cpu = 00:00:07 ; elapsed = 00:00:07 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3418 ; free virtual = 11684
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished IO Insertion : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3419 ; free virtual = 11685
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Instances : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3419 ; free virtual = 11685
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3419 ; free virtual = 11685
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Ports : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3419 ; free virtual = 11685
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3419 ; free virtual = 11685
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Nets : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3419 ; free virtual = 11685
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px? 
B
%s*synth2*
+------+-----+------+
2default:defaulth px? 
B
%s*synth2*
|      |Cell |Count |
2default:defaulth px? 
B
%s*synth2*
+------+-----+------+
2default:defaulth px? 
B
%s*synth2*
|1     |LUT4 |     1|
2default:defaulth px? 
B
%s*synth2*
|2     |IBUF |     4|
2default:defaulth px? 
B
%s*synth2*
|3     |OBUF |     3|
2default:defaulth px? 
B
%s*synth2*
+------+-----+------+
2default:defaulth px? 
E
%s
*synth2-

Report Instance Areas: 
2default:defaulth p
x
? 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
? 
N
%s
*synth26
"|      |Instance |Module |Cells |
2default:defaulth p
x
? 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
? 
N
%s
*synth26
"|1     |top      |       |     8|
2default:defaulth p
x
? 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Writing Synthesis Report : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3419 ; free virtual = 11685
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 8 warnings.
2default:defaulth p
x
? 
?
%s
*synth2?
?Synthesis Optimization Runtime : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.164 ; gain = 8.004 ; free physical = 3430 ; free virtual = 11696
2default:defaulth p
x
? 
?
%s
*synth2?
?Synthesis Optimization Complete : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 2635.172 ; gain = 8.004 ; free physical = 3430 ; free virtual = 11696
2default:defaulth p
x
? 
B
 Translating synthesized netlist
350*projectZ1-571h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2635.1722default:default2
0.0002default:default2
35152default:default2
117812default:defaultZ17-722h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2635.1722default:default2
0.0002default:default2
34362default:default2
117032default:defaultZ17-722h px? 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px? 
g
$Synth Design complete, checksum: %s
562*	vivadotcl2
d135f9962default:defaultZ4-1430h px? 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
162default:default2
82default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
synth_design: 2default:default2
00:00:132default:default2
00:00:102default:default2
2635.1722default:default2
8.0122default:default2
36432default:default2
119112default:defaultZ17-722h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2R
>/home/andreasb/Lab2/Lab2.runs/synth_1/priority_encoder_4_2.dcp2default:defaultZ17-1381h px? 
?
%s4*runtcl2?
~Executing : report_utilization -file priority_encoder_4_2_utilization_synth.rpt -pb priority_encoder_4_2_utilization_synth.pb
2default:defaulth px? 
?
Exiting %s at %s...
206*common2
Vivado2default:default2,
Mon Oct 10 13:00:32 20222default:defaultZ17-206h px? 


End Record