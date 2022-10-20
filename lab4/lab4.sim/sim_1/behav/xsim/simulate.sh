#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Mon Oct 17 13:17:09 CEST 2022
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim majority_vote_alu_tb_behav -key {Behavioral:sim_1:Functional:majority_vote_alu_tb} -tclbatch majority_vote_alu_tb.tcl -log simulate.log"
xsim majority_vote_alu_tb_behav -key {Behavioral:sim_1:Functional:majority_vote_alu_tb} -tclbatch majority_vote_alu_tb.tcl -log simulate.log
