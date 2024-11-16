module crowdfunding::Crowdfunding {
    use std::signer;
    use std::vector;

    struct Contribution has copy, drop, store {
        contributor: address,
        amount: u64,
    }

    struct Project has key {
        creator: address,
        goal: u64,
        deadline: u64,
        contributions: vector<Contribution>,
        total_raised: u64,
    }

    public fun create_project(creator: &signer, goal: u64, deadline: u64) {
        // Validate goal
        assert!(goal > 0, 1); // Error code 1: Invalid goal

        // Validate deadline
        let current_time = aptos_framework::timestamp::now_seconds();
        assert!(deadline > current_time, 2); // Error code 2: Invalid deadline

        // Get creator address
        let creator_address = signer::address_of(creator);

        // Ensure no existing project is under this address
        assert!(
            !exists<Project>(creator_address),
            3 // Error code 3: Project already exists
        );

        // Initialize and store the project
        let new_project = Project {
            creator: creator_address,
            goal,
            deadline,
            contributions: vector::empty<Contribution>(),
            total_raised: 0,
        };
        move_to(creator, new_project);
    }
} // Ensure this closing brace matches the opening 'module' definition
