import SwiftestXC
import HonorPool

class IntegrationSpec : SwiftestSpec {
    let spec = describe("Integration tests") {
        
        func adjustScore(game: Game, #playerNumber: Int, #score: Int) {
            if score > 0 {
                for var i = 0; i < score; i++ {
                    game.incrementScore(playerNumber: playerNumber)
                }
            } else {
                for var i = 0; i > score; i-- {
                    game.decrementScore(playerNumber: playerNumber)
                }
            }
        }
        
        describe("Scoring points") {
        
            it("increments player scores and decrements honor pool") {
                let game = Game()
                
                expect(game.honorPool).to(.Equal(60))
                
                game.incrementScore(playerNumber: 1)
                expect(game.getScore(playerNumber: 1)).to(.Equal(1))
                expect(game.getScore(playerNumber: 2)).to(.Equal(0))
                expect(game.honorPool).to(.Equal(59))
                
                game.incrementScore(playerNumber: 2)
                expect(game.getScore(playerNumber: 1)).to(.Equal(1))
                expect(game.getScore(playerNumber: 2)).to(.Equal(1))
                expect(game.honorPool).to(.Equal(58))
            }
            
            it("decrements player scores and decrements the honor pool") {
                let game = Game()
                
                expect(game.honorPool).to(.Equal(60))
                
                game.incrementScore(playerNumber: 1)
                game.decrementScore(playerNumber: 1)
                expect(game.getScore(playerNumber: 1)).to(.Equal(0))
                expect(game.honorPool).to(.Equal(60))
                expect(game.getScore(playerNumber: 2)).to(.Equal(0))
            }
            
            it("doesn't lower the player score to the negatives") {
                let game: Game = Game()
                
                expect(game.honorPool).to(.Equal(60))
                
                game.decrementScore(playerNumber: 1)
                expect(game.honorPool).to(.Equal(60))
                expect(game.getScore(playerNumber: 1)).to(.Equal(0))
                expect(game.getScore(playerNumber: 2)).to(.Equal(0))
            }
            
            it("continuously adjusts honor pool and player scores as appropriate") {
                let game = Game()
                
                for var i = 0; i < 25; i++ {
                    game.incrementScore(playerNumber: 1)
                }
                for var i = 0; i < 45; i++ {
                    game.incrementScore(playerNumber: 2)
                }
                
                expect(game.honorPool).to(.Equal(0))
                expect(game.getScore(playerNumber: 1)).to(.Equal(25))
                expect(game.getScore(playerNumber: 2)).to(.Equal(45))
                
                for var i = 0; i < 10; i++ {
                    game.decrementScore(playerNumber: 1)
                }
                expect(game.honorPool).to(.Equal(0))
                expect(game.getScore(playerNumber: 1)).to(.Equal(15))
                expect(game.getScore(playerNumber: 2)).to(.Equal(45))
                
                game.decrementScore(playerNumber: 1)
                expect(game.honorPool).to(.Equal(1))
                expect(game.getScore(playerNumber: 1)).to(.Equal(14))
                expect(game.getScore(playerNumber: 2)).to(.Equal(45))
            }
        }
        
        describe("Take honor from pool") {

            it("adds score to player and removes point from honor pool") {
                let game = Game()
                expect(game.honorPool).to(.Equal(60))
                
                game.incrementScore(playerNumber: 1)
                expect(game.getScore(playerNumber: 1)).to(.Equal(1))
                expect(game.honorPool).to(.Equal(59))
                expect(game.getScore(playerNumber: 2)).to(.Equal(0))

                game.incrementScore(playerNumber: 2)
                expect(game.getScore(playerNumber: 1)).to(.Equal(1))
                expect(game.honorPool).to(.Equal(58))
                expect(game.getScore(playerNumber: 2)).to(.Equal(1))
            }
            
            it("adds points back to pool when subtracted from player") {
                let game = Game()
                expect(game.honorPool).to(.Equal(60))
                game.incrementScore(playerNumber: 1)
                game.decrementScore(playerNumber: 1)
                expect(game.getScore(playerNumber: 1)).to(.Equal(0))
                expect(game.honorPool).to(.Equal(60))
                expect(game.getScore(playerNumber: 2)).to(.Equal(0))
            }
            
            it("caps honor pool at 60 points") {
                let game = Game()
                expect(game.honorPool).to(.Equal(60))
                game.decrementScore(playerNumber: 1)
                expect(game.honorPool).to(.Equal(60))
                expect(game.getScore(playerNumber: 1)).to(.Equal(0))
                expect(game.getScore(playerNumber: 2)).to(.Equal(0))
            }

            it("doesn't subtract more than 60 points from honor pool and doesn't add back to honor pool if outstanding points exceeds honor pool capacity") {
                let game = Game()
                adjustScore(game, playerNumber: 1, score: 25)
                adjustScore(game, playerNumber: 2, score: 45)
                
                expect(game.honorPool).to(.Equal(0))
                expect(game.getScore(playerNumber: 1)).to(.Equal(25))
                expect(game.getScore(playerNumber: 2)).to(.Equal(45))
                
                adjustScore(game, playerNumber: 1, score: -10)
                
                expect(game.honorPool).to(.Equal(0))
                expect(game.getScore(playerNumber: 1)).to(.Equal(15))
                expect(game.getScore(playerNumber: 2)).to(.Equal(45))
                
                game.decrementScore(playerNumber: 1)
                
                expect(game.honorPool).to(.Equal(1))
                expect(game.getScore(playerNumber: 1)).to(.Equal(14))
                expect(game.getScore(playerNumber: 2)).to(.Equal(45))
            }
        }
        
        describe("Calculating final score") {
            it("calculates score for a player with honor and points") {
                let game = Game()
                
                adjustScore(game, playerNumber: 1, score: 25)
                adjustScore(game, playerNumber: 2, score: 45)
                
                game.setHonor(playerNumber: 1, honor: 15)
                game.setHonor(playerNumber: 2, honor: 25)
                
                expect(game.honorPool).to(.Equal(0))
                expect(game.getScore(playerNumber: 1)).to(.Equal(25))
                expect(game.getScore(playerNumber: 2)).to(.Equal(45))
                expect(game.getHonor(playerNumber: 1)).to(.Equal(40))
                expect(game.getHonor(playerNumber: 2)).to(.Equal(70))
            }
        }
        
        describe("New game") {
            it("starts a new game") {
                let game = Game()
                
                expect(game.players.count).to(.Equal(2))
                expect(game.honorPool).to(.Equal(60))
                expect(game.getScore(playerNumber: 1)).to(.Equal(0))
                expect(game.getScore(playerNumber: 2)).to(.Equal(0))
                expect(game.getPlayerName(playerNumber: 1)).to(.Equal("Player 1"))
                expect(game.getPlayerName(playerNumber:2)).to(.Equal("Player 2"))
            }
        }
        
        describe("Changing player names") {
            it("changes player names") {
                let game = Game()
                
                game.setPlayerName(playerNumber: 1, name: "Phil")
                game.setPlayerName(playerNumber: 2, name: "Eric")
                expect(game.getPlayerName(playerNumber: 1)).to(.Equal("Phil"))
                expect(game.getPlayerName(playerNumber: 2)).to(.Equal("Eric"))
            }
        }
    }
}
