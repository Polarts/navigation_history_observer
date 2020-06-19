import 'package:flutter/material.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

class ExamplePage extends StatefulWidget {

  ExamplePage({Key key, this.pageNum}) : super(key: key);

  final int pageNum;

  @override
  _ExamplePageState createState() => _ExamplePageState();

}

class _ExamplePageState extends State<ExamplePage> {

  final NavigationHistoryObserver historyObserver = NavigationHistoryObserver();

  int historyCount = 0;
  int poppedCount = 0;

  @override
  void initState() {
    super.initState();

    historyCount = historyObserver.history.length;
    poppedCount = historyObserver.poppedRoutes.length;

    historyObserver.historyChangeStream.listen(
      (change) =>
          setState(
              () {
                historyCount = historyObserver.history.length;
                poppedCount = historyObserver.poppedRoutes.length;
              }
          )
    );

  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text("Navigation example ${widget.pageNum}"),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Welcome to the navigation page!"),
              Text("History has $historyCount routes"),
              Text("There are $poppedCount popped routes"),
              RaisedButton(
                child: Text("Navigate to a new page"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExamplePage(pageNum: widget.pageNum + 1)
                    )
                ),
              )
            ],
          ),
        ),
      );
}