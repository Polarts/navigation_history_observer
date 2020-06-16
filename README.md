# Flutter Navigation History Observer

A flutter navigation observer that adds access to lists that track the navigation stack both forwards and backwards.

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Warning! This code has not yet been tested!

## Usage

This is a singleton, meaning you can access its single instance from anywhere by calling the default constructor.

To initialize the first instance you must add it to your app's navigator observers' like so:

```
void main() {
  runApp(MaterialApp(
    home: Container(),
    navigatorObservers: [NavigationHistoryObserver()],
  ));
}
```

To access the history, simply use `NavigationHistoryObserver().history` from anywhere in your code.

To access the popped routes, simply use `NavigationHistoryObserver().poppedRoutes` from anywhere in your code.

This also allows for going forwards in your navigation. To do that, use `Navigator.push(context, NavigationHistoryObserver().poppedRoutes.last)` and it should also automagically disappear from the `poppedRoutes` collection.

### Note:

The `history` and `poppedRoutes` getters return clones of the actual private collections as BuiltLists, meaning they're immutable.
To change these collection, use the default Navigator as you normally would.
