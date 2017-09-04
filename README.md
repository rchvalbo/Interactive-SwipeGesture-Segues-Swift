# Interactive-SwipeGesture-Segues-Swift
Interactive Swipe Gesture class that will recognize any user swipe and determine the proper segue to execute.


> This implementation assumes that you've already included transitioning delegates and animationController(forPresented/forDismissed) functions in your ViewController - This repo contains a fully functioning project for reference.

## Understanding the Functionality

1. In order to undersand the funtionality of this class, you should download this working project and mess around with it. 
2. Read through the class **SwipeInteractionController** and take note of all the comments.

## Class Capabilities

* This class will determine the axis that the swipe gesture is fired as well as the direction on that axis.

   * It will then execute the segue that you have included as a parameter in the **wireToViewController** function.

## Integrate into Your Project

* After you have created a file for the class in your project, you will need to add this line to the top of the view controller that will be implementing the class:

    > ```swift
swipeInteractionController.wireToViewController(viewController: self, segueUp: "showSignUp", segueDown: "showLogin", segueLeft: nil, segueRight: nil)
```
