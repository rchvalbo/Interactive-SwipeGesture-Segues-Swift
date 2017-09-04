//
//  SlideRightAnimator.swift
//  Govi
//
//  Created by Feedr MacBook on 6/1/17.
//  Copyright © 2017 SapienSolutions, LLC. All rights reserved.
//

import UIKit

class SlideRightAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 0.2
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: .from)!
        
        let toView = transitionContext.view(forKey: .to)!
        
        containerView.addSubview(toView)
        
        fromView.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        toView.frame=CGRect(x:0 + UIScreen.main.bounds.size.width, y:0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut,
                       animations: {
                        fromView.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
                        toView.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        },
                       completion: { _ in
                        print("ANIMATION HAS REACHED THE COMPLETION BLOCK")
                        if(transitionContext.transitionWasCancelled){
                            
                            transitionContext.completeTransition(false)
                            
                            UIApplication.shared.keyWindow?.addSubview(fromView)
                        }
                            
                        else{
                            
                            transitionContext.completeTransition(true)
                            
                        }

        }
        )

    }
}
