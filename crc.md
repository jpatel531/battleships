1. Player

Responsibilities:

<!-- - Should have a tracking grid and a home grid -->
- Should have 5 ships
- Should assign those 5 ships co-ordinates. 
- Should call out shots on co-ordinates.
- Has to assign coordinates according to the ship's length
- For each ship, can only assign adjacent coordinates.
 
Collaborators:

- Ship
- Coordinates

#HomeGrid
#TrackingGrid





<!-- 2. Grid

Responsibilities: 

- Stores ships in specific locations
- Declare hits, misses and sinks for all locations
- Can hide ships

2.a. TrackingGrid < Grid

Responsibilities:

- Hides opponent's ship location

2.b. HomeGrid < Grid

Responsibilities:

- Know user's ship location

2+a+b. Collaborators:

- ship
- player
 -->

2. Co-ordinates

Responsibilities: 

- Have a latitude and a longitude
- knows when a ship is placed on the co-ordinate
- Knows when a co-ordinate has been targeted

Collaborators:

- Player
- Ship


3. Ship

Responsibilities: 

- Have certain lengths. 
- Has a fully defined location  
- Reports hits
- Reports sinking

Collaborators:

- coordinates
- player

 
<!-- 4. Game

Responsibilities: 

- When initialized, only has 2 players
- Allows player to place ships on board.
- Allows a player to look at tracking grid
- Allows a player to shoot at opponent's home grid
- Reports victory
- Is finished when one player wins.
- Allows turns. If player hits, gets another go.

Collaborators:

- ship
- grid (tracking grid and home grid)
- player -->

