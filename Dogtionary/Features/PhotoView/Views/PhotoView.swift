//
//  PhotoView.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit
import Kingfisher

final class PhotoView: UIView {
    //MARK: - Properties
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let doggyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    //MARK: - Life cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI setup
    
    private func setUpUI() {
        addSubview(doggyImageView)
        addSubview(closeButton)
        
        backgroundColor = .white
        
        closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        doggyImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        doggyImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        doggyImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        doggyImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    //MARK: - Configuration
    func configure(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        doggyImageView.kf.setImage(with: url, options: [.cacheOriginalImage])
    }
    
    //MARK: - Image pinch & pan gesture setups
    
    private func setUpGestureRecognizers() {
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        pinchGestureRecognizer.delegate = self
        doggyImageView.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.delegate = self
        doggyImageView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            view.transform = view.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
            gestureRecognizer.scale = 1
        } else if gestureRecognizer.state == .ended {
            view.transform = .identity
        }
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: view.superview)
            view.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            UIView.animate(withDuration: 0.2) {
                view.center = self.center
            }
        }
    }
}

extension PhotoView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
