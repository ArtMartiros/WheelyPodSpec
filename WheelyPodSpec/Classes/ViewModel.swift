//
//  ViewModel.swift
//  WheeleDemo
//
//  Created by Artem Martirosyan on 11/07/2019.
//  Copyright © 2019 Artem Martirosyan. All rights reserved.
//

import UIKit

class ViewModel {
    
    private let model = Model()
    
    //MARK: Bindable properties
    private (set) public var countNumber = Box(0)
    private (set) public lazy var enableLoadingButton = Box(enableLoadingButtonRule)
    private (set) public lazy var enableCancelButton = Box(enableCancelButtonRule)
    private (set) public lazy var showLoadingIndicator = Box(isLoading)
    private (set) public var currentMainImage: Box<UIImage?> = Box(UIImage.fromPodBundle(wiith: "placeholderImage"))
    
    //MARK: Properties
    private (set) public var textInput = "https://my-hit.org/storage/952427_1920x1080x500.jpg" { didSet { updateButtonStatus()}}
    private var loadedTextInputValue = "" { didSet { updateButtonStatus()}}
    private var isLoading = false {
        didSet {
            showLoadingIndicator.value = isLoading
            updateButtonStatus()
        }
    }
    
    //MARK: Computed properties
    private var dividedByTwo: Bool {
        return countNumber.value != 0 && countNumber.value % 2 == 0
        
    }
    private var enableLoadingButtonRule: Bool {
        let loaded = loadedTextInputValue.isEmpty ? true : textInput != loadedTextInputValue
        guard !textInput.isEmpty,
            !dividedByTwo,
            loaded,
            !isLoading
            else { return false }
        return true
    }
    
    private var enableCancelButtonRule: Bool {
        guard !dividedByTwo, isLoading else { return false }
        return true
    }
    
    //MARK: Implementation
    func addCount() {
        countNumber.value += 1
        updateButtonStatus()
    }
    
    func loadImage() {
        let textInput = self.textInput
        if let url = URL(string: textInput) {
            isLoading = true
            model.getData(from: url) { (data, _, _) in
                DispatchQueue.main.async() { [weak self] in
                    if let data = data {
                        self?.currentMainImage.value = UIImage(data: data)
                        self?.loadedTextInputValue = textInput
                    }
                    self?.isLoading = false
                }
            }
        }
    }
    
    func cancelLoading() {
        isLoading = false
        model.cancel()
    }
    
    func updateTextInput( _ text: String?) {
        textInput = text ?? ""
    }
    
    //MARK: Private methods
    private func updateButtonStatus() {
        enableLoadingButton.value = enableLoadingButtonRule
        enableCancelButton.value = enableCancelButtonRule
    }
    
}

extension UIImage {
    static func fromPodBundle(wiith name: String) -> UIImage? {
        let bundle = Bundle(for: TestViewController.self)
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}
