//
//  HomeViewController.swift
//  WeDo
//
//  Created by Creativeitem on 17/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class HomeViewController: UIViewController {
    
    var sliderImages = [SliderImages]()
    lazy var slider: Slider = {
        let slider = Slider()
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        
        for _ in 1...5 {
            let image = SliderImages(image: "dummy")
            sliderImages.append(image)
        }
        slider.dataSource = sliderImages
        self.layout()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height: CGFloat = 150 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        
    }
    private func layout() {
        setSlider()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
    
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    private func setSlider() {
        view.addSubview(slider)
        slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if Helper.isIphoneX {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        } else {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
    }
    
    @objc func menuIconTapped() {
        
    }
}
