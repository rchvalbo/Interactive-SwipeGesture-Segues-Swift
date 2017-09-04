//
//  SwipeInteractionController.swift
//  4-Way Interaction Gesture Example
//
//  Created by Roman Chvalbo on 9/4/17.
//  Copyright © 2017 SapienSolutions, LLC. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    
    // Initialize variables
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private var segueLeft: String?
    private var segueRight: String?
    private var segueUp: String?
    private var segueDown: String?
    private var whichSegue: Character?
    private var axis: Character?
    private weak var viewController: UIViewController!
    
    
    /* In order for this class to properly execute, this function must be called in the ViewController */
    func wireToViewController(viewController: UIViewController!, segueUp: String?, segueDown: String?, segueLeft: String?, segueRight: String?) {
        self.viewController = viewController
        self.segueUp = segueUp
        self.segueDown = segueDown
        self.segueRight = segueRight
        self.segueLeft = segueLeft
        
        prepareGestureRecognizerInView(view: viewController.view)
    }
    
    //Creates the gesture and adds it to the viewController
    private func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer: )))
        
        print("Added gesture!")
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        //Get velocity for both axis
        var velocityY = gestureRecognizer.velocity(in: gestureRecognizer.view!.superview!).y
        var velocityX = gestureRecognizer.velocity(in: gestureRecognizer.view!.superview!).x
        
        var progress:CGFloat = 0
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        
        if(segueUp != nil && whichSegue == "u"){
            
            //if gesture is moving UP from original point, modify progress
            if(translation.y < 0){
                progress = (abs(translation.y) / (gestureRecognizer.view?.frame.height)!)
                
            }
        }
        else if(segueDown != nil && whichSegue == "d"){
            
            //if gesture is moving DOWN from original point, modify progress
            if(translation.y > 0){
                progress = translation.y / (gestureRecognizer.view?.frame.height)!
            }
        }
        else if(segueLeft != nil && whichSegue == "l"){
            
            //if gesture is moving LEFT from original point, modify progress
            if(translation.x > 0){
                progress = translation.x / (gestureRecognizer.view?.frame.width)!
            }
        }
        else if(segueRight != nil && whichSegue == "r"){
            
            //if gesture is moving RIGHT from original point, modify progress
            if(translation.x < 0){
                progress = abs(translation.x) / (gestureRecognizer.view?.frame.width)!
            }
        }
        
        print(translation.y)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        
        //monitor the state of the gesture and take action with every state
        switch gestureRecognizer.state {
            
        case .began:
            
            interactionInProgress = true
            
        case .changed:
            
            // if axis has not been set during current gesture set proper axis
            if(axis == nil){
                if(abs(translation.y) > abs(translation.x)){
                    axis = "v"
                }
                else if(abs(translation.x) > abs(translation.y)){
                    axis = "h"
                }
            }
            
            
            //If vertical axis determined
            if(axis == "v"){
                
                //set direction and corresponding segue of the gesture on the axis
                if(translation.y > 0 && segueDown != nil && whichSegue == nil){
                    whichSegue = "d"
                    print("Segue is : \(whichSegue!)")
                    viewController.performSegue(withIdentifier: segueDown!, sender: viewController)
                }
                else if(translation.y < 0 && segueUp != nil && whichSegue == nil){
                    whichSegue = "u"
                    print("Segue is : \(whichSegue!)")
                    viewController.performSegue(withIdentifier: segueUp!, sender: viewController)
                }
            }
            
            //If horizontal axis determined
            else if(axis == "h"){
                
                //set direction and corresponding segue of the gesture on the axis
                if(translation.x > 0 && segueLeft != nil && whichSegue == nil){
                    whichSegue = "l"
                    print("Segue is : \(whichSegue!)")
                    viewController.performSegue(withIdentifier: segueLeft!, sender: viewController)
                }
                else if(translation.x < 0 && segueRight != nil && whichSegue == nil){
                    whichSegue = "r"
                    print("Segue is : \(whichSegue!)")
                    viewController.performSegue(withIdentifier: segueRight!, sender: viewController)
                }
                
            }
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            
            print("TRANSACTION CANCELED")
            interactionInProgress = false
            
            cancel()
            
        case .ended:
            
            interactionInProgress = false
            
            //Print final recorded velocty at the end of gesture
            print("velocityX: \(velocityX)")
            print("velocityY: \(velocityY)")
            
            
            //Vertical velocity segue trigger
            if((velocityY < (-500) && whichSegue == "u") || (velocityY > (500) && whichSegue == "d")){
                print("triggered Vertical velocity!")
                shouldCompleteTransition = true
                whichSegue = nil
                axis = nil
            }
                
                //Horiontal velocity segue trigger
            else if((velocityX > (500) && whichSegue == "l") || (velocityX < (-500) && whichSegue == "r")){
                print("triggered Horizontal velocity!")
                shouldCompleteTransition = true
                whichSegue = nil
                axis = nil
            }
                
                //No velocity trigger detected!
            else {
                print("no velocity trigger!")
                whichSegue = nil
                axis = nil
            }
            
            
            if !shouldCompleteTransition {
                print("TRANSACTION ENDED WITH 'SHOULD NOT COMPLETE'")
                
                cancel()
            } else {
                
                print("TRANSACTION SUCCESSFULLY FINISHED")
                finish()
            }
            
        default:
            print("Unsupported")
        }
    }

    
}
