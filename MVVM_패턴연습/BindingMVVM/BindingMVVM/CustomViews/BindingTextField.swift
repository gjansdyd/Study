//
//  BindingTextField.swift
//  BindingMVVM
//
//  Created by mun on 2023/03/16.
//

import UIKit

class BindingTextField: UITextField {
    private var textChanged: (String) -> Void = { _ in }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        textChanged(text)
    }
    
    func bind(callBack: @escaping (String) -> Void) {
        textChanged = callBack
    }
}
