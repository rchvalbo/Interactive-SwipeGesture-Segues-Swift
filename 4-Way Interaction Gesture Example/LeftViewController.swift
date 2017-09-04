//
//  LeftViewController.swift
//  4-Way Interaction Gesture Example
//
//  Created by Roman Chvalbo on 9/4/17.
//  Copyright © 2017 SapienSolutions, LLC. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    var transition: UIViewControllerAnimatedTransitioning?

    let swipeInteractionController = SwipeInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        swipeInteractionController.wireToViewController(viewController: self, segueUp: nil, segueDown: nil, segueLeft: "back", segueRight: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "back"){
            
            //Set the transition class to use
            transition = SlideLeftAnimator()
            
            //Assign the delegate to the next viewController
            let nextVC = segue.destination as! ViewController
            nextVC.transitioningDelegate = self
        }
    }

}

extension LeftViewController: UIViewControllerTransitioningDelegate {
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
    
    
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
}
