import Swiftest

class GameSpec : SwiftestSuite {
    let spec = describe("GameSpec") {
        
        it("starts with 60 honor pool") {
            let game: Game = Game()
            expect(game.honorPool).to(.Equal(60))
        }
        
        it("increments a player's score") {
            let game: Game = Game()
            game.incrementScore(1)
            expect(game.player(1)[game.SCORE]).to(.Equal(1))
        }
        
        it("increments scores for players independently") {
            let game: Game = Game()
            game.incrementScore(1)
            
            var playerOne = game.player(1)
            expect(playerOne[game.SCORE]).to(.Equal(1))
            
            var playerTwo = game.player(2)
            expect(playerTwo[game.SCORE]).to(.Equal(0))
        }
        
        it("decrements the honor pool when incrementing a player's score") {
            let game: Game = Game()
            game.incrementScore(1)
            expect(game.honorPool).to(.Equal(59))
        }
        
        it("decrements a player's score") {
            let game: Game = Game()
            game.incrementScore(1)
            game.decrementScore(1)
            expect(game.player(1)[game.SCORE]).to(.Equal(0))
        }
        
        it("decrements scores for players independently") {
            let game: Game = Game()
            game.incrementScore(1)
            game.incrementScore(2)
            game.decrementScore(2)
            
            var playerOne = game.player(1)
            expect(playerOne[game.SCORE]).to(.Equal(1))
            
            var playerTwo = game.player(2)
            expect(playerTwo[game.SCORE]).to(.Equal(0))
        }
        
        it("doesn't increment the honor pool when attempting to decrement a player's score past 0") {
            let game: Game = Game()
            expect(game.honorPool).to(.Equal(60))
            game.decrementScore(1)
            expect(game.honorPool).to(.Equal(60))
        }
        
        it("doesn't decrement a player's score past 0") {
            let game: Game = Game()
            game.decrementScore(1)
            expect(game.player(1)[game.SCORE]).to(.Equal(0))
        }
        
        it("doesn't decrement the honor pool when player's score is added and the honor pool is 0") {
            let game: Game = Game()
            
            for var i = 0; i < 70; i++ {
                game.incrementScore(1)
            }
            expect(game.honorPool).to(.Equal(0))
        }
        
        it("doesn't increment the honor pool when decrementing a player's score when players have more points than max honor pool size") {
            let game: Game = Game()
            
            for var i = 0; i < 70; i++ {
                game.incrementScore(1)
            }
            
            for var i = 0; i < 10; i++ {
                game.decrementScore(1)
            }
            expect(game.honorPool).to(.Equal(0))
        }
        
        it("increments the honor pool when player's score combined is equals to max honor pool size") {
            let game: Game = Game()
            
            for var i = 0; i < 60; i++ {
                game.incrementScore(1)
            }
            
            game.decrementScore(1)
            expect(game.honorPool).to(.Equal(1))
        }
        
    }
}
