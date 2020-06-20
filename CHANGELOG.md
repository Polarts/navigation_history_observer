## [1.0.3] - Jun. 20, 2020

* Changed library name from `navigation_history_observer` to `navigationhistoryobserver`.
* Removed `route` from `HistoryChange`, added `newRoute` and `oldRoute` instead.
* Added `next` getter to get most resent popped route.
* No longer supporting forwards navigation as it causes severe issues.
* Added more usage details and special thanks to the readme.

## [1.0.2] - Jun. 19, 2020

* Added example project, updated historyChanged to historyChangeStream for better semantics.

## [1.0.1] - Jun. 19, 2020

* Added stream to broadcast changes in history.

## [1.0.0] - Jun. 17, 2020

* First stable release.
