//
//  TestViewController.swift
//  WheeleDemo
//
//  Created by Artem Martirosyan on 11/07/2019.
//  Copyright © 2019 Artem Martirosyan. All rights reserved.
//

import UIKit

public class TestViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel = ViewModel()
    override public func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.text = viewModel.textInput
        urlTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTappingOutside))
        view.addGestureRecognizer(tap)
        addBindings()
    }

    private func addBindings() {
        viewModel.countNumber.bind { [unowned self] (count) in
            self.countLabel.text = "\(count)"
        }
        
        viewModel.currentMainImage.bind { [unowned self] image in
            self.imageView.image = image
        }
        
        viewModel.enableLoadingButton.bind { [unowned self] (enable) in
            self.loadButton.isEnabled = enable
        }
        
        viewModel.enableCancelButton.bind { [unowned self] (enable) in
            self.cancelButton.isEnabled = enable
        }
        
        viewModel.showLoadingIndicator.bind { [unowned self] (show) in
            show ? self.activityIndicator.startAnimating() :  self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = !show
        }
    }
    
    @IBAction func tapLoad(_ sender: UIButton) {
        viewModel.loadImage()
    }
    
    @IBAction func tapCancel(_ sender: UIButton) {
        viewModel.cancelLoading()
    }
    
    @IBAction func tapAddCount(_ sender: UIButton) {
        viewModel.addCount()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.updateTextInput(textField.text)
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
}
