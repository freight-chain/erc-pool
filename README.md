---
title: '$EDI ERC-20 Staking Pool and Network Rewards Protocol'
---


ERC-20 Staking Pool
===

## Table of Contents

[TOC]

> There are two protocols involved in staking
> 1. The ERC-20 Pooling and Rewards Protocol [Join Pool](/sdo20ZqURiyXL5qQsIO7nw)
> 2. The Adversarial Rewards Protocol [Fight Pool](/C1S2Z85RQyak-f1E3H0eew)
> They are called "Join" and "Fight"

# Main Pool Protocol

### Basic Functionalities

The contract offers three basic functionalities. 

1. $EDI token owner can deposit and withdraw from the contract
2. $EDI withdrawls are a 30-day cooldown, meaning it wont unlock for 30 days. 
3. Migration of Pools: Authority nodes run an adversarial "red" vs. "blue " mode, meaning after every epoch (600,000 blocks) a migration takes place

Stakers themselves are the only ones that can opt-in to migrate their tokens from the current contract to the new one. As Stakers opt-in to new contracts, the migration manager cannot access nor prevent them from withdrawing their tokens.

### Functionality

`approve()` + `stake()` +   `unstake()` + `withdraw()` + `restake()`



### Incident Response Manager

The IRM module can

- Disable staking operations
- Release all stakes
- Update the address of the emergency manager

**Migration manager** that can, in an administrative capacity during the initial period after the launch of the network:

-   Add or remove migration destinations.
    
-   Update the stake change notifier.
    
-   Update the address of the migration manager.

## Administrative Processes

### Migration Pathway

The migration flow allows users to opt-in to migrate their staked tokens to a new staking contract. Alternatively, a user can unstake, wait for the cooldown period to end, withdraw and stake in a new contract, but this would imply that the tokens are not staked during the cooldown period.

The Migration process:

1.  The migration manager may propose (up to `MAX_APPROVED_STAKING_CONTRACTS`) distinct "migration destination" contracts.
    
2.  Users may decide to migrate their staked tokens to any one of these contracts using the `migrateStakedTokens()` function. Note that the destination contracts only need to implement the `IMigratableStakingContract()` and could differ in many aspects relative to the existing IStakingContract specifications.
    
3.  Once requested, the existing contract will call ERC20 approve and the `acceptMigration()` function of the new contract (part of the `IMigratableStakingContract` interface), which will move the stake to the new contract.


### Distributing Rewards

The `distributeRewards()` helper function allows staking on behalf of different users in batch (e.g., like calling acceptMigration() multiple times).

This function is meant to be called by a network operator whenever it needs to distribute staking rewards, which will be distributed as new staked tokens. Similarly to the `acceptMigration()` function

Since `distributeRewards()` and `withdrawReleasedStakes()` are batched operations, their caller should provide enough gas for the entire batch in order to successfully distribute rewards to their pool members.


## Ostracization 

[Reverse Adversarial Ostracization](https://#)
> [](https://)
> 


## Fight (Pool)

##### The Equal Split Method

As the reward for reporting accurately must always be over 100% of the value staked, it follows that a dominant strategy would be to report equally in both pools, yielding an EV of 1 at an absolute minimum at an equal 50/50 split. To counter this, a 5% fee on the game has been introduced making the equal split method a losing strategy at value discrepancies between the pools under


$$ 2.44% $$  
$$ (1/48.78*51.22=1.005002). $$

The fee will be adjusted as necessary if we feel the equal split method has become too worthless or too dominant. What this should mean is that as liquidity increases, the necessity of a fee will be diminished as games trend closer and closer towards a 50/50 split


##### The Greater Good Sacrifice  

A player may find themselves in a position in which they have x amount of $EDI/ether in pool A which currently holds .3 more than pool B. By sacrificing >.3 ether into Pool B, the player both hedges against their initial position, and increases the odds that their larger report is correct. This method is totally encouraged. As are all methods of manipulation. S.o.S requires a player to accurately report which side will have the least value, correctly predicting the sum actions of all including our example player.

### "Equity" Token  
> This is not equity in the sense of ownership in Freight Trust (C) Corporation, this is equity in the sense of tokenized validators, as a mitigation strategy over oligopolistic takeover of the network.
> 

##### Controlling Interest  

Token holders control the contract via a mechanism that allows for voting on the operator of the contract who may start and stop the game and change the fee percent.

### Profits  

###### Profit Pool  

All profits will be accumulated into a pool that can be accessed by the token holders

###### Token Burning  

By burning one’s tokens, one relinquishes their equity in exchange for their share of the profit pool. This reduces transaction costs of periodic dividends, eliminates lock up periods that periodic dividends require, and protects token holders against low liquidity on exchanges.

### Security  

##### No Oracles & Trustless  
 
Without the need for random number generation, we do not have to use an Oracle. While Oracles can be verified after the fact, players can be confident while playing our game that they are protected.


---
###### tags: staking, nodes, protocol, network
2020 Copyright FreightTrust and Clearing Corporation,  
All Rights Owned Respective of their Owners  