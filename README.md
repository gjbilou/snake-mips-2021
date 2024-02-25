
# MIPS Assembly Snake Game

Welcome to the Snake Game, a classic arcade game reimplemented in MIPS assembly language. This project demonstrates the capabilities of MIPS assembly programming and offers a hands-on experience with low-level software development and computer architecture concepts.

## Project Overview

The Snake Game is a simple yet engaging game where the player controls a snake, guiding it to eat food while avoiding collisions with the walls and its own tail. As the snake eats food, it grows longer, increasing the game's difficulty. This implementation in MIPS assembly provides a basic yet functional version of the game, utilizing the MARS simulator's bitmap display and keyboard MMIO (Memory-Mapped I/O) for graphics and input.


## Prerequisites

- Ensure Java is installed on your computer.
- Download the MARS MIPS simulator (Mars.jar) from the official source.


## Setup Instructions


### Starting MARS and Loading Your Program

1. Open a terminal or command prompt.
2. Navigate to the directory containing `Mars.jar` and your MIPS assembly program (e.g., `snake_game.asm`).
3. Run the following command to start MARS and load **snake.asm** source code through the File Menu:

    ```bash
    java -jar Mars.jar
    ```

### Configuring the Bitmap Display

After opening MARS, you'll need to manually enable and configure the bitmap display:

1. Go to the **Tools** menu in the MARS GUI.
2. Select **Bitmap Display** to open the bitmap display tool.
3. Press the **Connect to MIPS** button.
4. Configure the bitmap display settings as follows:
    - **Unit Width**: The width in pixels of each element. Set it to 16.
    - **Unit Height**: The height in pixels of each element. Set it to 16.
    - **Display Width**: The total width in units of the display area. Set it to 512.
    - **Display Height**: The total height in units of the display area. Set it to 512.
    - **Base Address**: The starting memory address for the display data. Set it to 0x10010000 static data.

### Setting Up the Keyboard and Display MMIO Simulator

If your program requires keyboard input, follow these steps to enable the Keyboard and Display MMIO Simulator:

1. Again, go to the **Tools** menu.
2. Select **Keyboard and Display MMIO Simulator**.
3. Press the **Connect to MIPS** button.
4. Use the **Keyboard : Characters typed here are stored to Receiver Data 0xffff0004** section as input. 

This tool simulates keyboard input, allowing us to control the snake.

### Running Your Program

With the bitmap display and keyboard MMIO configured, you can now assemble and run your MIPS program using the MARS interface:

1. Click on the **Assemble** button in the MARS toolbar to assemble your program.
2. To run the program, click on the **Run** button.

The game should now execute, with output displayed in the bitmap display and interactions possible through the keyboard MMIO simulator.


## How to Play

- Use the zqsd (based on the azerty keyboards) on your keyboard to change the direction of the snake.
- Guide the snake to the food items that appear randomly on the screen.
- Avoid hitting the walls or the snake's own tail.
