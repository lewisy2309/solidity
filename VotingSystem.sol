// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping pour stocker les candidats avec l'identifiant du candidat comme clé et la struct Candidate comme valeur
    mapping(uint => Candidate) public candidates;

    // Tableau d'identifiants de candidats pour faciliter l'itération
    uint[] public candidateIds;

    // Mapping des électeurs avec l'adresse de l'électeur comme clé et une valeur booléenne indiquant si l'électeur a voté
    mapping(address => bool) public voters;

    // Adresse du propriétaire du contrat
    address public owner;

    // Constructeur du contrat pour initialiser le propriétaire
    constructor() {
        owner = msg.sender; // L'adresse de la personne qui déploie le contrat est définie comme propriétaire
    }

    function addCandidate(uint _id, string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidates");
        require(candidates[_id].id == 0, "Candidate with this ID already exists");
        candidates[_id] = Candidate(_id, _name, 0);
        candidateIds.push(_id);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted"); // Vérifier que l'électeur n'a pas déjà voté
        require(candidates[_candidateId].id != 0, "Candidate does not exist"); // Vérifier que le candidat existe
        candidates[_candidateId].voteCount++; 
        voters[msg.sender] = true; 
    }

    function getAllCandidates() public view returns (Candidate[] memory) {
    Candidate[] memory allCandidates = new Candidate[](candidateIds.length);

    for (uint i = 0; i < candidateIds.length; i++) {
        uint candidateId = candidateIds[i];
        allCandidates[i] = candidates[candidateId];
    }

    return allCandidates;
    }
}
