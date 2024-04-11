import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _items = [];
  List<bool> _checkedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Set app bar background color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'Add item',
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addItem,
                  color: Colors.blue, // Set icon color
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      _items[index],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: _checkedList[index] ? Colors.grey : Colors.black,
                        decoration: _checkedList[index]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    value: _checkedList[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _checkedList[index] = value!;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        _items.add(_textEditingController.text);
        _checkedList.add(false); // Initially set all checkboxes as unchecked
        _textEditingController.clear();
      });
    }
  }
}
