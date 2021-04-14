//
//  BaseViewController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/02/21.
//  Copyright © 2021 Ashwini Shalke. All rights reserved.
//

import UIKit

enum State {
    case loading
    case error
    case loaded
}

protocol BaseViewControllerProtocol: class {
   func showSuccessView()
}

class BaseViewController: UIViewController {
    var state: State? {
        didSet {
            render()
        }
    }
    
    let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = "Apologies something went wrong. Please try again later."
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = false
        return errorLabel
    }()
    
    var dataView: UIView = UIView()
    private var errorView: UIView = UIView()
    private var isLoading: Bool = false
    weak var delegate: BaseViewControllerProtocol?
    
    var loadingView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    func render() {
        switch state {
        case .loading:
            self.showLoadingView()
        case .error:
            self.showErrorView()
        case .loaded:
            self.showDataView()
        case .none:
            print("Check why we need to handle this")
        }
    }
    
    private func showErrorView() {
        if isLoading {
            removeLoadingView()
        }
        self.view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    errorLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                    errorLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                    errorLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                    errorLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
                ])
    }
    
    private func showLoadingView() {
        errorView.removeFromSuperview()
        isLoading = true
        self.view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func showDataView() {
        if isLoading {
            removeLoadingView()
        }
        delegate?.showSuccessView()
    }
    
    fileprivate func removeLoadingView() {
        loadingView.removeFromSuperview()
        isLoading = false
    }
}



