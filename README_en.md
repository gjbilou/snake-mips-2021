# MIPS Assembly Snake Game

Welcome to the Snake Game, a classic arcade game reimplemented in MIPS assembly language. This project demonstrates the capabilities of MIPS assembly programming and offers a hands-on experience with low-level software development and computer architecture concepts.

## Project Overview

The Snake Game is a simple yet engaging game where the player controls a snake, guiding it to eat food while avoiding collisions with the walls and its own tail. As the snake eats food, it grows longer, increasing the game's difficulty. This implementation in MIPS assembly provides a basic yet functional version of the game, utilizing the MARS simulator's bitmap display and keyboard MMIO (Memory-Mapped I/O) for graphics and input.

## Prerequisites

- Ensure Java is installed on your computer.
- Download the MARS MIPS simulator (Mars.jar) from the official source.

## Setup Instructions

### Starting MARS and Loading the Program

1. Open a terminal or command prompt.
2. Navigate to the directory containing `Mars.jar` and the `snake.asm` file.
3. Run the following command to start MARS:

    ```bash
    java -jar Mars.jar
    ```

4. Load the **snake.asm** source code through the File Menu.

### Configuring the Bitmap Display

After opening MARS, you'll need to manually enable and configure the bitmap display:

1. Go to the **Tools** menu in the MARS GUI.
2. Select **Bitmap Display** to open the bitmap display tool.
3. Press the **Connect to MIPS** button.
4. Configure the bitmap display settings as follows:
    - **Unit Width**: Set it to 16 pixels.
    - **Unit Height**: Set it to 16 pixels.
    - **Display Width**: Set it to 512 units.
    - **Display Height**: Set it to 512 units.
    - **Base Address**: Set it to 0x10010000 for the static data.

### Setting Up the Keyboard and Display MMIO Simulator

Because snake is a game that requires keyboard input, we need to enable the Keyboard and Display MMIO Simulator:

1. Go to the **Tools** menu.
2. Select **Keyboard and Display MMIO Simulator**.
3. Press the **Connect to MIPS** button.
4. Use the section **Keyboard: Characters typed here are stored to Receiver Data 0xffff0004** for input. 

This tool simulates keyboard input, allowing you to control the snake.

### Running the Program

With the bitmap display and keyboard MMIO configured, you can now assemble and run the game using the MARS interface:

1. Click on the **Assemble** button in the MARS toolbar to assemble your program.
2. To run the program, click on the **Run** button.

The game should now execute, with output displayed in the bitmap display and interactions possible through the keyboard MMIO simulator.

## How to Play

- Use the `zqsd` keys (based on AZERTY keyboards) on your keyboard to change the direction of the snake.
- Guide the snake to the food items that appear randomly on the screen.
- Avoid hitting the walls or the snake's own tail.
