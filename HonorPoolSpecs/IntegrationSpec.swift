import Swiftest

class IntegrationSpec : SwiftestSuite {
    let spec = describe("IntegrationSpec") {
        
        it("increments player scores and decrements honor pool") {
            let game: Game = Game()
            
            expect(game.honorPool).to(.Equal(60))
            
            game.incrementScore(1)
            expect(game.player(1)[game.SCORE]).to(.Equal(1))
            expect(game.player(2)[game.SCORE]).to(.Equal(0))
            expect(game.honorPool).to(.Equal(59))
            
            game.incrementScore(2)
            expect(game.player(1)[game.SCORE]).to(.Equal(1))
            expect(game.player(2)[game.SCORE]).to(.Equal(1))
            expect(game.honorPool).to(.Equal(58))
        }
        
        it("decrements player scores and decrements the honor pool") {
            let game: Game = Game()
            
            expect(game.honorPool).to(.Equal(60))
            
            game.incrementScore(1)
            game.decrementScore(1)
            expect(game.player(1)[game.SCORE]).to(.Equal(0))
            expect(game.honorPool).to(.Equal(60))
            expect(game.player(2)[game.SCORE]).to(.Equal(0))
        }
        
        it("doesn't lower the player score to the negatives") {
            let game: Game = Game()
            
            expect(game.honorPool).to(.Equal(60))
            
            game.decrementScore(1)
            expect(game.honorPool).to(.Equal(60))
            expect(game.player(1)[game.SCORE]).to(.Equal(0))
            expect(game.player(2)[game.SCORE]).to(.Equal(0))
        }
        
        it("continuously adjusts honor pool and player scores as appropriate") {
            let game: Game = Game()
            
            for var i = 0; i < 25; i++ {
                game.incrementScore(1)
            }
            for var i = 0; i < 45; i++ {
                game.incrementScore(2)
            }
            
            expect(game.honorPool).to(.Equal(0))
            expect(game.player(1)[game.SCORE]).to(.Equal(25))
            expect(game.player(2)[game.SCORE]).to(.Equal(45))
            
            for var i = 0; i < 10; i++ {
                game.decrementScore(1)
            }
            expect(game.honorPool).to(.Equal(0))
            expect(game.player(1)[game.SCORE]).to(.Equal(15))
            expect(game.player(2)[game.SCORE]).to(.Equal(45))
            
            game.decrementScore(1)
            expect(game.honorPool).to(.Equal(1))
            expect(game.player(1)[game.SCORE]).to(.Equal(14))
            expect(game.player(2)[game.SCORE]).to(.Equal(45))
        }
    }
}
