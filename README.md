---
title: '$EDI ERC-20 Staking Pool and Network Rewards Protocol'
---

ERC-20 Staking Pool
===

## Table of Contents

[TOC]



### Basic Functionalities

The contract offers three basic functionalities. 

1.  $EDI token owner can deposit and withdraw from the contract
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