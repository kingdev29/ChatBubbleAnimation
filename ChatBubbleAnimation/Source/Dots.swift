//
//  Dots.swift
//  ChatBubbleAnimation
//
//  Created by liusilan on 16/5/6.
//  Copyright © 2016年 YY Inc. All rights reserved.
//

import Foundation
import UIKit

class Dots: UIView {

    private var dotLayer: CALayer = CALayer()
    var dotColor = UIColor.blackColor() {
        didSet {
            dotLayer.backgroundColor = dotColor.CGColor
        }
    }

    private var replicatorLayer: CAReplicatorLayer {
        get {
            return layer as! CAReplicatorLayer
        }
    }

    override class func layerClass() -> AnyClass {
        return CAReplicatorLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        replicatorLayer.backgroundColor = UIColor.clearColor().CGColor
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(dotSize() * 1.6, 0, 0)
        replicatorLayer.instanceDelay = 0.1

        dotLayer = CALayer()
        dotLayer.bounds = CGRectMake(0, 0, dotSize(), dotSize())
        dotLayer.position = CGPointMake(center.x - dotSize() * 1.6, center.y + dotSize() * 0.2)
        dotLayer.cornerRadius = dotSize() / 2
        dotLayer.backgroundColor = dotColor.CGColor

        replicatorLayer.addSublayer(dotLayer)

        animationStart()
    }

    private func dotSize() -> CGFloat {
        return self.bounds.size.width / 10
    }

    private func animationStart() {

        let move = AnimationHelper.createAnimation(.yPosition, fromValue: dotLayer.position.y, toValue: dotLayer.position.y - dotSize(), duration: 0.5)

        let alpha = AnimationHelper.createAnimation(.opacity, fromValue: 1, toValue: 0, duration: 0.5)

        let scale = AnimationHelper.createAnimation(.scale, fromValue: 1, toValue: 1.3, duration: 0.5)

        let animationGroup = AnimationHelper.animationGroup(0.5, name: "up", animations: [move, alpha, scale])
        animationGroup.delegate = self
        dotLayer.addAnimation(animationGroup, forKey: "dotAniamtion")
    }

    private func animationEnd() {

        let move = AnimationHelper.createAnimation(.yPosition, fromValue: dotLayer.position.y + dotSize(), toValue: dotLayer.position.y, duration: 0.2)

        let alpha = AnimationHelper.createAnimation(.opacity, fromValue: 0, toValue: 1, duration: 0.5)

        let scale = AnimationHelper.createAnimation(.scale, fromValue: 0.5, toValue: 1.0, duration: 0.3)

        let animationGroup = AnimationHelper.animationGroup(0.8, name: "down", animations: [move, alpha, scale])
        animationGroup.delegate = self
        dotLayer.addAnimation(animationGroup, forKey: "dotAniamtion")
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let value = anim.valueForKey("animation") as? String {
            if value == "up" {
                animationEnd()
            } else if value == "down" {
                animationStart()
            }
        }
    }
}