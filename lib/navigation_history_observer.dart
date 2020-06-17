library navigation_history_observer;

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';

class NavigationHistoryObserver extends NavigatorObserver {

  /// A list of all the past routes
  List<Route<dynamic>> _history = <Route<dynamic>>[];

  /// Gets a clone of the navigation history as an immutable list.
  get history => BuiltList<Route<dynamic>>.from(_history);

  /// A list of all routes that were popped to reach the current
  List<Route<dynamic>> _poppedRoutes = <Route<dynamic>>[];

  /// Gets a clone of the popped routes as an immutable list.
  get poppedRoutes => BuiltList<Route<dynamic>>.from(_poppedRoutes);

  /// Gets the top route in the navigation stack.
  get top => _history.last;

  static final NavigationHistoryObserver _singleton = NavigationHistoryObserver._internal();
  NavigationHistoryObserver._internal();
  factory NavigationHistoryObserver() {
    return _singleton;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    _poppedRoutes.add(_history.last);
    _history.removeLast();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _history.add(route);
    _poppedRoutes.remove(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    _history.remove(route);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    int oldRouteIndex = _history.indexOf(oldRoute);
    _history.replaceRange(oldRouteIndex, oldRouteIndex+1, [newRoute]);
  }

}