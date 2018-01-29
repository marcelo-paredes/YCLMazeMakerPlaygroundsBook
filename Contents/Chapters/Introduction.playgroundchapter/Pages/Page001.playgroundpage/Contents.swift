//#-hidden-code
//  Created by Marcelo Paredes on 1/23/18.
//  Copyright © 2018, Marcelo Paredes, Yurai.CL. All rights reserved.
//#-end-hidden-code
/*:
 # Maze Model Overview

 The following page uses a model for constructing mazes or abitrary
 ineteger width and heights where the cell size is set to 1 by 1.

 The maze is constructed so that

 * maze size is __width__ by __height__, both integer numbers
 * there is a border of __width + 2__ by __height + 2__ around the maze
 * the maze is specified by arrays of cell numbers
 * cell numbers are named __0__ to __width * height - 1__, from left to right,
 top to bottom.

 As an example, a 3 by 3 maze would have cells:

 ### `| 0 | 1 | 2 |`
 ### `| 3 | 4 | 5 |`
 ### `| 6 | 7 | 8 |`
 */

//: [Next](@next)

