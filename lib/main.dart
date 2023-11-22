import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  int? lastMove;

  void _handleTap(int index) {
    if (board[index] != '' || winner != '') return;

    setState(() {
      board[index] = currentPlayer;
      lastMove = index;
      if (_checkWinner(currentPlayer)) {
        winner = currentPlayer;
      }
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    });
  }

  bool _checkWinner(String player) {
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == player &&
          board[i * 3 + 1] == player &&
          board[i * 3 + 2] == player) return true;
      if (board[i] == player &&
          board[i + 3] == player &&
          board[i + 6] == player) return true;
    }
    if (board[0] == player && board[4] == player && board[8] == player)
      return true;
    if (board[2] == player && board[4] == player && board[6] == player)
      return true;
    return false;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
      lastMove = null;
    });
  }

  void _undoMove() {
    if (lastMove != null) {
      setState(() {
        board[lastMove!] = '';
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        lastMove = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: winner != ''
                  ? Text('Winner: $winner', style: TextStyle(fontSize: 30))
                  : AspectRatio(
                      aspectRatio: 1, // Square aspect ratio
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => _handleTap(index),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text(
                                board[index],
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _resetGame,
              child: Text('Reset Game'),
            ),
          ),
          if (winner == '')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _undoMove,
                child: Text('Undo Last Move'),
              ),
            ),
        ],
      ),
    );
  }
}
