//
//  ViewController.swift
//  4-Way Interaction Gesture Example
//
//  Created by Roman Chvalbo on 9/4/17.
//  Copyright © 2017 SapienSolutions, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Initialize the transition and swipeInteractionController variables to be used
    var transition: UIViewControllerAnimatedTransitioning?

    let swipeInteractionController = SwipeInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //This is where the magic happens! This is how you wire the InteractionController to this viewController
         swipeInteractionController.wireToViewController(viewController: self, segueUp: "toDown", segueDown: "toUp", segueLeft: "toRight", segueRight: "toLeft")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "toLeft"){
        
            //Set the transition class to use
            transition = SlideRightAnimator()
            
            //Assign the delegate to the next viewController
            let nextVC = segue.destination as! LeftViewController
            nextVC.transitioningDelegate = self
        }
        else if(segue.identifier == "toRight"){
            
            //Set the transition class to use
            transition = SlideLeftAnimator()
            
            //Assign the delegate to the next viewController
            let nextVC = segue.destination as! RightViewController
            nextVC.transitioningDelegate = self
        }
        else if(segue.identifier == "toUp"){
            
            //Set the transition class to use
            transition = SlideDownAnimator()
            
            //Assign the delegate to the next viewController
            let nextVC = segue.destination as! UpViewController
            nextVC.transitioningDelegate = self
        }
        else if(segue.identifier == "toDown"){
            
            //Set the transition class to use
            transition = SlideUpAnimator()
            
            //Assign the delegate to the next viewController
            let nextVC = segue.destination as! DownViewController
            nextVC.transitioningDelegate = self
        }
    }


}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    //These two functions are super important! Make sure to include them in any viewController that will be using the SwipeInteractionController.swift file!!!!
    
    //1
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
    
    //2
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
    
    /*-------------------------------------------------------------------------------------------------*/
    
    //Transition delegate functions
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
}


