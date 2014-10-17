import Swiftest

class PlayerSpec: SwiftestSuite {
    let spec = describe("Player") {
        it("defaults to score 0") {
            expect(Player().getScore()).to(.Equal(0))
        }
        
        it("sets the score of the player") {
            let player = Player()
            player.setScore(50)
            expect(player.getScore()).to(.Equal(50))
            
            player.setScore(100)
            expect(player.getScore()).to(.Equal(100))
        }
        
        it("increments the player's score") {
            let player = Player()
            expect(player.getScore()).to(.Equal(0))

            player.incrementScore()
            expect(player.getScore()).to(.Equal(1))
        }
        
        it("decrements the player's score") {
            let player = Player()
            player.setScore(1)
            expect(player.getScore()).to(.Equal(1))
            
            player.decrementScore()
            expect(player.getScore()).to(.Equal(0))
        }
    }
}