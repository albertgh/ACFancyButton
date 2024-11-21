//
//  ACFancyButtonAnimationLayer.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/11/19.
//

import UIKit

private struct ACFBLayerConstant {
    public static let animationDuration: TimeInterval = 4.0

    public static let ACFBAnimationKey = "ACFBAnimationKey"
    public static let ACFBPointAnimationKey = "ACFBPointAnimationKey"

    public static let animationKeyTimes = [
        NSNumber(value: 0.0),
        NSNumber(value: 0.1),
        NSNumber(value: 0.9),
        NSNumber(value: 1.0),
    ]
    public static let bakedColors: [[CGColor]] = [
        [UIColor.hexStringCGColor(hex: "858CA2"),
         UIColor.hexStringCGColor(hex: "9F291E")],
        [UIColor.hexStringCGColor(hex: "876571"),
         UIColor.hexStringCGColor(hex: "451477")],
        [UIColor.hexStringCGColor(hex: "86390A"),
         UIColor.hexStringCGColor(hex: "A69B66")],
        [UIColor.hexStringCGColor(hex: "1E6E6B"),
         UIColor.hexStringCGColor(hex: "5F0B45")],
        [UIColor.hexStringCGColor(hex: "2B040F"),
         UIColor.hexStringCGColor(hex: "9CC6E5")]
    ]
}

final class ACFancyButtonAnimationLayer: CAGradientLayer {
    func startAnimation() {
        startColorAnimation()
        startPointAnimation()
    }
    func stopAnimation() {
        removeAllAnimations()
    }
    
    // MARK: property
    let animationKeyTimes = ACFBLayerConstant.animationKeyTimes
    
    let bakedColors: [[CGColor]] = ACFBLayerConstant.bakedColors
    
    var currentColor: [CGColor] {
        return bakedColors[(gradientColorIndex % bakedColors.count)].compactMap { $0 }
    }
    
    var gradientColorIndex = 0
    
    let colorsAnimation = CAKeyframeAnimation(keyPath: "acfb_colors")
        
    // MARK: Life Cycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init() {
        super.init()
        setupLayer()
    }
    override init(layer: Any) {
        super.init(layer: layer)
        setupLayer()
    }
}

// MARK: setup

extension ACFancyButtonAnimationLayer {
    func setupLayer() {
        let defaultStartPoint = CGPoint(x: 0.3, y: 0.3)
        colors = currentColor
        startPoint = defaultStartPoint
        endPoint = endPoint(for: defaultStartPoint)
        drawsAsynchronously = true
        
        colorsAnimation.duration = ACFBLayerConstant.animationDuration
        colorsAnimation.fillMode = CAMediaTimingFillMode.forwards
        colorsAnimation.isRemovedOnCompletion = false
        colorsAnimation.delegate = self
        colorsAnimation.keyTimes = animationKeyTimes
        colorsAnimation.calculationMode = CAAnimationCalculationMode.linear
    }
}

// MARK: Delegate
extension ACFancyButtonAnimationLayer: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removeAnimation(forKey: ACFBLayerConstant.ACFBAnimationKey)
        startColorAnimation()
    }
}

// MARK: Animation
extension ACFancyButtonAnimationLayer {
    func startColorAnimation() {
        let fromColors = currentColor
        gradientColorIndex += 1
        let toColors = currentColor
        colorsAnimation.values = [fromColors, fromColors, toColors, toColors]
        add(colorsAnimation, forKey: ACFBLayerConstant.ACFBAnimationKey)
    }
    func startPointAnimation() {
        let startFromValue = CGPoint(x: 0.25, y: 0.05)
        let startToValue = CGPoint(x: 0.75, y: 0.05)
        
        let endFromValue = endPoint(for: startFromValue)
        let endToValue = endPoint(for: startToValue)
        
        let start = CAKeyframeAnimation(keyPath: "acfb_startPoint")
        start.values = [startFromValue, startFromValue, startToValue, startToValue]
        start.keyTimes = animationKeyTimes
        start.calculationMode = CAAnimationCalculationMode.linear
        
        let end = CAKeyframeAnimation(keyPath: "acfb_endPoint")
        end.values = [endFromValue, endFromValue, endToValue, endToValue]
        end.keyTimes = animationKeyTimes
        end.calculationMode = CAAnimationCalculationMode.linear
        
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = ACFBLayerConstant.animationDuration
        group.repeatCount = .infinity
        group.autoreverses = true
        group.isRemovedOnCompletion = false
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        add(group, forKey: ACFBLayerConstant.ACFBPointAnimationKey)
    }
    private func endPoint(for startPoint: CGPoint) -> CGPoint {
        return CGPoint(x: (1.0 - startPoint.x), y:  (1.0 - startPoint.y))
    }
}

// MARK: Util
private extension UIColor {
    static func hexStringCGColor(hex:String) -> CGColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray.cgColor
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        ).cgColor
    }
}
