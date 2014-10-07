class Game {
    var honorPool = 60
    var players: [Int] = [0, 0]
    let SCORE = "score"
    
    func incrementScore(playerNumber: Int) {
        var index = playerNumber - 1
        if honorPool > 0 {
            honorPool--
        }
        players[index]++
    }
    
    func decrementScore(playerNumber: Int) {
        var index = playerNumber - 1
        if players[index] > 0 {
            if (players[0] + players[1]) <= 60 {
                honorPool++
            }
            players[index]--
        }
    }
    
    func player(playerNumber: Int) -> Dictionary<String, Int> {
        var score = players[playerNumber - 1]
        return [SCORE: score]
    }
}
