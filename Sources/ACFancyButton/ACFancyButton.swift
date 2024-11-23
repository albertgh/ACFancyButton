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
    
    public let imageView: UIImageView = UIImageView(frame: .zero)
    
    let bgLayer: ACFancyButtonAnimationLayer = ACFancyButtonAnimationLayer()

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
        

        let theCornerRadius = buttonCornerRadius ?? (bounds.size.height / 2.0)
        bgLayer.cornerRadius = theCornerRadius
    }
}

// MARK: setup
extension ACFancyButton {
    private func setupSubviews() {
        layer.addSublayer(bgLayer)
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
    }
}
