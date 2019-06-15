
//
//  UserWeightChangingViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import ScrollableGraphView

class UserWeightChangingViewController: UIViewController, Customizable {
    
    var weights: [Double] = [66, 66.8, 68, 68.7, 69]
    
    let animationDuration = 0.8
    
    func label(atIndex pointIndex: Int) -> String {
        return "Day \(pointIndex)"
    }
    
    @IBOutlet weak var weightGraph: ScrollableGraphView!
    
    lazy var linePlot: LinePlot = {
        let line = LinePlot(identifier: "weight")
        line.adaptAnimationType = ScrollableGraphViewAnimationType.easeOut
        line.animationDuration = animationDuration
        line.lineStyle = .smooth
        line.lineColor = UIColor.lightyBlue
        line.fillColor = UIColor.whity
        return line
    }()
    
    lazy var dotsPlot: DotPlot = {
        let dot = DotPlot(identifier: "weightDot")
        dot.dataPointFillColor = UIColor.lightyGray
        dot.dataPointSize = weightGraph.frame.height / 100
        dot.animationDuration = animationDuration
        return dot
    }()
    
    lazy var referenseLines = ReferenceLines()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit() {
        weightGraph.dataSource = self
        weightGraph.bottomMargin = 16
        weightGraph.topMargin = 16
        weightGraph.rangeMax = weights.max() ??  Double(weightGraph.frame.height - 16 + 4)
        weightGraph.rangeMin = weights.min() ??  16 - 4
        weightGraph.shouldAdaptRange = true
        weightGraph.shouldAnimateOnAdapt = true
        weightGraph.shouldAnimateOnStartup = true
        weightGraph.tintColor = UIColor.lightyBlue
        weightGraph.addPlot(plot: linePlot)
        weightGraph.addPlot(plot: dotsPlot)
        weightGraph.addReferenceLines(referenceLines: referenseLines)
    }
    
}

extension UserWeightChangingViewController: ScrollableGraphViewDataSource {
    
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
    
    func numberOfPoints() -> Int {
        return weights.count
    }
    
}
