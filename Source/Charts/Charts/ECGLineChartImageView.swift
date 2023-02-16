//
//  ECGLineChartImageView.swift
//  Charts
//
//  Created by Dov Goldberg on 16/02/2023.
//

import Foundation
import CoreGraphics
import UIKit

/// Chart that draws lines, surfaces, circles, ...
open class ECGLineChartImageView: BarLineChartViewBase, LineChartDataProvider
{
    internal override func initialize()
    {
        super.initialize()
        
        renderer = LineChartRenderer(dataProvider: self, animator: chartAnimator, viewPortHandler: viewPortHandler)
    }
    
    // MARK: - LineChartDataProvider
    
    open var lineData: LineChartData? { return data as? LineChartData }
    var context: CGContext?
    override open func draw(_ rect: CGRect) {
        // DO NOTHING
        print("DOVG: don't draw line chart")
        let optionalContext = UIGraphicsGetCurrentContext()
        guard let context = optionalContext else {
            return
        }
        self.context = context
    }
    
    public func chartImage(_ rect: CGRect, dataSet: LineChartDataSet, completion: @escaping (UIImage?)->()) {
        guard data != nil, let renderer = renderer else {
            completion(nil)
            return
        }
        
        guard let context = context else { return }
        
//        guard let lineData = dataProvider?.lineData else { return nil }
//
//        let sets = lineData.dataSets as? [LineChartDataSet]
        DispatchQueue.global().async {
            (renderer as! LineChartRenderer).drawDataSet(context: context, dataSet: dataSet)
            guard let image = context.makeImage() else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                let uiImage = UIImage(cgImage: image)

                completion(uiImage)
            }
        }
        
        
//        renderer.drawData(context: context)
        
//        if clipValuesToContentEnabled
//        {
//            context.saveGState()
//            context.clip(to: CGRect(x: 0, y: 0, width: , height: <#T##CGFloat#>))
//
//            renderer.drawValues(context: context)
//
//            context.restoreGState()
//        }
//        else
//        {
//            renderer.drawValues(context: context)
//        }

//        legendRenderer.renderLegend(context: context)
//
//        drawMarkers(context: context)
        
        
        
        
    }
}
