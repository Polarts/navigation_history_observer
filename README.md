# Flutter Navigation History Observer

A flutter navigation observer that adds access to lists that track the navigation stack both forwards and backwards.

## Usage

This is a singleton, meaning you can access its single instance from anywhere by calling the default constructor.

To initialize the first instance you must add it to your app's navigator observers list like so:

```
void main() {
  runApp(MaterialApp(
    home: Container(),
    navigatorObservers: [NavigationHistoryObserver()],
  ));
}
```

#### History:
To access the history, use `NavigationHistoryObserver().history` from anywhere in your code.

Use `NavigationHistoryObserver().top` to peek on the navigation stack's top element - which would be the current route.

#### Popped routes (forwards history):
To access the popped routes, use `NavigationHistoryObserver().poppedRoutes` from anywhere in your code.

Use`NavigationHistoryObserver().next` to get the most recent popped route.

This feature is intended to track the pages visited by the user, rather than navigating forwards.
Please keep in mind that popped routes have already been disposed, meaning that you can't simply navigate to them as is via `Navigator.push(context, route)`.

If you'd still like to navigate forwards, you may try `Navigator.pushNamed(context, name)`, whereas the name should be extracted from `route.settings.name` provided that you're using named routes in your app.  
However, there's no guarantee that it'll work.

Nevertheless, I discourage having forwards-navigation in your app.

#### History Change Stream:
The NavigationHistoryObserver class holds a StreamController that broadcasts each time the navigation stack changes.

Use `NavigationHistoryObserver().historyChangeStream.listen((change) => action)` to listen for changes.

The `change` object is of type `HistoryChange`. It holds the following properties:
1. `action` - a `NavigationStackAction` enum reporting the action that caused this change. Values: `push`, `pop`, `remove`, `replace`.
2. `newRoute` - the new route that was added/removed from the stack.
3. `oldRoute` - the old route that was in place before this action happened.

This provides you with an easy-to-use interface that allows updating states across your app whenever the navigation stack changes.
See the example for basic usage.

## Developer's Note:

The `history` and `poppedRoutes` getters return clones of the actual private collections as BuiltLists, meaning they're immutable.
To change these collections, use the default Navigator as you normally would, and they'll update as you navigate throughout your app.

## Special Thanks

- Shoutout to the [Flutter Israel Developers](https://www.facebook.com/groups/2779846762051712) community for being supportive and encouraging me to create this package.
- Special thanks to [Sahar Vanunu](https://github.com/saharvx9) for giving me the original idea for this package.