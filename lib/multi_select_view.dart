import 'package:flutter/material.dart';
import 'package:multi_select_dialog/select_manager.dart';

class MultiSelectView extends StatefulWidget {
  final List<String> items;

  const MultiSelectView({Key key, this.items}) : super(key: key);

  @override
  _MultiSelectViewState createState() => _MultiSelectViewState();
}

class _MultiSelectViewState extends State<MultiSelectView> {
  List<String> _items;
  List<String> _selectMembers = new List();
  List<Widget> _cells = new List();

  @override
  void initState() {
    _items = widget.items;
    _selectMembers = MultiSelectResult.members;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _cells = new List();
    for (var item in _items) {
      _cells.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_selectMembers.contains(item)) {
            _selectMembers.remove(item);
          } else {
            _selectMembers.add(item);
          }
          int index = _items.indexOf(item);
          print('点击了$index');
          setState(() {});
        },
        child: MultiSelectCell(
          value: item,
          selected: _selectMembers.contains(item),
        ),
      ));
    }

    return Container(
      child: Column(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: '请输入查询内容',
                isDense: true,
              ),
              onChanged: (String value) {
                print(value);
                _items = widget.items
                    .where((element) => element.contains(value))
                    .toList();
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _cells.toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiSelectCell extends StatelessWidget {
  final String value;
  final bool selected;

  const MultiSelectCell({Key key, this.value, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // width: 50,
            child: Text(
              value,
            ),
          ),
          Container(
            child: AbsorbPointer(
              child: Checkbox(
                onChanged: (selected) {
                  print('11111');
                },
                tristate: true,
                activeColor: Colors.blueAccent,
                value: selected,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
