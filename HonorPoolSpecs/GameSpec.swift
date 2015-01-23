import SwiftestXC
import HonorPool

class GameSpec : SwiftestSpec {
    let spec = describe("GameSpec") {
        
        it("starts with 60 honor pool") {
            let game: Game = Game()
            expect(game.honorPool).to(.Equal(60))
        }
        
        it("increments a player's score") {
            let game: Game = Game()
            game.incrementScore(playerNumber: 1)
            expect(game.getScore(playerNumber: 1)).to(.Equal(1))
        }
        
        it("increments scores for players independently") {
            let game: Game = Game()
            game.incrementScore(playerNumber: 1)
            
            expect(game.getScore(playerNumber: 1)).to(.Equal(1))
            expect(game.getScore(playerNumber: 2)).to(.Equal(0))
        }
        
        it("decrements the honor pool when incrementing a player's score") {
            let game: Game = Game()
            game.incrementScore(playerNumber: 1)
            expect(game.honorPool).to(.Equal(59))
        }
        
        it("decrements a player's score") {
            let game: Game = Game()
            game.incrementScore(playerNumber: 1)
            game.decrementScore(playerNumber: 1)
            expect(game.getScore(playerNumber: 1)).to(.Equal(0))
        }
        
        it("decrements scores for players independently") {
            let game: Game = Game()
            game.incrementScore(playerNumber: 1)
            game.incrementScore(playerNumber: 2)
            game.decrementScore(playerNumber: 2)
            
            expect(game.getScore(playerNumber: 1)).to(.Equal(1))
            expect(game.getScore(playerNumber: 2)).to(.Equal(0))
        }
        
        it("doesn't increment the honor pool when attempting to decrement a player's score past 0") {
            let game: Game = Game()
            expect(game.honorPool).to(.Equal(60))
            game.decrementScore(playerNumber: 1)
            expect(game.honorPool).to(.Equal(60))
        }
        
        it("doesn't decrement a player's score past 0") {
            let game: Game = Game()
            game.decrementScore(playerNumber: 1)
            expect(game.getScore(playerNumber: 1)).to(.Equal(0))
        }
        
        it("doesn't decrement the honor pool when player's score is added and the honor pool is 0") {
            let game: Game = Game()
            
            for var i = 0; i < 70; i++ {
                game.incrementScore(playerNumber: 1)
            }
            expect(game.honorPool).to(.Equal(0))
        }
        
        it("doesn't increment the honor pool when decrementing a player's score when players have more points than max honor pool size") {
            let game: Game = Game()
            
            for var i = 0; i < 70; i++ {
                game.incrementScore(playerNumber: 1)
            }
            
            for var i = 0; i < 10; i++ {
                game.decrementScore(playerNumber: 1)
            }
            expect(game.honorPool).to(.Equal(0))
        }
        
        it("increments the honor pool when player's score combined is equals to max honor pool size") {
            let game: Game = Game()
            
            for var i = 0; i < 60; i++ {
                game.incrementScore(playerNumber: 1)
            }
            
            game.decrementScore(playerNumber: 1)
            expect(game.honorPool).to(.Equal(1))
        }
        
        it("gives honor to a player") {
            let game: Game = Game()
            
            game.setHonor(playerNumber: 1, honor: 15)
            
            expect(game.getHonor(playerNumber: 1)).to(.Equal(15))
        }
        
        describe("#getHonor") {
            it("returns the total of a player’s honor and points") {
                let game: Game = Game()
                
                game.setHonor(playerNumber: 1, honor: 15)
                game.incrementScore(playerNumber: 1)
                
                expect(game.getHonor(playerNumber: 1)).to(.Equal(16))
            }
        }
        
        describe("setPlayerName") {
            it("sets the player's name") {
                let game: Game = Game()
                
                game.setPlayerName(playerNumber: 1, name: "Taka")
                
                expect(game.getPlayer(1).getName()).to(.Equal("Taka"))
            }
        }
        
        it("names players ”Player #“ by default") {
            let game: Game = Game()
            
            expect(game.getPlayerName(playerNumber: 1)).to(.Equal("Player 1"))
            expect(game.getPlayerName(playerNumber: 2)).to(.Equal("Player 2"))
        }
    }
}
