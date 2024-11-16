module test::CrowdfundingTest {
    use std::signer;
    use move_unit_test::testing;
    use crowdfunding::Crowdfunding;

    #[test]
    public fun test_create_project() {
        // Set up accounts and environment
        let creator = testing::create_signer_account();
        let goal = 1000; // Set a funding goal
        let deadline = aptos_framework::timestamp::now_seconds() + 3600; // 1 hour from now

        // Call the function
        Crowdfunding::create_project(&creator, goal, deadline);

        // Assert the resource was created
        let project = borrow_global<crowdfunding::Project>(signer::address_of(&creator));
        assert!(project.goal == goal, "Goal mismatch");
        assert!(project.deadline == deadline, "Deadline mismatch");
    }
}
