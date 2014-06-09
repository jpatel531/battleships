1. Player

Responsibilities:

<!-- - Should have a tracking grid and a home grid -->
- Should have 1 aircraft carrier, 1 battleship, 1 tug, 1 destroyer and 1 submarine
- Should assign those 5 ships starting points.
- Should assign ship orientation 
- Should call out target co-ordinates.

 
Collaborators:

- Ship
- Coordinates

#HomeGrid
#TrackingGrid


2. Grid

Responsibilities: 

- Displays 10x10 matrix
- Has two different coordinate systems, for each viewing-grid
- Maps coordinates
- Can hide ships
- Grid gets automatically updated via coordinates 

2.a. TrackingGrid < Grid

Responsibilities:

- Hides opponent's ship location

2.b. HomeGrid < Grid

Responsibilities:

- Know user's ship location

2+a+b. Collaborators:

- ship
- player


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
- Each player has a home grid and a tracking grid
- Allows player to place ships on board with input, then it's player 2's turn
- Allows a player to look at tracking grid
- Allows a player to shoot at opponent's home grid
- Updates grids
- Player cannot place same ship twice

- Reports victory
- Is finished when one player wins.
- Allows turns. If player hits, gets another go.
-

5. Rules

- A player cannot look at the other's home grid
- Player cannot place same ship twice
- Player cannot target same spot twice
- Player cannot place a ship that's out of boundaries
- Player cannot place a ship next to his other ship
- Player cannot place a ship on his other ship



