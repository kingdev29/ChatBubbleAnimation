//
//  CGPathRescale.swift
//  ChatBubbleAnimation
//
//  Created by liusilan on 16/5/6.
//  Copyright © 2016年 YY Inc. All rights reserved.
//

import Foundation
import UIKit

extension CGPath {
    //scaling :http://www.google.com/url?q=http%3A%2F%2Fstackoverflow.com%2Fquestions%2F15643626%2Fscale-cgpath-to-fit-uiview&sa=D&sntz=1&usg=AFQjCNGKPDZfy0-_lkrj3IfWrTGp96QIFQ
    //nice answer from David Rönnqvist!
    class func rescaleForFrame(path: CGPath, frame: CGRect) -> CGPath {
        let boundingBox = CGPathGetBoundingBox(path)
        print("boundingBox:\(boundingBox), frame:\(frame)")
        let boundingBoxAspectRatio = CGRectGetWidth(boundingBox)/CGRectGetHeight(boundingBox)
        let viewAspectRatio = CGRectGetWidth(frame)/CGRectGetHeight(frame)

        var scaleFactor: CGFloat = 1.0;
        if (boundingBoxAspectRatio > viewAspectRatio) {
            scaleFactor = CGRectGetWidth(frame)/CGRectGetWidth(boundingBox)
        } else {
            scaleFactor = CGRectGetHeight(frame)/CGRectGetHeight(boundingBox)
        }

        var scaleTransform = CGAffineTransformIdentity
        scaleTransform = CGAffineTransformScale(scaleTransform, scaleFactor, scaleFactor)
        scaleTransform = CGAffineTransformTranslate(scaleTransform, -CGRectGetMinX(boundingBox), -CGRectGetMinY(boundingBox))
        let scaledSize = CGSizeApplyAffineTransform(boundingBox.size, CGAffineTransformMakeScale(scaleFactor, scaleFactor))
        let centerOffset = CGSizeMake((CGRectGetWidth(frame)-scaledSize.width)/(scaleFactor*2.0), (CGRectGetHeight(frame)-scaledSize.height)/(scaleFactor*2.0))
        scaleTransform = CGAffineTransformTranslate(scaleTransform, centerOffset.width, centerOffset.height)
        if let resultPath = CGPathCreateCopyByTransformingPath(path, &scaleTransform) {

            print("result:\(CGPathGetBoundingBox(resultPath))")

            return resultPath
        }

        return path
    }
}
