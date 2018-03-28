#  XAMLKit

XAMLKit is an in-progress implementation of Microsoft's eXtensible Application Markup Language goodness for iOS and objective-c.

## Pods

Eventually this library will be packaged into cocoapods, for now include the source under `lib/XAMLKit`.

| Area | Purpose |
| --- | --- |
| Core | Everything for creating objects from XAML files |
| Databinding | Supporting the `{Binding ...}` syntax etc. |
| Flexbox | For flexbox inspired layout in UIKit |
| Resources | Enabling the `{StaticResource ...}` syntax etc. |
| UIKit | Special UIKit extensions for working with XAML declared user interfaces |

## Setting up a project to use XAMLKit

### Automatic classes for XAML files
Add a build rule for all files matching *.xaml.
Add the following script
```
$PROJECT_DIR/lib/XAMLKit/headerForXAMLFile.sh $INPUT_FILE_BASE > $DERIVED_FILE_DIR/$INPUT_FILE_NAME.h

$PROJECT_DIR/lib/XAMLKit/implementationForXAMLFile.sh $INPUT_FILE_BASE $INPUT_FILE_NAME $INPUT_FILE_PATH > $DERIVED_FILE_DIR/$INPUT_FILE_NAME.m
```
Then add the following output files
`$(DERIVED_FILE_DIR)/$(INPUT_FILE_NAME).h`
`$(DERIVED_FILE_DIR)/$(INPUT_FILE_NAME).m`

__NOTE: Ensure that XAML files are added to Compile Source build phase__

## Todo

- [x] XAML Deserialization
- [x] Hot reloading
- [x] Databinding
- [x] Resources
- [x] Flexbox Layout
- [x] Todos sample
- [ ] Styles
- [ ] Triggers and Storyboards
- [ ] Cocoapods packaging

## Issues/Thoughts

### UITableViewCells
Cells are all currently of the default height no matter what the context.
Consider adding configuration which maps view model Class to cell template.
Consider adding slide-in buttons for cells declaritively.

### Inter-pod dependencies
There are odd dependencies between the pods here and there, needs cleaning up.

### Idioms
Consider adding an idiom filter to styles to control iPad layout
