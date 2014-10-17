import Swiftest

class IntegrationSpec : SwiftestSuite {
    let spec = describe("Integration tests") {
        
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
        }
    }
}
