script {
    use crowdfunding::Crowdfunding;

    fun main(creator: &signer, goal: u64, deadline: u64) {
        Crowdfunding::create_project(creator, goal, deadline);
    }
}
