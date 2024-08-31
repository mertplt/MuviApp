//
//  EditProfileViewController.swift
//  MovieApp
//
//  Created by Mert Polat on 29.08.24.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import SDWebImage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let viewModel = EditProfileViewModel()
    
    private let saveButton: MaButton = {
        let button = MaButton()
        button.buttonTitle = "Save"
        button.style = .largeButtonYellow
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameTextField: MaTextField = {
        let textField = MaTextField()
        textField.style = .fullName
        return textField
    }()
    
    private let emailTextField: MaTextField = {
        let textField = MaTextField()
        textField.style = .email
        textField.rightIcon = .mail
        return textField
    }()
    
    private let phoneNumberTextField: MaTextField = {
        let textField = MaTextField()
        textField.style = .phone
        textField.rightIcon = .phone
        return textField
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "Bitmap")
        return imageView
    }()
    
    private let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "camera")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = FontManager.overline()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    let nameLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = FontManager.overline()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    let emailLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.font = FontManager.overline()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    let phoneLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorManager.surfaceDark
        setupUI()
        fetchUserProfile()
    }
    
    private func fetchUserProfile() {
        viewModel.fetchUserProfile { [weak self] result in
            switch result {
            case .success():
                self?.updateUI()
            case .failure(let error):
                print("Failed to fetch user profile: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI() {
        if let userProfile = viewModel.userProfile {
            nameTextField.text = userProfile.name
            emailTextField.text = Auth.auth().currentUser?.email
            phoneNumberTextField.text = userProfile.phone
            if let profileImageURL = userProfile.profileImageURL, let url = URL(string: profileImageURL) {
                profileImageView.sd_setImage(
                    with: url,
                    placeholderImage: UIImage(named: "default_profile_image"),
                    options: [.progressiveLoad, .refreshCached],
                    completed: nil
                )
            }
        }
    }
    
    
    private func setupUI() {
        [phoneLineView, phoneLabel, emailLineView, emailLabel, nameLineView, nameLabel, profileImageView, cameraImageView, phoneNumberTextField, emailTextField, nameTextField, saveButton].forEach {
            view.addSubview($0)
        }
        
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        
        setupConstraints()
    }
    
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true,completion: nil)
    }
    
    private func setupConstraints(){
        
        profileImageView.topToSuperview(offset: 132)
        profileImageView.centerXToSuperview()
        profileImageView.width(100)
        profileImageView.height(100)
        
        cameraImageView.centerX(to: profileImageView)
        cameraImageView.centerY(to: profileImageView)
        cameraImageView.width(24)
        cameraImageView.height(24)
        
        nameLabel.topToBottom(of: profileImageView,offset: 51)
        nameLabel.leadingToSuperview(offset: 20)
        
        nameTextField.topToBottom(of: nameLabel,offset:0)
        nameTextField.leadingToSuperview(offset: 20)
        nameTextField.trailingToSuperview(offset: 20)
        
        nameLineView.topToBottom(of: nameTextField)
        nameLineView.leading(to: nameTextField)
        nameLineView.trailing(to: nameTextField)
        
        emailLabel.topToBottom(of: nameLineView,offset: 24)
        emailLabel.leadingToSuperview(offset: 20)
        
        emailTextField.topToBottom(of: emailLabel,offset: 0)
        emailTextField.leadingToSuperview(offset: 20)
        emailTextField.trailingToSuperview(offset: 20)
        
        emailLineView.topToBottom(of: emailTextField)
        emailLineView.leading(to: emailTextField)
        emailLineView.trailing(to: emailTextField)
        
        phoneLabel.topToBottom(of: emailLineView,offset: 24)
        phoneLabel.leadingToSuperview(offset: 20)
        
        phoneNumberTextField.topToBottom(of: phoneLabel,offset: 0)
        phoneNumberTextField.leadingToSuperview(offset: 20)
        phoneNumberTextField.trailingToSuperview(offset: 20)
        
        phoneLineView.topToBottom(of: phoneNumberTextField)
        phoneLineView.leading(to: phoneNumberTextField)
        phoneLineView.trailing(to: phoneNumberTextField)
        
        saveButton.bottomToSuperview(offset: -32,usingSafeArea: true)
        saveButton.centerXToSuperview()
    }
    
    @objc func saveButtonTapped(_ sender: Any) {
           guard let name = nameTextField.text,
                 let email = emailTextField.text,
                 let phone = phoneNumberTextField.text else {
               return
           }
           
           viewModel.updateProfile(name: name, email: email, phone: phone, image: profileImageView.image) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let message):
                       self?.showAlert(title: "Success", message: message)
                       self?.navigationController?.popViewController(animated: true)
                   case .failure(let error):
                       self?.showAlert(title: "Error", message: error.localizedDescription)
                   }
               }
           }
       }
       
       private func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
}

#Preview{
    EditProfileViewController()
}
