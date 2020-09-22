import 'package:flutter/material.dart';
import 'package:multi_select_dialog/select_manager.dart';

class MultiSelectView extends StatefulWidget {
  /// 这只是个demo，所以类型是String。实际使用中需要替换为接口返回的数据model
  /// 跟MultiSelectResult中'members'的类型保持一致
  final List<String> items;

  const MultiSelectView({Key key, this.items}) : super(key: key);

  @override
  _MultiSelectViewState createState() => _MultiSelectViewState();
}

class _MultiSelectViewState extends State<MultiSelectView> {
  /// 因为要根据输入内容进行搜索，所以创建一个新的_items来保存数据源
  /// 跟widget.items类型保持一致
  List<String> _items;
  List<String> _selectMembers = new List();

  /// column的children
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
            /// 这里SingleChildScrollView也可以用ListView来实现
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
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              value,
            ),
          ),
          Container(
            /// 设置child中的widget不响应事件
            /// AbsorbPointer也可以替换为IgnorePointer，效果也是一样的
            /// 这两个是有区别的，虽然都可以设置child不响应事件，但是AbsorbPointer本身是可以响应的，而IgnorePointer本身也无法响应事件
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
