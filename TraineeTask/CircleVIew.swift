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
    var allLabels = [UILabel]()
    let trackLayer = CAShapeLayer()
    let angles = [(CGFloat.pi / 3), (CGFloat.pi / 6), 0.0, (11 * CGFloat.pi / 6), (5 * CGFloat.pi / 3), (3 * CGFloat.pi / 2),
                  (4 * CGFloat.pi / 3), (7 * CGFloat.pi / 6), (CGFloat.pi), (5 * CGFloat.pi / 6), (2 * CGFloat.pi / 3)]
    let numbersOfClock = [5,4,3,2,1,12,11,10,9,8,7]
    
    static var circle = CircleView(frame:  CGRect(x: 90, y: 250, width: 300 , height: 300))
    
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
        circleLayer.strokeColor = UIColor.systemGray.cgColor
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
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        //        animation.autoreverses = true
        
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = animation.toValue as! CGFloat
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
        trackLayer.add(animation, forKey: "someBasicAnimation")
    }
    
    private func animateImage() {
        
        self.backgroundColor = .yellow
        
        let path = UIBezierPath()
        let imagePoint: CGFloat = 140
        let innerRadius: CGFloat = 95
        let numberPoint: CGFloat = 75
        let outerRadius: CGFloat = 100
        for (index, item) in angles.enumerated() {
            let inner = CGPoint(x: innerRadius * cos(item) + frame.size.width / 2.0, y: innerRadius * sin(item) + frame.size.height / 2.0)
            let outer = CGPoint(x: outerRadius * cos(item) + frame.size.width / 2.0, y: outerRadius * sin(item)  + frame.size.height / 2.0)
            let numberCenter = CGPoint(x: numberPoint * cos(item) + frame.size.width / 2.0, y: numberPoint * sin(item)  + frame.size.height / 2.0)
            let imageCenter = CGPoint(x: imagePoint * cos(item) + frame.size.width / 2.0, y: imagePoint * sin(item)  + frame.size.height / 2.0)
            path.move(to: inner)
            path.addLine(to: outer)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            label.center = numberCenter
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 16)
            label.alpha = 0
            allLabels.append(label)
            label.text = "\(numbersOfClock[index])"
            self.addSubview(label)
            
            let imageView = UIImageView(image: UIImage(named: "sun"))
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            imageView.center = imageCenter
            imageView.contentMode = .scaleAspectFit
            imageView.alpha = 0
            allClouds.append(imageView)
            self.addSubview(imageView)
            
            let timeInterval = (3.0 / 11.0)
            var runCount = 0
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {[weak self] timer in
                UIView.animate(withDuration: 0.3) {
                    self?.allLabels[runCount].alpha = 1
                    self?.allClouds[runCount].alpha = 1
                    
                }
                let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
                rotation.toValue = Double.pi * 2
                rotation.duration = 1
                self?.allClouds[runCount].layer.add(rotation, forKey: "rotationAnimation")
                runCount += 1
                if runCount == 11 {
                    timer.invalidate()
                }
            }
            
        }
        
        trackLayer.strokeEnd = 0
        trackLayer.lineWidth = 10
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        trackLayer.lineCap = .square
        trackLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(trackLayer)
    }
    
    func start() {
        circleLayer.strokeEnd = 0.0
        allClouds.forEach { $0.alpha = 0}
        allLabels.forEach { $0.alpha = 0}
        animateCircle(duration: 3)
        animateImage()
    }
    
}
