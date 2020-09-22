import 'package:flutter/material.dart';
import 'package:multi_select_dialog/multi_select_view.dart';
import 'package:multi_select_dialog/select_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /// 当前选择的列表数组
  List<String> _selects = [];

  /// 总的数据源
  /// _selects和_items的类型在实际使用中需要跟MultiSelectResult中members类型保持一致
  List<String> _items = [];

  @override
  void initState() {

    for (var i = 0; i < 40; i++) {
      _items.add(i.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20,
                top: 20,
              ),
              child: Text(
                '当前选择内容：'
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Text(
                _selects.join(','),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              child: RaisedButton(
                onPressed: showMultiSelectDialog,
                child: Text(
                  '点我'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMultiSelectDialog() async {
    bool isSelect = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('选择内容'),
          content: new StatefulBuilder(builder: (context, StateSetter setState) {
            return MultiSelectView(items: _items);
          },),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '取消'
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    '确定'
                  ),
                )
              ],
            )
          ],
        );
      },
    );
    if (isSelect != null) {
      _selects = MultiSelectResult.members;
      setState(() {
        
      });
    }
  }
}
