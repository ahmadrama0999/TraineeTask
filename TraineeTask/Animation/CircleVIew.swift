//
//  CircleVIew.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 09.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

enum PointPosition {
    static let imagePoint: CGFloat = 140
    static let inRadius: CGFloat = 95
    static let tempPoint: CGFloat = 70
    static let outRadius: CGFloat = 100
}

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
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/3,startAngle: CGFloat.pi/3, endAngle: 2 * CGFloat.pi / 3, clockwise: false)
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.systemGray.cgColor
        circleLayer.lineWidth = 10.0;
        circleLayer.strokeEnd = 0.0
        layer.addSublayer(circleLayer)
    }
    
    private func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        circleLayer.strokeEnd = animation.toValue as! CGFloat

        DispatchQueue.main.async {
            CircleView.circle.circleLayer.add(animation, forKey: "animateCircle")
            CircleView.circle.trackLayer.add(animation, forKey: "someBasicAnimation")
        }
    }
    
    private func animateImage(weatherData: Circle.Something.ViewModel) {
        allLabels.removeAll()
        allClouds.removeAll()
        let data = weatherData
        let path = UIBezierPath()
        for (index, item) in angles.enumerated() {
            let inner = CGPoint(x: PointPosition.inRadius * cos(item) + frame.size.width / 2.0, y: PointPosition.inRadius * sin(item) + frame.size.height / 2.0)
            let outer = CGPoint(x: PointPosition.outRadius * cos(item) + frame.size.width / 2.0, y: PointPosition.outRadius * sin(item)  + frame.size.height / 2.0)
            let tempCenter = CGPoint(x: PointPosition.tempPoint * cos(item) + frame.size.width / 2.0, y: PointPosition.tempPoint * sin(item)  + frame.size.height / 2.0)
            let imageCenter = CGPoint(x: PointPosition.imagePoint * cos(item) + frame.size.width / 2.0, y: PointPosition.imagePoint * sin(item)  + frame.size.height / 2.0)
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
