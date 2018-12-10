//
//  CodeGeneratorViewController.swift
//  CodeGeneratorAndScanner
//
//  Created by Satyadev Chauhan on 10/12/18.
//  Copyright © 2018 Satyadev Chauhan. All rights reserved.
//

import UIKit

class CodeGeneratorViewController: UIViewController {
    
    @IBOutlet weak var codeImageView: UIImageView!
    @IBOutlet weak var codeImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var codeCategoryText: UITextField!
    
    var codeCategoryPicker: UIPickerView!
    let categoryCollection = CICategoryGenerator.allCases
    var selectedCategory: CICategoryGenerator = .CIPDF417BarcodeGenerator {
        didSet {
            generateCode(UIButton())
        }
    }
    
    enum CICategoryGenerator: String, CaseIterable {
        case CIAztecCodeGenerator
        //case CICheckerboardGenerator
        case CICode128BarcodeGenerator
        //case CIConstantColorGenerator
        //case CILenticularHaloGenerator
        case CIPDF417BarcodeGenerator
        case CIQRCodeGenerator
        //case CIRandomGenerator
        //case CIStarShineGenerator
        //case CIStripesGenerator
        //case CISunbeamsGenerator
    }
    
    let toolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CodeGeneratorViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CodeGeneratorViewController.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Generate Code"
        codeText.text = "1234567890"
        codeCategoryText.delegate = self
        
        codeCategoryPicker = UIPickerView.init()
        codeCategoryPicker.delegate = self
        codeCategoryPicker.dataSource = self
        codeCategoryPicker.backgroundColor = UIColor.white
        
        codeText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        generateCode(UIButton())
        codeCategoryPicker.selectRow(2, inComponent: 0, animated: true)
        
        let scanBarButton = UIBarButtonItem.init(image: UIImage.init(named: "scan"), style: .plain, target: self, action: #selector(scanButtonPressed(_:)))
        navigationItem.rightBarButtonItems = [scanBarButton]
    }
    
    fileprivate func updateCategoryText() {
        codeCategoryText.text = selectedCategory.rawValue
    }
    
    @IBAction func scanButtonPressed(_ sender: Any) {
        if let codeScannerVC = self.storyboard?.instantiateViewController(withIdentifier: "CodeScannerViewController") {
            navigationController?.pushViewController(codeScannerVC, animated: true)
        }
    }
    
    @IBAction func generateCode(_ sender: Any) {
        updateCategoryText()
        
        if let text = codeText.text {
            codeImageView.image = generateCodeFromString(string: text)
            if selectedCategory == .CIAztecCodeGenerator || selectedCategory == .CIQRCodeGenerator {
                codeImageViewHeight.constant = 300
            } else {
                codeImageViewHeight.constant = 74
            }
        } else {
            print("Error: text is empty")
        }
    }
    
    @IBAction func selectCategory(_ sender: UITextField) {
        codeCategoryText.inputView = codeCategoryPicker
        codeCategoryPicker.isHidden = false
        codeCategoryText.inputAccessoryView = toolbar
    }
    
    @objc func donePicker() {
        codeCategoryText.resignFirstResponder()
    }
    
    @objc func cancelPicker() {
        codeCategoryText.resignFirstResponder()
    }
    
    func generateCodeFromString(string: String) -> UIImage {
        
        if !string.isEmpty {
            let data = string.data(using: String.Encoding.ascii)
            let filter = getSelectedFilter()
            filter.setValue(data, forKey: "inputMessage")   // Check the KVC for the selected code generator
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let output = filter.outputImage?.transformed(by: transform)
            return UIImage(ciImage: output!)
        } else {
            return UIImage()
        }
    }
    
    func getSelectedFilter() -> CIFilter {
        return CIFilter(name: selectedCategory.rawValue) ?? CIFilter.init()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        codeCategoryPicker.isHidden = true
    }
}

// MARK: - UITextFieldDelegate

extension CodeGeneratorViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if codeCategoryText == textField {
            selectCategory(textField)
        }
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        generateCode(UIButton())
    }
}

// MARK: - UIPickerViewDataSource

extension CodeGeneratorViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryCollection.count
    }
}

// MARK: - UIPickerViewDelegate

extension CodeGeneratorViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryCollection[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoryCollection[row]
    }
}

