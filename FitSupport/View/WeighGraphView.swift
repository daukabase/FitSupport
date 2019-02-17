//
//  WeighGraphView.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import Foundation
import UIKit
import ScrollableGraphView
import Social

class WeighGraphView: Customizable, ScrollableGraphView, ScrollableGraphViewDataSource {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addPlot(plot: linePlot)
        self.addPlot(plot: dotsPlot)
        self.addReferenceLines(referenceLines: referenseLines)
    }
    
    func commonInit() {
        dataSource = self
        bottomMargin = 16
        topMargin = 16
        rangeMax = weights.max() ??  Double(self.frame.height - 16 + 4)
        rangeMin = weights.min() ??  16 - 4
        shouldAdaptRange = true
        shouldAnimateOnAdapt = true
        shouldAnimateOnStartup = true
        dataPointSpacing = 20
        tintColor = UIColor.red
        backgroundFillColor = GlobalColors.darkBlue.color()
    }
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch plot.identifier {
        case "weight":
            return weights[pointIndex]
        case "weightDot":
            return weights[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "\(pointIndex+1)"
    }
    
    func numberOfPoints() -> Int {
        return weights.count
    }
    
    var weights: [Double] = []{
        didSet {
            self.reloadInputViews()
        }
    }
    
    let animationDuration = 0.8
    
    lazy var linePlot: LinePlot = {
        let line = LinePlot(identifier: "weight")
        line.adaptAnimationType = ScrollableGraphViewAnimationType.easeOut
        line.animationDuration = animationDuration
        line.lineStyle = .smooth
        line.lineColor = GlobalColors.lightyBlue.color()
        line.fillColor = GlobalColors.whity.color()
        return line
    }()
    lazy var dotsPlot: DotPlot = {
        let dot = DotPlot(identifier: "weightDot")
        dot.dataPointFillColor = GlobalColors.lightyGray.color()
        dot.dataPointSize = self.frame.height / 100
        dot.animationDuration = animationDuration
        return dot
    }()
    lazy var referenseLines: ReferenceLines = {
        let reference = ReferenceLines()
        reference.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        reference.dataPointLabelColor = GlobalColors.lightyBlue.color()
        reference.referenceLineColor = GlobalColors.lightyBlue.color()
        reference.referenceLineLabelColor = GlobalColors.lightyBlue.color()
        reference.dataPointLabelFont = UIFont(name: "OpenSans-Bold", size: 10)
        reference.referenceLineLabelFont = UIFont(name: "OpenSans-Bold", size: 10)!
        return reference
    }()
    

}
