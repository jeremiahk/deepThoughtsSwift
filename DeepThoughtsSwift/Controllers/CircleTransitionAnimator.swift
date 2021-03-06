//
//  CircleTransitionAnimator.swift
//  DeepThoughtsSwift
//

import UIKit

final class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private var transitionContext: UIViewControllerContextTransitioning!

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        // Grab the viewControllers and take a snapshot of each.
        if  let fromViewController  = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView(),
            let button = (fromViewController as? hasCircleButton)?.getCircleButton() {
                
            createAnimation(fromViewController, toViewController: toViewController, containerView: containerView, button: button)
        }
    }

    private func createAnimation(fromViewController: UIViewController, toViewController: UIViewController, containerView: UIView, button: CircleButton) {
        let fromViewSnapshot = fromViewController.view.resizableSnapshotViewFromRect(fromViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        let toViewSnapshot = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)

        // ContainerView will hold the views during the transition
        containerView.addSubview(fromViewSnapshot)

        // circleView is the view that the mask will be applied to.
        let circleView = UIView(frame: containerView.frame)
        circleView.backgroundColor = toViewController.view.backgroundColor
        containerView.addSubview(circleView)

        let circleMaskPathInitial = UIBezierPath(ovalInRect: button.backgroundSize)
        let finalPoint = CGPoint(x: button.center.x, y: button.center.y - CGRectGetHeight(toViewController.view.bounds))
        let radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))

        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        circleView.layer.mask = maskLayer

        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")

        // Add the toViewControllerSnapshot to the circle view and animate it
        circleView.addSubview(toViewSnapshot)

        toViewSnapshot.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)
        toViewSnapshot.center = button.center
        toViewSnapshot.alpha = 0

        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            toViewSnapshot.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
            toViewSnapshot.center = containerView.center
            toViewSnapshot.alpha = 1.0
        }, completion: { _ in
            containerView.addSubview(toViewController.view)
        })
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext.completeTransition(true)
        self.transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
    }
}
