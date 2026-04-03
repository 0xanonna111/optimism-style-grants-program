# Decentralized Grants Program (Optimism-style)

A professional-grade framework for ecosystem growth and Public Goods funding. This repository allows DAOs to allocate capital to builders based on "Milestones." Instead of a lump-sum payment, funds are locked in escrow and released only when the community or a "Grants Council" verifies that specific project goals have been met.

## Core Features
* **Milestone Escrow:** Protects the treasury by linking payouts to tangible progress.
* **Council Voting:** Specialized logic for a "Grants Council" to approve or reject applications.
* **Retroactive Funding:** Support for "RetroPGF" where projects are rewarded based on past impact rather than future promises.
* **Flat Architecture:** Single-directory layout for the Grant Registry, Milestone Manager, and Payout logic.



## Workflow
1. **Apply:** Builder submits a Grant Proposal with three defined Milestones.
2. **Approve:** The Grants Council votes to fund the project; the total amount is moved to the Escrow contract.
3. **Submit:** Builder completes Milestone 1 and submits proof.
4. **Release:** Council verifies the work and triggers the release of the first 33% of the funds.

## Setup
1. `npm install`
2. Deploy `GrantsManager.sol`.
