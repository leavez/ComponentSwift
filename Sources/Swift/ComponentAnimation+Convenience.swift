//
//  ComponentAnimation+Convenience.swift
//  Pods
//
//  Created by Gao on 5/16/17.
//
//

import Foundation

extension ComponentAnimation {

    @nonobjc
    public convenience init(component: Component, animation: CAAnimation?, layerPath: String? = nil) {
        self.init(__component:component, animation: animation, layerPath: layerPath)
    }

    /// return nil when component is nil
    @nonobjc
    public convenience init?(component: Component?, animation: CAAnimation?, layerPath: String? = nil) {
        guard let component = component else {
            return nil
        }
        self.init(__component:component, animation: animation, layerPath: layerPath)
    }


    public convenience init<T, U>(willRemount: @escaping () -> T, didRemount: @escaping (T) -> U, cleanup: @escaping (U) -> Void) {
        self.init(__willRemount: { () -> Any? in
            willRemount()
        }, didRemount: { (context:Any?) -> Any? in
            didRemount(context as! T)
        }, cleanup: { (anonterContext:Any?) -> Void in
            cleanup(anonterContext as! U)
        })
    }


    /// Animation with previous component
    /// UIView animation could be used in the animation block.
    ///
    /// The previouseView is a snapshot of previous component's view before remount, have same frame
    /// and superView, and will be removed when animation is completed.
    /// NOTE: Do not pass the views out.
    @nonobjc
    public convenience init(previousComponent: Component?, component: Component,
                            animation:@escaping (_ previousView: UIView?, _ view: UIView?)->Void) {

        self.init(willRemount: { () -> UIView? in
            guard let previousView = previousComponent?.viewForAnimation() else {
                return nil
            }
            if let snapShot = previousView.snapshotView(afterScreenUpdates: false) {
                snapShot.frame = previousView.frame
                previousView.superview?.addSubview(snapShot)
                return snapShot
            }
            return nil

        }, didRemount: { (previousView: UIView?) -> UIView? in
            let view = component.viewForAnimation()
            animation(previousView, view)
            return previousView
        }, cleanup:{ (previous: UIView?) -> Void in
            previous?.removeFromSuperview()
        })
    }
}

