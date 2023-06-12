// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.8; //version de compilateur

struct Projets{
    string title;
    string description;
    address owner;
}
struct donation {
    address donneur;
    uint256 prix;
}
contract Projet{


    uint256 public projectId =0;
    mapping(uint256 => Projets) public projects;
    mapping(address => mapping(uint256 => donation)) public donations; //  cette ligne permet de stocker les dons effectués par chaque adresse pour chaque projet, 

    event ProjectCreated(uint256 projectId, string title, string description, address owner);
    event DonationMade(uint256 projectId, address donor, uint256 amount);

    function createProject(string memory _title, string memory _description) external {
        projectId++;
        projects[projectId] = Projets(_title, _description, msg.sender);
        emit ProjectCreated(projectId, _title, _description, msg.sender);
    }

    function donateToProject(uint256 _projectId) external payable {
        require(_projectId > 0 && _projectId <= projectId, "Invalid project ID");
        require(msg.value > 0, "Donation amount must be greater than 0");

        address projectOwner = projects[_projectId].owner;
        require(projectOwner != address(0), "Project does not exist");

        donation storage Donation = donations[msg.sender][_projectId];
        require(Donation.prix == 0, "Donor can only donate once to a project");

        Donation.donneur = msg.sender;
        Donation.prix = msg.value;

        payable(projectOwner).transfer(msg.value);
        emit DonationMade(_projectId, msg.sender, msg.value);
    }

   
}   