//
//  ChatBubble.swift
//  ChatBubbleAnimation
//
//  Created by liusilan on 16/5/6.
//  Copyright © 2016年 YY Inc. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ChatBubble: UIView {

    private lazy var dots: Dots = Dots(frame: self.bounds)

    @IBInspectable var lineWidth: CGFloat = 5 {
        didSet {
            shapeLayer.lineWidth = lineWidth
        }
    }

    @IBInspectable var fillColor: UIColor = UIColor.clearColor() {
        didSet {
            shapeLayer.fillColor = fillColor.CGColor
        }
    }

    @IBInspectable var lineColor: UIColor = UIColor.blackColor() {
        didSet {
            shapeLayer.strokeColor = lineColor.CGColor
        }
    }

    @IBInspectable var dotColor: UIColor = UIColor.blackColor() {
        didSet {
            dots.dotColor = dotColor
        }
    }

    private var shapeLayer: CAShapeLayer {
        get  {
            return layer as! CAShapeLayer
        }
    }

    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
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
        backgroundColor = UIColor.clearColor()

        let bezierPath = bubbleBezierPath()
        shapeLayer.path = CGPath.rescaleForFrame(bezierPath.CGPath, frame: frame)
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.fillColor = fillColor.CGColor
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineWidth = lineWidth

        dots.dotColor = dotColor

        addSubview(dots)
    }

    private func bubbleBezierPath() -> UIBezierPath {

        let bezierPath = UIBezierPath()

        bezierPath.moveToPoint(CGPointMake(127.63, 28.23))
        bezierPath.addCurveToPoint(CGPointMake(127.63, 72.77), controlPoint1: CGPointMake(140.12, 40.53), controlPoint2: CGPointMake(140.12, 60.47))
        bezierPath.addCurveToPoint(CGPointMake(87.79, 77.06), controlPoint1: CGPointMake(116.81, 83.42), controlPoint2: CGPointMake(100.17, 84.85))
        bezierPath.addCurveToPoint(CGPointMake(74, 81), controlPoint1: CGPointMake(86.02, 77.56), controlPoint2: CGPointMake(74, 81))
        bezierPath.addCurveToPoint(CGPointMake(78.78, 68.57), controlPoint1: CGPointMake(74, 81), controlPoint2: CGPointMake(77.82, 71.07))
        bezierPath.addCurveToPoint(CGPointMake(73.17, 47.25), controlPoint1: CGPointMake(74.27, 62.24), controlPoint2: CGPointMake(72.4, 54.63))
        bezierPath.addCurveToPoint(CGPointMake(82.37, 28.23), controlPoint1: CGPointMake(73.9, 40.3), controlPoint2: CGPointMake(76.97, 33.55))
        bezierPath.addCurveToPoint(CGPointMake(127.63, 28.23), controlPoint1: CGPointMake(94.87, 15.92), controlPoint2: CGPointMake(115.13, 15.92))

        return bezierPath
    }
}