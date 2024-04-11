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
        title: Text('Notes'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'Add item',
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_items[index]),
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
