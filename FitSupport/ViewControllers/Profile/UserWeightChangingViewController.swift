
//
//  UserWeightChangingViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import ScrollableGraphView
class UserWeightChangingViewController: UIViewController, ScrollableGraphViewDataSource {
    
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
        return "Day \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return weights.count
    }
    
    @IBOutlet weak var weightGraph: ScrollableGraphView!
    
    var weights: [Double] = [30, 23]{
        didSet{
            if viewIfLoaded != nil {
                weightGraph.reload()
            }
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
        dot.dataPointSize = weightGraph.frame.height / 100
        dot.animationDuration = animationDuration
        return dot
    }()
    lazy var referenseLines: ReferenceLines = {
        let reference = ReferenceLines()
        return reference
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        weightGraph.dataSource = self
        weightGraph.bottomMargin = 16
        weightGraph.topMargin = 16
        weightGraph.rangeMax = weights.max() ??  Double(weightGraph.frame.height - 16 + 4)
        weightGraph.rangeMin = weights.min() ??  16 - 4
        weightGraph.shouldAdaptRange = true
        weightGraph.shouldAnimateOnAdapt = true
        weightGraph.shouldAnimateOnStartup = true
        weightGraph.tintColor = GlobalColors.lightyBlue.color()
//        weightGraph.layer.cornerRadius = 16
        weightGraph.addPlot(plot: linePlot)
        weightGraph.addPlot(plot: dotsPlot)
        weightGraph.addReferenceLines(referenceLines: referenseLines)
    }


}
