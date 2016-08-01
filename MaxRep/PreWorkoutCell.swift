//
//  PreWorkoutCell.swift
//  MaxRep
//
//  Created by Rixing Wu on 7/20/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit
import ChameleonFramework

enum LineDirect {
    case Up, Down, Both
}





@IBDesignable class PreWorkoutCell: UITableViewCell {
    @IBInspectable var defaultColor = UIColor.flatGrayColor()
    @IBInspectable var fillColor = UIColor.flatNavyBlueColor()
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var title: UILabel!
    var connector : LineDirect?
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawRingFittingInsideView(indicatorView.frame)
    }
    
    
    
    func makeLineFrom(point: CGPoint, length: CGFloat) -> UIBezierPath{
        let line = UIBezierPath()
        let uPstart = CGPoint(x: point.x, y: point.y - length)
        let dPstart = CGPoint(x: point.x, y: point.y + length)
        
        let uPend = CGPoint(x: point.x, y: 0)
        let dPend = CGPoint(x: point.x, y: indicatorView.frame.height)
        
        func link(p1: CGPoint, p2: CGPoint){
            line.moveToPoint(p1)
            line.addLineToPoint(p2)
        }
        
        switch self.connector! {
        case .Up:
            link(uPstart, p2: uPend); break
        case .Down:
            link(dPstart, p2: dPend); break
        default:
             link(uPstart, p2: uPend)
             link(dPstart, p2: dPend)
        }
        
        return line
    }
    
    
    internal func drawRingFittingInsideView(rect: CGRect)
    {
        let desiredLineWidth:CGFloat = 1   // your desired value
        let hw:CGFloat = desiredLineWidth/2.0 + 15.0
        
        let drawArea = CGRectInset(rect,hw,hw)
        let circlePath = UIBezierPath(ovalInRect: drawArea)
        
        if let _ = connector{
            let start = CGPoint(x: CGRectGetMidX(drawArea), y: CGRectGetMidY(drawArea))
            let l =  hw/2.0
            let line = makeLineFrom(start, length: l)
            circlePath.appendPath(line)
        }
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = defaultColor.CGColor
        shapeLayer.lineWidth = desiredLineWidth
        
        indicatorView.layer.addSublayer(shapeLayer)
    }
}
