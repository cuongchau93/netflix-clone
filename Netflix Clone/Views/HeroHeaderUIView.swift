//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Cuong Chau on 2024/07/30.
//

import UIKit

class HeroHeaderUIView: UIView {

    private let playButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle("Play", for: .normal)
        uiButton.layer.borderColor = UIColor.white.cgColor
        uiButton.layer.borderWidth = 1
        uiButton.layer.cornerRadius = 5
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        return uiButton
    }()
    
    private let downloadButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle("Download", for: .normal)
        uiButton.layer.borderColor = UIColor.white.cgColor
        uiButton.layer.borderWidth = 1
        uiButton.layer.cornerRadius = 5
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        return uiButton
    }()
    
    private let heroImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            (UIColor(named: "backgroundColor") ?? UIColor.systemBackground).cgColor // not responsive when switching between Dark & Light
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
