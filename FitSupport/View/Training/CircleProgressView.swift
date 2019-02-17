//
//  CircleProgressView.swift
//  FitSupport
//
//  Created by Daulet on 03.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//
import UIKit

class CircleProgressView: UIView, Customizable {
    
    let desiredLineWidth:CGFloat = 4
    
    lazy var percentageRate: UILabel = {
        let label = UILabel(frame: bounds)
        label.font = UIFont(name: "OpenSans", size: self.bounds.height/3 - desiredLineWidth*2)
        label.textAlignment = .center
        label.textColor = UIColor.darkBlue
        return label
    }()
    
    override func awakeFromNib() {
        setupViews()
    }
    
    internal func setupViews() {
        addSubview(percentageRate)
        sendSubview(toBack: percentageRate)
    }
    
    func setProgress(percent rate: Int) {
        drawCircleInView()
        drawCircleInView(progress: rate, and: UIColor.lightyBlue)
        percentageRate.text = "\(rate)%"
        setNeedsDisplay()
    }
    
    private func drawCircleInView(progress percent: Int = 100, and color: UIColor = UIColor.lightyGray) {
        let endAngle: CGFloat = .pi * 2 / 100 * CGFloat(percent) - .pi / 2
        let halfSize = min(bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = 4
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: halfSize, y: halfSize), radius: (halfSize - desiredLineWidth * 2), startAngle: -.pi / 2, endAngle: endAngle, clockwise: true)
    
        let shape = CAShapeLayer()
        shape.path = circle.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = color.cgColor
        shape.lineWidth = desiredLineWidth
        
        layer.addSublayer(shape)
    }
    
}
