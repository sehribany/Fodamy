//
//  CommentInputView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders
import Utilities

public class CommentInputView: UIView {
    
    public let textView = UITextViewBuilder()
        .backgroundColor(.white)
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(.appRaven)
        .borderWidth(2)
        .borderColor(UIColor.appZircon.cgColor)
        .cornerRadius(20)
        .isScrollEnabled(false)
        .textContainerInset(UIEdgeInsets(top: 11, left: 15, bottom: 10, right: 15))
        .text(L10n.Components.Comment.placeholder)
        .build()
    
    private let sendButton = UIButtonBuilder()
        .cornerRadius(20)
        .clipsToBounds(true)
        .backgroundColor(.appHeather)
        .image(UIImage.icSend.withRenderingMode(.alwaysTemplate))
        .tintColor(.appWhite)
        .build()
    public var sendButtonTappedCallBack: StringClosure?
    var placeholderText = L10n.Components.Comment.placeholder
    weak var viewModel: CommentInputViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
        addSubViews()
    }
}

// MARK: - UILayout
extension CommentInputView {
    
    private func addSubViews() {
        addTextView()
        addSendButton()
    }
    
    private func addTextView() {
        addSubview(textView)
        textView.topToSuperview().constant = 10
        textView.leftToSuperview()
        textView.bottomToSuperview().constant = -10
    }
    
    private func addSendButton() {
        addSubview(sendButton)
        sendButton.centerYToSuperview()
        sendButton.rightToSuperview()
        sendButton.leftToRight(of: textView, offset: 15)
        sendButton.height(40)
        sendButton.width(40)
    }
}

// MARK: - Configure and Set Localize
extension CommentInputView {
    
    private func configureContents() {
        textView.delegate = self
        backgroundColor = .clear
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    public func set(viewModel: CommentInputViewProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - Actions
extension CommentInputView {
    
    @objc
    private func sendButtonTapped() {
        let text = textView.text
        sendButtonTappedCallBack?(text ?? "")
    }
}

// MARK: - UITextViewDelegate
extension CommentInputView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            sendButton.backgroundColor = .appHeather
            textView.text = placeholderText
        } else {
            sendButton.backgroundColor = .appRed
            placeholderText = ""
        }
    }
}
