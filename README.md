Battleships Description

- Two player game

- Each player has two 10x10 grids: tracking-grid and home-grid.

- 1 ship x length 2 units 
- 2 ships x length 3 units 
- 1 ship x length 4 units
- 1 ship x length 5 units

- Each player places 10 ships, of various length, on their home grid. 

- The tracking grid is used for recording the shots you've taken.
- Can't hit same spot more than once

- Ships can't touch

- The game begins with calling out a target cell of the opponent's grid.

- If hit, you get to go again

- the board declares if ship is hit, missed, or sunk. -->

- A miss is marked with a 0 on the tracking grid. A hit is marked with a 1 on the tracking grid.

- If a ship is hit in all its cells, it is sunk.

- You cannot cheat.

- First player to sink opponent's fleet wins. Game finishes.


-------

Ship pseudo-code

- locations 
{ A1: :ship, A2: :ship, A3: :hit}

- hit
locations.each {|location, status| status = :hit if location.targeted?}



