library navigation_history_observer;

import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';

class NavigationHistoryObserver extends NavigatorObserver {

  /// A list of all the past routes
  List<Route<dynamic>> _history = <Route<dynamic>>[];

  /// Gets a clone of the navigation history as an immutable list.
  get history => BuiltList<Route<dynamic>>.from(_history);

  /// Gets the top route in the navigation stack.
  get top => _history.last;

  /// A list of all routes that were popped to reach the current.
  List<Route<dynamic>> _poppedRoutes = <Route<dynamic>>[];

  /// Gets a clone of the popped routes as an immutable list.
  get poppedRoutes => BuiltList<Route<dynamic>>.from(_poppedRoutes);

  /// A stream that broadcasts whenever the navigation history changes.
  StreamController historyChangeStreamController = StreamController.broadcast();

  /// Accessor to the history change stream.
  get historyChanged => historyChangeStreamController.stream;

  static final NavigationHistoryObserver _singleton = NavigationHistoryObserver._internal();
  NavigationHistoryObserver._internal();
  factory NavigationHistoryObserver() {
    return _singleton;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    _poppedRoutes.add(_history.last);
    _history.removeLast();
    historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.pop,
      route: route
    ));
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _history.add(route);
    _poppedRoutes.remove(route);
    historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.push,
      route: route
    ));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    _history.remove(route);
    historyChangeStreamController.add(HistoryChange(
        action: NavigationStackAction.remove,
        route: route
    ));
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    int oldRouteIndex = _history.indexOf(oldRoute);
    _history.replaceRange(oldRouteIndex, oldRouteIndex+1, [newRoute]);
    historyChangeStreamController.add(HistoryChange(
        action: NavigationStackAction.replace,
        route: newRoute
    ));
  }

}

/// A class that contains all data that needs to be broadcasted through the history change stream.
class HistoryChange {

  HistoryChange({this.action, this.route});

  final NavigationStackAction action;
  final Route<dynamic> route;

}

enum NavigationStackAction {
  push,
  pop,
  remove,
  replace
}
