
---

# 🎮 Tic Tac Toe Game (Assembly Language)

## Description 📜

This project is a simple console-based Tic Tac Toe game implemented in Assembly language using the emu8086 assembler. It allows two players to play Tic Tac Toe in a command-line interface. The game board is a 3x3 grid where Player 1 uses 'O' and Player 2 uses 'X'. The game checks for a winner or a draw after each move.

## Features 🌟

- 🕹️ **Two-Player Mode**: Play with another person on the same computer.
- 📝 **Player Turn Indicators**: Displays which player's turn it is.
- 🏆 **Winner Detection**: Identifies and announces the winner.
- 🔄 **Draw Detection**: Declares a draw if the board is full without a winner.
- 🌟 **Clear Interface**: Easy-to-read game board and status messages.

## How to Use 🚀

### Compilation and Execution ⚙️

1. **Set Up the Environment**:
   - Ensure you have [emu8086](https://emu8086.com/) or a similar 8086 assembler and emulator installed.

2. **Compile the Code**:
   - Open emu8086 and load the assembly code file.

3. **Run the Code**:
   - Run the code within the emulator to start the game.

### Playing the Game ✍️

1. **Starting the Game**: The game will display the Tic Tac Toe board and instructions for Player 1.
2. **Player Moves**:
   - Player 1 uses 'O'.
   - Player 2 uses 'X'.
3. **Enter Moves**:
   - When prompted, enter the row and column numbers (1-3) for your move.
4. **Check Status**:
   - The game will display the updated board after each move.
   - The game will announce the winner or a draw if the game ends.

## Code Structure 📁

- `TicTacToe.asm`: Contains the implementation of the Tic Tac Toe game in assembly language.
    - `MAIN PROC`: Main procedure that controls the game flow and player input.
    - `CHECK PROC`: Checks for a winning condition or draw.
    - `winner PROC`: Displays the winner message and ends the game.
    - `tictactoe PROC`: Displays the game title.
    - `player1 PROC` & `player2 PROC`: Handles player turns.
    - `map PROC`: Displays the 3x3 game board.

## Contributing 🤝

Contributions are welcome! Feel free to fork the repository, make improvements, or submit bug fixes via pull requests.

## License 📜

This project is licensed under the MIT License.

## Author 🙋‍♂️

**Hasheem Ahmed**

## Contact 📧

For any inquiries or suggestions, please contact the author at [hasheemasif@gmail.com]
