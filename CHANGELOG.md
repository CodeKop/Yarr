# Changelog

## 0.3.8

### Fixed

- Now adding a fixed category! Fixed
- Fixed date errors preventing chapters from loading and now preventing that from happening again

### Changed

- Using hacky provider implementation for a single future in order to get author

### Added

- Show author on fiction page

## 0.3.7

### Changed

- Increase default font size on reader
- Increase line height on reader
- Increase side padding on reader
- Remove scrolling in font list

### Added

- Added clear cache button
- Add some integration tests that take screenshots (broken without manual intervention)
- Added proguard rules on Android (did not decrease size AFAIK)

## 0.3.6

### Changed

- Fixed typo of minimum flutter version in pubspec.yaml
- Fixed border in iOS app icon
- Reduced padding of chapter comment page numbers to not overflow on smaller devices

## 0.3.5

### Added

- App icon
- Chapter comments in API & UI

### Changed

- Fixed iOS related bugs:
  - Fixed too much padding at bottom of font list
  - Fixed cupertino widgets (spinner) not being light enough in dark mode
- Change app name to Yarr
- Tapping on item's padding in chapter list now goes to chapter

## 0.3.1

### Changed

- Fix check mark color in font selection
- Fixed potential async bug where default value was used by making shared preferences a singleton

## 0.3.0

### Added

- Reverse button for sorting a fiction's chapter list
- API for author chapter comments
- Display author chapter comments
- Loading placeholder/spinner for cover images
- Show error placeholders if network is not available for cover images
- Cache cover images
- Add onTap option page popup in a chapter
- Add new font assets
- Ability to change text size and font group for reading a chapter
- Add persistent local storage for text size and font group

### Changed

- Default font size for reader increased to 16 from 15
- Default font changed to serif Lora
- Removed scroll bar in chapter added in 0.2.0 due to it being distracting while reading

## 0.2.0

### Added

- Swipe to go to next/previous page
- Scrollbar while reading chapter
- Tabs now maintain state when going back and forth
- Button to open a fiction page in browser
- Settings page
- Dark mode
- Home tab
- API & display of top novels on home tab
- API & display of trending novels on home tab
- API & display of weekly popular novels on tab

### Changed

- A lot of padding
- Renamed some API methods
- API for chapter contents now longer returns outer div element
- Fixed bug when less than three genres exist
- Change chapter date display to use RR's stringification instead of calculating on own.
- Now scales up chapter images if they are small
- Utilize logical pixels all over
- Added internet permissions on Android

## 0.1.0

- Initial release
- Search novels and read chapters
