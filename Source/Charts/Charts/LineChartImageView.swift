//
//  LineChartImageView.swift
//  Charts
//
//  Created by Dov Goldberg on 16/02/2023.
//

import Foundation
import CoreGraphics
import UIKit

/// Chart that draws lines, surfaces, circles, ...
open class LineChartImageView: BarLineChartViewBase, LineChartDataProvider
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
    
    public func chartImage(_ rect: CGRect, completion: @escaping (UIImage?)->()) {
        
        
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
            let optionalContext = UIGraphicsGetCurrentContext()
            guard let context = optionalContext else {
                completion(nil)
                return
            }
            super.draw(in: context)
            guard let image = context.makeImage() else {
                completion(nil)
                return
            }
            
            let uiImage = UIImage(cgImage: image)
            
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                completion(uiImage)
            }
        }
    }
}
