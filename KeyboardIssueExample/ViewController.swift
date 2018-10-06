/*
 The MIT License (MIT)

 Copyright (c) 2018-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInputTextField()
        self.setupSwitchButton()
        self.setupDismissButton()
        self.setupScrollArea()
        self.setupAccessoryView()
        self.setupInputView()
        self.setupLayout()
    }

    // MARK: - Input

    private let inputTextField = UITextField()

    private func setupInputTextField() {
        self.view.addSubview(self.inputTextField)
        self.inputTextField.placeholder = "Type a message"
        self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Dismiss

    private let dismissButton: UIButton = UIButton(type: UIButton.ButtonType.system)

    private func setupDismissButton() {
        self.view.addSubview(self.dismissButton)
        self.dismissButton.setTitle("Dismiss", for: .normal)
        self.dismissButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        self.dismissButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    func dismissKeyboard() {
        self.inputTextField.resignFirstResponder()
    }

    // MARK: - Switch

    private let switchButton: UIButton = UIButton(type: UIButton.ButtonType.system)

    private func setupSwitchButton() {
        self.view.addSubview(self.switchButton)
        self.switchButton.setTitle("Switch", for: .normal)
        self.switchButton.addTarget(self, action: #selector(switchInputView), for: .touchUpInside)
        self.switchButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    func switchInputView() {
        guard self.inputTextField.isFirstResponder else { return }
        if self.inputTextField.inputView == self.customInputView {
            self.inputTextField.inputView = nil
        } else {
            self.inputTextField.inputView = self.customInputView
        }
        self.inputTextField.reloadInputViews()
    }

    // MARK: - Scroll Area

    private let scrollArea = UIScrollView()

    private func setupScrollArea() {
        self.view.addSubview(self.scrollArea)
        self.scrollArea.translatesAutoresizingMaskIntoConstraints = false
        self.scrollArea.keyboardDismissMode = .interactive
    }

    // MARK: - Layout

    private func setupLayout() {
        let margins = self.view.layoutMarginsGuide

        // Container
        let containerView: UIStackView = UIStackView(arrangedSubviews: [
            self.inputTextField,
            self.switchButton,
            self.dismissButton
        ])
        containerView.spacing = 15
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        // Scroll Area
        self.scrollArea.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.scrollArea.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.scrollArea.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        self.scrollArea.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollArea.contentSize = CGSize(width: self.scrollArea.bounds.width, height: 10000)
    }

    // MARK: - Accessory View

    private let accessoryView = AccessoryView()

    private func setupAccessoryView() {
        self.accessoryView.backgroundColor = .red
        self.accessoryView.translatesAutoresizingMaskIntoConstraints = false
        self.inputTextField.inputAccessoryView = self.accessoryView
    }

    private class AccessoryView: UIView {
        override var intrinsicContentSize: CGSize {
            return CGSize(width: UIView.noIntrinsicMetric, height: 40)
        }
    }

    // MARK: - Input View

    private let customInputView = UIView()

    private func setupInputView() {
        self.customInputView.backgroundColor = .yellow
        self.customInputView.translatesAutoresizingMaskIntoConstraints = false
        self.customInputView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.inputTextField.inputView = self.customInputView
    }
}
