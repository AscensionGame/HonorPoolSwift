public class Player {
    private var score: Int
    private var honor: Int
    private var name: String
    
    public init(name: String = "") {
        self.score = 0
        self.honor = 0
        self.name = name
    }
    
    public func getScore() -> Int {
        return self.score
    }
    
    public func getHonor() -> Int {
        return self.honor
    }
    
    public func setScore(newScore: Int) {
        score = newScore
    }
    
    public func setHonor(newHonor: Int) {
        honor = newHonor
    }
    
    public func incrementScore() {
        score++
    }
    
    public func decrementScore() {
        score--
    }
    
    public func setName(newName: String) {
        name = newName
    }
    
    public func getName() -> String {
        return name
    }
}