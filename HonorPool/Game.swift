public class Game {
    public var honorPool = 60
    public var players: [Player] = [Player(name: "Player 1"), Player(name: "Player 2")]
    let SCORE = "score"
    
    public init () {}

    public func incrementScore(#playerNumber: Int) {
        if honorPool > 0 {
            honorPool--
        }
        getPlayer(playerNumber).incrementScore()
    }
    
    public func decrementScore(#playerNumber: Int) {
        var player = getPlayer(playerNumber)
        if player.getScore() > 0 {
            if (players[0].getScore() + players[1].getScore()) <= 60 {
                honorPool++
            }
            player.decrementScore()
        }
    }

    public func getScore(#playerNumber: Int) -> Int {
        return getPlayer(playerNumber).getScore()
    }
    
    public func setHonor(#playerNumber: Int, honor: Int) {
        getPlayer(playerNumber).setHonor(honor)
    }
    
    public func getHonor(#playerNumber: Int) -> Int {
        var player = getPlayer(playerNumber)
        return player.getHonor() + player.getScore()
    }
    
    public func getPlayer(playerNumber: Int) -> Player {
        return players[playerNumber - 1]
    }
    
    public func getPlayerName(#playerNumber: Int) -> String {
        return getPlayer(playerNumber).getName()
    }
    
    public func setPlayerName(#playerNumber: Int, name: String) {
        getPlayer(playerNumber).setName(name)
    }
}
