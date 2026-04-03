// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title GrantsManager
 * @dev Manages milestone-based funding for ecosystem projects.
 */
contract GrantsManager is Ownable, ReentrancyGuard {
    struct Grant {
        address recipient;
        uint256 totalBudget;
        uint256 amountReleased;
        uint8 totalMilestones;
        uint8 completedMilestones;
        bool active;
    }

    mapping(uint256 => Grant) public grants;
    uint256 public nextGrantId;

    event GrantCreated(uint256 indexed id, address indexed recipient, uint256 budget);
    event MilestoneReleased(uint256 indexed id, uint8 milestoneIndex, uint256 amount);

    constructor() Ownable(msg.sender) {}

    /**
     * @dev Council creates a grant for a specific builder.
     */
    function createGrant(address _recipient, uint256 _budget, uint8 _milestones) external onlyOwner {
        grants[nextGrantId] = Grant({
            recipient: _recipient,
            totalBudget: _budget,
            amountReleased: 0,
            totalMilestones: _milestones,
            completedMilestones: 0,
            active: true
        });

        emit GrantCreated(nextGrantId++, _recipient, _budget);
    }

    /**
     * @dev Council releases funds for the next completed milestone.
     */
    function releaseMilestone(uint256 _grantId) external onlyOwner nonReentrant {
        Grant storage g = grants[_grantId];
        require(g.active, "Grant inactive");
        require(g.completedMilestones < g.totalMilestones, "All milestones paid");

        uint256 payoutPerMilestone = g.totalBudget / g.totalMilestones;
        g.completedMilestones++;
        g.amountReleased += payoutPerMilestone;

        payable(g.recipient).transfer(payoutPerMilestone);
        emit MilestoneReleased(_grantId, g.completedMilestones, payoutPerMilestone);
    }

    receive() external payable {}
}
