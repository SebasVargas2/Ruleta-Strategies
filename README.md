# Roulette Strategy Simulator: Why The House Always Wins

## Overview

This script simulates two popular roulette betting strategies—Martingale and Inverse Labouchère—to demonstrate mathematically and practically why casino games are designed to favor the house in the long run.

## Description

Through automated gameplay simulation, this project analyzes the effectiveness of two well-known betting systems:

- **Martingale Strategy**: Doubles the bet after each loss to recover previous losses plus a small profit
- **Inverse Labouchère Strategy**: A positive progression system where bets increase after wins rather than losses

By running thousands of simulated rounds, the script provides statistical evidence showing how these strategies ultimately fail against the house edge, regardless of short-term wins.

## Features

- Simulate both Martingale and Inverse Labouchère strategies
- Configurable parameters (starting bankroll, bet size)
- Statistical analysis of win/loss patterns
- Visual representation of bankroll progression over time
- Demonstrates the mathematical certainty of the house edge

## Purpose

This educational tool was created to:
- Illustrate the mathematical principles behind casino probability
- Debunk common gambling myths about "guaranteed" betting systems
- Provide concrete evidence that no betting strategy can overcome the house edge
- Help people understand risk management and probability theory

## Key Findings

The simulations consistently demonstrate that:
- Short-term wins are possible but statistically insignificant
- Both strategies eventually lead to bankroll depletion
- The house edge is mathematically insurmountable
- Increasing bet sizes accelerates losses rather than preventing them

## Usage

[+] User panel: ./ruleta.sh

	-m) Betting money
	-t) Techinique
		- Martingala 
		- InverseLabrouchere
	-h) Help

	[+] Use example:  ./ruleta.sh -m 100 -t martingala
	[+] Use example:  ./ruleta.sh -m 100 -t inverseLabrouchere
  
  

