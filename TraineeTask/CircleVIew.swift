//
//  CircleVIew.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 09.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit


final class CircleView: UIView {
    
    var circleLayer: CAShapeLayer!
    var allClouds = [UIImageView]()
    let angles = [(CGFloat.pi / 3), (CGFloat.pi / 6), 0.0, (11 * CGFloat.pi / 6), (5 * CGFloat.pi / 3), (3 * CGFloat.pi / 2),
                  (4 * CGFloat.pi / 3), (7 * CGFloat.pi / 6), (CGFloat.pi), (5 * CGFloat.pi / 6), (2 * CGFloat.pi / 3)]
    
    static var circle = CircleView(frame:  CGRect(x: 90, y: 250, width: 400 , height: 400))
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/3,startAngle: CGFloat.pi/3, endAngle: 2 * CGFloat.pi / 3, clockwise: false)
        
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 10.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
    }
    
    private func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        animation.byValue = 0.25
        //        animation.autoreverses = true
        
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = animation.toValue as! CGFloat
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    private func animateImage() {
        
        let path = UIBezierPath()
        let imagePoint: CGFloat = 185
        let innerRadius: CGFloat = 150
        let numberPoint: CGFloat = 120
        let outerRadius: CGFloat = 151
        for (index, item) in angles.enumerated() {
            let inner = CGPoint(x: innerRadius * cos(item) + self.center.x, y: innerRadius * sin(item) + self.center.y)
            let outer = CGPoint(x: outerRadius * cos(item) + self.center.x, y: outerRadius * sin(item)  + self.center.y)
            let numberCenter = CGPoint(x: numberPoint * cos(item) + self.center.x, y: numberPoint * sin(item)  + self.center.y)
            let imageCenter = CGPoint(x: imagePoint * cos(item) + self.center.x, y: imagePoint * sin(item)  + self.center.y)
            path.move(to: inner)
            path.addLine(to: outer)
            
            //            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            //            label.center = numberCenter
            //            label.textAlignment = .center
            //            label.font = .systemFont(ofSize: 20)
            //            label.alpha = 0
            //            allLabels.append(label)
            //            label.text = "\(numbersOfClock[index])"
            //            view.addSubview(label)
            
            let imageView = UIImageView(image: UIImage(named: "sun"))
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            imageView.center = imageCenter
            imageView.contentMode = .scaleAspectFit
            imageView.alpha = 1
            allClouds.append(imageView)
            self.addSubview(imageView)
            
        }
    }
    
    func start() {
        circleLayer.strokeEnd = 0.0
        animateCircle(duration: 2.5)
        animateImage()
    }
    
}
