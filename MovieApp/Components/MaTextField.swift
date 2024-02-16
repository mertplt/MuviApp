//
//  MaTextField.swift
//  MovieApp
//
//  Created by mert polat on 6.02.2024.
//

import Foundation
import UIKit
import TinyConstraints
 
enum MaTextFieldStyle{
    case email
    case password
    case fullName
    case phone
}

class MaTextField: UITextField{
    var placeholderText: String?{
        didSet{
            self.placeholder = placeholderText
        }
    }
    
    var textContenTypeValue: UITextContentType?{
        didSet{
            self.textContentType = textContenTypeValue
        }
    }
    
    var isSecureTextEntryValue: Bool = false{
        didSet{
            self.isSecureTextEntry = isSecureTextEntryValue
        }
    }
    
    var style: MaTextFieldStyle?{
        didSet{
            applyStyle()
        }
    }
    
    var leftIcon: UIImage?
    var rightIcon: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTextField()
    }
}

extension MaTextField{
    private func setTextField(){
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorManager.surfaceDark.cgColor
        self.textColor = ColorManager.surfaceLight
        self.size(CGSize(width: 335, height: 48))
        self.font = FontManager.paragraphAndButton()
        self.addPaddingToTextField()
    }
    
    private func applyStyle(){
        guard let style = style else {return}
        
        switch style {
        case .email:
            configureEmail()
        case .password:
            configurePassword()
        case .fullName:
            configureName()
        case .phone:
            configurePhone()
       
        }
    }
    
    private func configureEmail(){
        self.placeholderText = "Email"
        self.textContentType = .emailAddress
        self.setPlaceholderColor(ColorManager.surfaceLight)
        self.rightIcon = .mail
        addIconsToTextField()
    }

    
    private func configurePassword(){
        self.placeholderText = "Password"
        self.textContentType = .password
        self.setPlaceholderColor(ColorManager.surfaceLight)
        self.rightIcon = .eyeOff
        addIconsToTextField()
    }
    
    private func configureName(){
        self.placeholderText = "Full Name"
        self.textContentType = .name
        self.setPlaceholderColor(ColorManager.surfaceLight)
        self.leftIcon = .user
        addIconsToTextField()
    }
    
    private func configurePhone(){
        self.placeholderText = "Phone"
        self.isSecureTextEntryValue = false
        self.textContentType = .telephoneNumber
        self.setPlaceholderColor(ColorManager.surfaceLight)
        self.leftIcon = .phone
        addIconsToTextField()
    }
    
    func addPaddingToTextField() {
        let paddingView: UIView = UIView.init(frame: CGRect(x: 18, y: 18, width: 18, height: 18))
        self.leftView = paddingView;
        self.leftViewMode = .always;
        self.rightView = paddingView;
        self.rightViewMode = .always;
    }
    
   private func setPlaceholderColor(_ color: UIColor) {
        guard let placeholderText = placeholderText else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font ?? FontManager.bodyAndForms()
        ]
        
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    }
    
    func addIconsToTextField() {
        if let leftIcon = leftIcon {
            let leftImageView = UIImageView(image: leftIcon)
            leftImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            leftImageView.contentMode = .scaleAspectFit
            self.leftView = leftImageView
            self.leftViewMode = .always
        }
        if let rightIcon = rightIcon {
            let rightImageView = UIImageView(image: rightIcon)
            rightImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            rightImageView.contentMode = .scaleAspectFit
            self.rightView = rightImageView
            self.rightViewMode = .always
        }
    }
}
