class Game {
    var honorPool = 60
    var players: [Player] = [Player(), Player()]
    let SCORE = "score"
    
    func incrementScore(#playerNumber: Int) {
        var index = playerNumber - 1
        if honorPool > 0 {
            honorPool--
        }
        players[index].incrementScore()
    }
    
    func decrementScore(#playerNumber: Int) {
        var index = playerNumber - 1
        if players[index].getScore() > 0 {
            if (players[0].getScore() + players[1].getScore()) <= 60 {
                honorPool++
            }
            players[index].decrementScore()
        }
    }

    func getScore(#playerNumber: Int) -> Int {
        var playerIndex = playerNumber - 1
        return players[playerIndex].getScore()
    }
}
