import penguin.*
import wollok.game.*
import direcciones.*
import level.*
import level1.*

object levelManager {
	var property currentLevel = level1
	var property carpinchoMode = false

	method configuracionInicial(){
		game.title("PenguiNice")
		currentLevel.generateLevel()
		self.setUpControls()

		game.onCollideDo(penguin, {_object => penguin.completeLevel(_object)})
		game.onCollideDo(penguin, {_object => penguin.pickObject(_object)})
		game.onTick(250, "Update Sequentials", {=> self.updateSequentials()})
	}


	method updateSequentials() = currentLevel.sequentials().forEach({seq => if(seq.value() < 4) {seq.value(seq.value() + 1)} 
		else {seq.value(1)}})
	
	
	method setUpControls(){
		keyboard.left().onPressDo({ penguin.move(left) })
		keyboard.right().onPressDo({ penguin.move(right) })
		keyboard.up().onPressDo({ penguin.move(up) })
		keyboard.down().onPressDo({ penguin.move(down) })
	
		keyboard.r().onPressDo({currentLevel.reset()})
		keyboard.s().onPressDo({self.startOST()})
		keyboard.n().onPressDo({self.skipLevel()})
	}
	method startOST() {
		const soundtrack = game.sound("./assets/audio/thin_ice_OST.mp3")
		soundtrack.initialize()
		soundtrack.play()
		soundtrack.shouldLoop(true)
	}
	method skipLevel() {
		currentLevel = currentLevel.nextLevel()
        currentLevel.reset()
	}
}