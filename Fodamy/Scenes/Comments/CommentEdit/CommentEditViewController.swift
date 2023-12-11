//
//  CommentEditViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

final class CommentEditViewController: BaseViewController<CommentEditViewModel> {
    
    private let textView = UITextViewBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(Asset.Colors.appRaven.color)
        .build()
    private let saveButton = ButtonFactory.createPrimaryButton(style: .medium)
    private var saveButtonBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
        addObserver()
    }
}

// MARK: - UILayout
extension CommentEditViewController {
    
    private func addSubViews() {
        addTextView()
        addsaveButton()
    }
    
    private func addTextView() {
        view.addSubview(textView)
        textView.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 26, left: 15, bottom: 0, right: 15), usingSafeArea: true)
        textView.height(150)
    }
    
    private func addsaveButton() {
        view.addSubview(saveButton)
        saveButton.centerXToSuperview()
        saveButton.width(162.5)
        saveButtonBottomConstraint = saveButton.bottomToSuperview(usingSafeArea: true)
        saveButtonBottomConstraint?.isActive = true
    }
}

// MARK: - Configure and Set Localize
extension CommentEditViewController {
    
    private func configureContents() {
        title = L10n.Modules.CommentEditController.title
        textView.text = viewModel.commentText
        textView.becomeFirstResponder()
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        saveButton.setTitle(L10n.Modules.CommentEditController.save, for: .normal)
    }
}

// MARK: - Actions
extension CommentEditViewController {
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    @objc
    func keyboardNotification(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.saveButtonBottomConstraint?.constant = -25
        } else {
            self.saveButtonBottomConstraint?.constant = self.view.safeAreaInsets.bottom - (endFrame?.height ?? CGFloat(0))-25
        }
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0.3),
                       options: animationCurve,
                       animations: { self.view.layoutIfNeeded() },
                       completion: nil)
    }
    
    @objc
    private func saveButtonTapped() {
        guard let commentText = textView.text, !commentText.isEmpty else {
            showWarningToast(message: L10n.Error.emptyFields)
            return
        }
        viewModel.editComment(commentText: commentText)
    }
}
