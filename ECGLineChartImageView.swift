//
//  ECGLineChartImageView.swift
//  Charts
//
//  Created by Dov Goldberg on 16/02/2023.
//

import Foundation
import CoreGraphics

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
    
    override open func draw(_ rect: CGRect) {
        // DO NOTHING
        print("DOVG: don't draw line chart")
    }
    
    func chartImage(_ rect: CGRect, dataSet: LineChartDataSet) -> UIImage? {
        guard data != nil, let renderer = renderer else { return nil }
        
        let optionalContext = UIGraphicsGetCurrentContext()
        guard let context = optionalContext else { return nil }

        context.setFillColor(UIColor.red.cgColor)
        context.fill(rect)
        
        
//        guard let lineData = dataProvider?.lineData else { return nil }
//
//        let sets = lineData.dataSets as? [LineChartDataSet]
        (renderer as! LineChartRenderer).drawDataSet(context: context, dataSet: dataSet)
        
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
        
        
        guard let image = context.makeImage() else { return nil }
        
        let uiImage = UIImage(cgImage: image)

        return uiImage
        
    }
}
