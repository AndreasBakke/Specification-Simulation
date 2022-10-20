#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Fri Sep 30 10:49:39 CEST 2022
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim Testbench_behav -key {Behavioral:sim_1:Functional:Testbench} -tclbatch Testbench.tcl -log simulate.log"
xsim Testbench_behav -key {Behavioral:sim_1:Functional:Testbench} -tclbatch Testbench.tcl -log simulate.log
