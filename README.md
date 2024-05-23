# NewSuperJumpKing
 A mix of JumpKing and New Super Mario Bros

## Date: 5/12/2024
### Features Added:
- Collision with walls now ricochets the character off the wall when they jump into the wall like Jump King.
- Character can not move while charging their jump
### Still need to add:
- Need to create a proper first level next week
- need to create a title screen
- Enemies to enconter
### Issues Encountered:
- The physics of jumping into the wall and bouncing off was not working as intended at first. The problem I was facing was the character was not able to detect if they were facing left or right. I was using the velocity to detect if the character was moving left or right with positives and negatives, but when the character would jump the velocity would be positive either way. To fix this problem I started reading up on the GDScript forms and found sprite_2d.is_flipped_h which detaches if the 2d sprite is flipped horizontally and just codded around that.  
### Lesson Learned:
- When you are stuck and can't figure out what is wrong you need to start reading about the code you are using. This is my first project with GDScript so I needed to research the language and having done so fixed my code and made it the way I wanted.  

## Date: 4/28/2024
### Features Added:
Since this is the first github update here is everything I have done since I started
- Created my character
- Finished all my character's jumping physics so it is now similar to Jump King, Jumping wise.
- Added character animations
- Added collisions meaning I stand on the floor, hit my head on the ceiling, and hit the wall
### Still need to add:
- Need to create a proper first level next week
- Need to create proper collision physics, like how in jump king when the character hits the wall he bounces back
- need to create a title screen
### Issues Encountered:
- Learning GDScipt is kind of hard since I don't know the syntax that well
- Jumping Physics was tough because when I made one feature a different feature decided to not work anymore, For example, the character is not able to move left and right white the character is in the jump animation charging. Adding that feature caused my character not to want to jump left and right, only jump up. I fixed this by adding a horizontal speed variable.
### Lesson Learned:
- Save old repositories: I think I almost lost everything like 3 times while making the beginning portion of the game. If I had saved the old repositories sooner I would have had an easier time going back.
- Commenting code: In the beginning, I was not writing what each line did or how they were being used and when I would go back to work on the code the next day it would be a struggle trying to remember everything. 
