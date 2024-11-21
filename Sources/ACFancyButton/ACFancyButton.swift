//
//  ACFancyButton.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/11/19.
//

import UIKit

class ACFancyButton: UIControl {
    
    // MARK: public
    func startAnimation() {
        bgLayer.startAnimation()
    }
    func stopAnimation() {
        bgLayer.stopAnimation()
    }

    
    // MARK: property
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
    var bgLayer: ACFancyButtonAnimationLayer = ACFancyButtonAnimationLayer()

    // MARK: Life Cycle
    deinit {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if var imageSize = imageView.image?.size {
            imageSize.width = imageSize.width * imageViewScale
            imageSize.height = imageSize.height * imageViewScale
            imageView.frame.size = imageSize
            imageView.frame.origin = CGPoint(x: (bounds.size.width - imageSize.width) / 2.0,
                                             y: (bounds.size.height - imageSize.height) / 2.0)
        }
        
        bgLayer.frame = bounds
        bgLayer.cornerRadius = (bounds.size.height / 2.0)
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
