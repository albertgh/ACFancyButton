//
//  ACFancyButton.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/11/19.
//

import UIKit

open class ACFancyButton: UIControl {
    
    public func startAnimation() {
        bgLayer.startAnimation()
    }
    public func stopAnimation() {
        bgLayer.stopAnimation()
    }
    
    public var buttonCornerRadius: CGFloat?
    public var buttonAlpha: CGFloat?

    
    // Duration of each group animation loop
    public var animationDuration: CGFloat? {
        didSet{
            if let duration = animationDuration  {
                bgLayer.animationDuration = duration
            }
        }
    }
    
    // Button color schemes
    public var bakedColors: [[CGColor]]? {
        didSet{
            if let colors = bakedColors  {
                bgLayer.bakedColors = colors
            }
        }
    }
    
    
    public var imageViewScale: CGFloat = 1.0 {
        didSet{
            if imageViewScale < 0.0 {
                imageViewScale = 0.0
            } else if imageViewScale > 1.0 {
                imageViewScale = 1.0
            }
        }
    }
    
    public let visualEffectView: UIVisualEffectView = {
        var effect: UIVisualEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        if  #available(iOS 26.0, *) {
            effect = UIGlassEffect(style: .clear)
        }
        let view = UIVisualEffectView(effect: effect)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let bgLayer: ACFancyButtonAnimationLayer = ACFancyButtonAnimationLayer()
    
    // You should only set one of imageView or titleView.
    public let imageView: UIImageView = UIImageView(frame: .zero)
    
    // You should only set one of imageView or titleView.
    public let titleView: UILabel = UILabel()
    
    
    // MARK: Life Cycle
    deinit {
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if var imageSize = imageView.image?.size {
            imageSize.width = imageSize.width * imageViewScale
            imageSize.height = imageSize.height * imageViewScale
            imageView.frame.size = imageSize
            imageView.frame.origin = CGPoint(x: (bounds.size.width - imageSize.width) / 2.0,
                                             y: (bounds.size.height - imageSize.height) / 2.0)
        }
        
        bgLayer.frame = bounds
        bgLayer.opacity = Float(buttonAlpha ?? 1.0)
        
        let theCornerRadius = buttonCornerRadius ?? (bounds.size.height / 2.0)
        bgLayer.cornerRadius = theCornerRadius
        
        
        visualEffectView.frame = bounds
        visualEffectView.layer.cornerRadius = theCornerRadius
        visualEffectView.layer.masksToBounds = true // This is crucial for rounding the corners
        
        
        titleView.frame = bounds
        titleView.textAlignment = .center
    }
}

// MARK: setup
extension ACFancyButton {
    private func setupSubviews() {
        addSubview(visualEffectView)

        layer.addSublayer(bgLayer)
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        addSubview(titleView)
        titleView.backgroundColor = .clear
    }
}
