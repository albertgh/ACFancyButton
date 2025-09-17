//
//  ACFancyButtonAnimationLayer.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/11/19.
//

import UIKit

private struct ACFBLayerConstant {
    static let animationDuration: TimeInterval = 4.0

    static let bakedColors: [[CGColor]] = [
        [UIColor(red: 28/255.0, green: 74/255.0, blue: 219/255.0, alpha: 1.0).cgColor,
         UIColor(red: 224/255.0, green: 24/255.0, blue: 24/255.0, alpha: 1.0).cgColor],
        
        [UIColor(red: 236/255.0, green: 54/255.0, blue: 220/255.0, alpha: 1.0).cgColor,
         UIColor(red: 255/255.0, green: 148/255.0, blue: 0/255.0, alpha: 1.0).cgColor],
        
        [UIColor(red: 27/255.0, green: 241/255.0, blue: 245/255.0, alpha: 1.0).cgColor,
         UIColor(red: 250/255.0, green: 20/255.0, blue: 166/255.0, alpha: 1.0).cgColor],
        
        [UIColor(red: 143/255.0, green: 4/255.0, blue: 15/255.0, alpha: 1.0).cgColor,
         UIColor(red: 156/255.0, green: 200/255.0, blue: 230/255.0, alpha: 1.0).cgColor]
    ]

    static let animationKeyTimes = [
        NSNumber(value: 0.0),
        NSNumber(value: 0.1),
        NSNumber(value: 0.9),
        NSNumber(value: 1.0),
    ]
    
    static let ACFBAnimationKey = "ACFBAnimationKey"
    static let ACFBPointAnimationKey = "ACFBPointAnimationKey"
}

public final class ACFancyButtonAnimationLayer: CAGradientLayer {
    
    // Explicit designated initializer
    public override init() {
        super.init()
        // your setup code if needed
    }
    
    // Required init for CALayer subclasses
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Optional: also expose init(layer:) if needed
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    func startAnimation() {
        startColorAnimation()
        startPointAnimation()
    }
    func stopAnimation() {
        removeAllAnimations()
    }
    
    // MARK: property
    var animationDuration: CGFloat = ACFBLayerConstant.animationDuration {
        didSet {
            colorsAnimation.duration = animationDuration
        }
    }
    var bakedColors: [[CGColor]] = ACFBLayerConstant.bakedColors

    
    let animationKeyTimes = ACFBLayerConstant.animationKeyTimes
    
    
    var currentColor: [CGColor] {
        return bakedColors[(gradientColorIndex % bakedColors.count)].compactMap { $0 }
    }
    
    var gradientColorIndex = 0
    
    let colorsAnimation = CAKeyframeAnimation(keyPath: "colors")
        
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
        
        colorsAnimation.duration = animationDuration
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
        
        let start = CAKeyframeAnimation(keyPath: "startPoint")
        start.values = [startFromValue, startFromValue, startToValue, startToValue]
        start.keyTimes = animationKeyTimes
        start.calculationMode = CAAnimationCalculationMode.linear
        
        let end = CAKeyframeAnimation(keyPath: "endPoint")
        end.values = [endFromValue, endFromValue, endToValue, endToValue]
        end.keyTimes = animationKeyTimes
        end.calculationMode = CAAnimationCalculationMode.linear
        
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = animationDuration
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
