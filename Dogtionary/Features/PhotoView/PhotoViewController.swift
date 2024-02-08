//
//  PhotoViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class PhotoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let photoView = PhotoView()
        photoView.configure(image: UIImage()) // temp
        photoView.closeButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        self.view = photoView
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
