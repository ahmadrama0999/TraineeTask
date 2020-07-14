//
//  CircleVIew.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 09.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit


final class CircleView: UIView {
    
    var circleLayer = CAShapeLayer()
    var allClouds = [UIImageView]()
    var allLabels = [UILabel]()
    let trackLayer = CAShapeLayer()
    let angles = [(CGFloat.pi / 3), (CGFloat.pi / 6), 0.0, (11 * CGFloat.pi / 6), (5 * CGFloat.pi / 3), (3 * CGFloat.pi / 2),
                  (4 * CGFloat.pi / 3), (7 * CGFloat.pi / 6), (CGFloat.pi), (5 * CGFloat.pi / 6), (2 * CGFloat.pi / 3)]
    
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
    
    //Animate main circle
    private func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        circleLayer.strokeEnd = animation.toValue as! CGFloat
        
        // Do the actual animation
        DispatchQueue.main.async {
            CircleView.circle.circleLayer.add(animation, forKey: "animateCircle")
            CircleView.circle.trackLayer.add(animation, forKey: "someBasicAnimation")
        }
    }
    
    //Animate others obj
    private func animateImage(weatherData: Circle.Something.ViewModel) {
        allLabels.removeAll()
        allClouds.removeAll()
        let data = weatherData
        let path = UIBezierPath()
        let imagePoint: CGFloat = 140
        let inRadius: CGFloat = 95
        let tempPoint: CGFloat = 70
        let outRadius: CGFloat = 100
        for (index, item) in angles.enumerated() {
            let inner = CGPoint(x: inRadius * cos(item) + frame.size.width / 2.0, y: inRadius * sin(item) + frame.size.height / 2.0)
            let outer = CGPoint(x: outRadius * cos(item) + frame.size.width / 2.0, y: outRadius * sin(item)  + frame.size.height / 2.0)
            let tempCenter = CGPoint(x: tempPoint * cos(item) + frame.size.width / 2.0, y: tempPoint * sin(item)  + frame.size.height / 2.0)
            let imageCenter = CGPoint(x: imagePoint * cos(item) + frame.size.width / 2.0, y: imagePoint * sin(item)  + frame.size.height / 2.0)
            path.move(to: inner)
            path.addLine(to: outer)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            label.center = tempCenter
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14)
            label.alpha = 0
            allLabels.append(label)
            
            label.text = convertTemp(temp: data.temp[index], from: .kelvin, to: .celsius)
            print(data.cityName)
            print(convertTemp(temp: data.temp[index], from: .kelvin, to: .celsius))
            CircleView.circle.addSubview(label)
            
            
            let imageView = UIImageView(image: UIImage(named: data.weatherDescription[index]))
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            imageView.center = imageCenter
            imageView.contentMode = .scaleAspectFit
            imageView.alpha = 0
            allClouds.append(imageView)
            CircleView.circle.addSubview(imageView)
            
            
            
            let timeInterval = (3.0 / 11.0)
            var runCount = 0
            
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {[weak self] timer in
                UIView.animate(withDuration: 0.15) {
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
        trackLayer.lineWidth = 5
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        trackLayer.lineCap = .square
        trackLayer.fillColor = UIColor.clear.cgColor
        CircleView.circle.layer.addSublayer(trackLayer)
    }
    
    
    func start(weatherResponse: Circle.Something.ViewModel) {
        circleLayer.strokeEnd = 0.0
        allClouds.forEach { $0.alpha = 0}
        allLabels.forEach { $0.alpha = 0}
        animateCircle(duration: 3)
        animateImage(weatherData: weatherResponse )
    }
    
    private func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }
    
}
