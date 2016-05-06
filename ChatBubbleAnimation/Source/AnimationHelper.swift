//
//  AnimationHelper.swift
//  ChatBubbleAnimation
//
//  Created by liusilan on 16/5/6.
//  Copyright © 2016年 YY Inc. All rights reserved.
//

import Foundation
import UIKit

enum AnimationKeyPath: String {
    case scale = "transform.scale"
    case yPosition = "position.y"
    case opacity = "opacity"
}

struct AnimationHelper {

    static func createAnimation(animationKeyPath: AnimationKeyPath, fromValue: CGFloat, toValue: CGFloat, duration: CFTimeInterval) -> CASpringAnimation {

        let animation = CASpringAnimation(keyPath: animationKeyPath.rawValue)
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeBoth

        return animation
    }

    static func animationGroup(duration: CFTimeInterval, name: String, animations: [CASpringAnimation]) -> CAAnimationGroup {

        let animationGroup = CAAnimationGroup()

        animationGroup.duration = duration
        animationGroup.animations = animations
        animationGroup.removedOnCompletion = false
        animationGroup.fillMode = kCAFillModeBoth
        animationGroup.setValue(name, forKey: "animation")
//        animationGroup.repeatCount = MAXFLOAT
        return animationGroup
    }
}