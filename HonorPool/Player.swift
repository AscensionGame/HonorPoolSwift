class Player {
    private var score: Int
    
    init() {
        self.score = 0
    }
    
    func getScore() -> Int {
        return self.score
    }
    
    func setScore(new_score: Int) {
        score = new_score
    }
    
    func incrementScore() {
        score++
    }
    
    func decrementScore() {
        score--
    }
}