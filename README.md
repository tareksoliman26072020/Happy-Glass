My goal is to imitate the game `happy glass`: https://www.youtube.com/watch?v=fd8MWwT7ReI
# Happy Glass
The game is implemented using java with [processing](https://processing.org/)
with help of the library [box2d](https://github.com/shiffman/Box2D-for-Processing)

- #### The game consists of a water tap, boundaries and a an object which collects the falling water.
- #### The objective of the game is to add a boundary (using the mouse), to re-direct the water in the direction of the "cup".
- #### In the original game, a line is drawn and used as a boundary. What I did is a bit different, which is that the boundary is a "bridge" which consists pieces of round boundares, which can be drawn using the mouse by pressing, holding and dragging the mouse __with an appropriate speed__ to draw a bridge which leads the water to the black cup. If the bridge is drawn "poorly", then the water may slip in the holes between the round boundaries which the bridge consists of.
- #### The game is over 15 seconds after releasing the mouse. The game is won or loss depending on how much water end up in the black cup.
- #### Just as in the original game, the cup can express emotions using facial expressions, which are 3: (happy,sad,astonished).
  - #### The cup is sad as long as the cup is empty
  - #### The cup is astonished when at least of drop of water ends up in the cup.
  - #### The cup is happy when the winning criteria is fulfilled.
- #### the mouse cursor is replaced with a pen to draw with. The user can only draw once, and the water falls only once and for exactly 3 seconds.
_____
## Moving Objects
- #### The water particles and the bridge particles are our moving objects, they appear differently, and have different physical properties. Water properties dissappear when they leave the gaming field. The bridge 
-----
## Interaction
- #### The user input is allowed through the mouse pressing, holding and then releasing to draw the bridge
-----
## Collision Handling
- #### Boundaries of different types and goals exist which re-direct the movement of the water's drops.
-----
## Using Code Made by Others
- #### Shiffman's examples for water, bridge, and other boundaries were used to inspire the implementation. 
-----
## Screenshots
![](https://hackmd.informatik.uni-bremen.de/uploads/upload_17ca40ab4bc4c27de14752030362cc0e.png)
-----
![](https://hackmd.informatik.uni-bremen.de/uploads/upload_b2675913e1be94b657b5c13e9c916c52.png)
-----
![](https://hackmd.informatik.uni-bremen.de/uploads/upload_bd75a7ca5845dc5a513cbad15f498985.png)
-----
![](https://hackmd.informatik.uni-bremen.de/uploads/upload_6923aacdde85474a8818f8ce93a9b74f.png)
