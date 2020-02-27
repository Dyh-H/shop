// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:shop/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}


class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  EasyRefreshController _controller=EasyRefreshController();
  int res=40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: EasyRefresh(
        controller: _controller,
        child: ListView.builder(
          itemBuilder: (BuildContext context,int index){
            if (index<=res) {
              return Text("${index}");
            }
          }
          ),
        onRefresh: null,
        topBouncing: false,
        onLoad: () async {
            await Future.delayed(Duration(seconds: 2), () {
              print('onLoad');
              setState(() {
                res+=10;
              });
              _controller.finishLoad();
            });
          },
        // footer: ClassicalFooter(
        //   float: true,
        //   // completeDuration: Duration(seconds: 3),
        //   //是否开启无限自动刷新
        //   enableInfiniteLoad: false,
        //   loadReadyText: "释放加载..."
        // ),
      ),
    );
  }
}