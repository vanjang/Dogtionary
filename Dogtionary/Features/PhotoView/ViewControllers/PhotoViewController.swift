//
//  PhotoViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class PhotoViewController: UIViewController {
    private let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let photoView = PhotoView()
        photoView.configure(imageUrl: imageUrl)
        photoView.closeButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        self.view = photoView
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("PhotoViewController is deinitialised")
    }
}
