# The Mighty Knights

Download the .zip and open in Godot.
	
## Prototype Game Requirements
	
## General
- The Mighty Knights is an interactive 2D game.
- It uses a tilemap for the ‘board’. 
- It is built in Godot using GDScript.
- It has a beginning and end through different scenes and quests.




## Title Screen
- The title screen has a “Play” and “Quit” buttons.




## Playable Level
	
### Main Menu
- The Mighty Knights has a 2D platformer as the Main Menu with the user can use “WASD” keys or the arrow keys to move. The player movement has animations to go with the given inputted movement.
- When the player goes over the castle sprites, the user will be transported to that game. 
- At the end of the game, the star amount gets updated on the main menu to reflect the progress that the player was able to make. The top score is reflected, so if the user were to score two stars the first time they played, but only one star the second time they played, then two stars are still displayed on the main screen.
- The main screen has the quest status displayed on the top center through a combination of text and icons.
- On the top left of the map, the user can find an ‘end game’ house. If the user were to enter this house, then they are taken to the end screen which has 2 buttons and the credits. 
		
### Goblin Bounce Mini Game
- The player for this game is a goblin. The goblin jumps (flaps) when the user presses the space bar. 
- The score gets updated for every island that the goblin passes through. 
- The Inventory System is used in the game for the score, which then correlates to the stars on the main menu.
- The Combat System is used in the game for the shield 'attack'.
- If the goblin touches any pipes, ‘falls’ off the screen, or ‘jumps’ off the screen, then the game is transitioned to an end-game scene.
- In this scene, the user can click using their mouse either to play the mini-game again, to go back to the main screen, or to quit. 


### Maze Rush
- The objective of this mini-game is for the knight (player) to find and enter the castle before time runs out.
- The player has 30 seconds to find the castle, or they are taken to an end screen. They are also given one star.
- If the user finds the castle in time, then they are brought to a win screen. They are also given three stars.
- The screen is zoomed in so it is harder for the user to find the end. 




### End Credit Screen
- The End-Credit Scene first asks the user if they are sure they want to end the game. In this scene, they have two button options, one being ‘Back to MAIN MENU’ and the other being ‘QUIT’. I also put the credits on this screen through the text ‘Created by: Kylie Wasserman’. 




## Game Systems
		
### Inventory
- Inventory is used in the minigames to get the top score to then display the score in terms of stars on the main menu. 
- The ‘Goblin Bounce’ mini-game can store the star values of one, two, or three. The star values depend on how many pipes the goblin passes in the game before either dying or winning.
- The ‘Maze Rush’ mini-game can store the star values of one and three. If the player finishes the maze in under 30 seconds, then they get three stars, but if the player is unable to finish they they get one star.
- These star values are also used for the Quest System. 




### Quest
- The quest is unlocked when the player first starts the game but has zero stars in both games.
- The quest is in progress once the player gets their first star(s) after playing a game.
- The quest is complete when the player gets 3 stars for both games.
- The reward is given when the quest is complete, which is an icon on the top right of the main menu screen of a crown. 
- The requirement for the quest is to get 3 stars in both games. 
- The quest system is partially implemented now.




### Combat
- The combat system is implemented for the ‘attack’ of a shield. 
- A user can activate the shield by pressing and holding down the ‘1’ key. The user can use the shield if they are not out of energy. The user is using the shield if the mushroom icon is being shown. 
- If the user is pressing down the one key, then if they hit a wall, they are protected. 
- The user still needs to go through the center of the walls, even if it is only partially for their score to increase.
- When the shield is activated a mushroom icon is shown on the goblin body.
- The user can use the shield until they run out of energy, so make sure to use it only when you need it.




	
## Gameplay Loop
The basic gameplay loop is implemented through the use of a title screen, main menu, and mini-games with correlating end screens and win screens. 




## Godot Components
- I use all of the following Godot Components in the game
- Node functions (_input, _ready, _process, _physics_process)
- Signals
- Timer
- Areas, bodies, and collision shapes
- Canvas layers and items




## Game Patterns
	
### Observer
- The observer pattern is represented through Signals.
- I have multiple Signals used throughout the game, for example:
- Buttons using pressed()
- Area2D using bodied_entered(body: Node2D)
- CollisionShape2D using child_entered_tree(node: Node)
		
### Game Loop	
- The game loop pattern is represented through the use of the title scene to the main scene to the mini-game scene to the end credit scene.
- The game loop pattern is also shown when we update the player’s movement using func _physics_process(delta):. 
		
### Flyweight
- In the inventory game system, I use a resource in the ItemResource.gd file as it extends the Resource.
- The resource is the intrinsic state as it is shared among all, while the item data such as name, value, and slot is the extrinsic state as it is unique to the item.
