Overview
==============

A couple of UIView subclasses that allows you to include an animated menu in your own iOS applications

Basically, the library is composed by a couple of UIView subclasses: LCAnimatedMenu and LCMenuItem. LCAnimatedMenu acts as a container for LCMenuItem objects (we'll call them items).  You can add as many items as you want, but only five items will be displayed on screen. Since, all the items are added to a scroll view, you can scroll the menu to see the rest of the items previously added. The LCAnimatedMenu class is in charge of animating the entrance of all the items.


Properties
==============

### For LCAnimatedMenu

`containerView`: This is the most important property. You will not see anything if you don't set it. You use this property to tell to LCAnimatedMenu which is its superview (Usually `self.view`). That's it.

`items`: It is useful to pass an array containing LCMenuItem objects to be displayed in the menu view. Only pass objects members of the LCMenuIten class, if you don't do it the class will raise an exception at runtime.

`animationDuration`: Determines in seconds how fast the items are displayed on screen. By default 1 second.

`position`: A property of type `LCAnimatedMenuPosition` used to tell to the class where to show the menu: `LCAnimatedMenuPositionBottom` at the bottom and `LCAnimatedMenuPositionTop` at the top. by default the menu is displayed at the bottom.

`showBelowTopBars`: Only works with the menu at the top position. It is an offset that adds some pixels (64.0 exactly) to the menu view to avoid overlap with the top bars (navigation bar and status bar).

`delegate`: It sets a delegate object for the `LCAnimatedMenuDelegate` protocol.


### For LCMenuItem

`borderColor`: By default, the items are displayed with an appearance, that is a rounded view. This rounded view has a border and this property sets a color for it. By default is `[UIColor grayColor]`.

`lineWidth`: It is the width for the border. By default 1.0.

`innerColor`: As I've mentioned previously, that rounded view has an inner circle. This property sets a color for that circle. By default is `[UIColor colorWithWhite:1.0f alpha:0.7f]`.

`actionBlock`: Under the hood, each item sends a message to its target (itself) when they are pressed, same way as UIButton do, but, because I prefer blocks, I decided to execute a block based action each time any button is pressed. If you set this property, you don't have to worry about button indexes neither implement delegate methods.


Initialization methods
==============

There are few methods to create both objects. For **LCMenuItem** there are two:

```objectivec
- (id)initWithImage:(UIImage *)image;
- (id)initWithImage:(UIImage *)image withActionBlock:(ActionBlock)actionBlock;
```

The first initialize an item with an image and the second initializes an item with an image and an action block. The image can cover all the button view and to be of any size. The layer mask clips the image (assigned to the image property of a UIButton object) to the item bounds and the internal behavior resize the button to a `50x50` size.

You can initialize an item without an image using the `initWithFrame:` method.

How to put it in my code?
==============

It's easy. Follow these few steps:

**1.** Import both clases in your `.m` file:

```objectivec
#import "LCAnimatedMenu.h"
#import "LCMenuItem.h"
```

**2.** 
