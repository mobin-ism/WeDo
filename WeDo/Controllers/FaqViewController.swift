//
//  FaqViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class FaqViewController: UIViewController {
    
    let questions = ["Where do you have service providers?".localized(), "Is the payment secured?".localized(), "When do I pay?".localized(), "I am unhappy with the service I received, what should I do?".localized(), "How can I delete my account?".localized(), "How can I change my phone number?".localized()]
    let answers = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var items = [FAQItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        setupFaqView()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    private func setupFaqView() {
        for question in questions {
            let item = FAQItem(question: question, answer: answers)
            items.append(item)
        }
        let faqView = FAQView(frame: .zero, items: items)
        faqView.backgroundColor = UIColor.white
        faqView.titleLabel.text = "Frequently Asked Questions".localized()
        faqView.titleLabelTextFont = UIFont(name: OPENSANS_BOLD, size: 16)
        faqView.titleLabelTextColor = GREENISH_COLOR
        faqView.questionTextColor = UIColor.black
        faqView.answerTextColor = UIColor.darkGray
        faqView.questionTextFont = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        faqView.answerTextFont = UIFont(name: OPENSANS_REGULAR, size: 12)
        faqView.clipsToBounds = true
        faqView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(faqView)
        faqView.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        faqView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        faqView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        faqView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}
