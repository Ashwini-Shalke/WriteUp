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

class BaseViewController: UIViewController {
    var state: State? {
        didSet {
            render()
        }
    }
    
    var loadingView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var errorView: UIView = UIView()
    private var isLoading: Bool = false
    
    func render() {
        switch state {
        case .loading:
            self.showLoadingView()
        case .error:
            self.showLoadingView()
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
        errorView.backgroundColor = .red
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func showLoadingView() {
        errorView.removeFromSuperview()
        isLoading = true
        self.view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    
    private func showDataView() {
        
    }
    
    fileprivate func removeLoadingView() {
        loadingView.removeFromSuperview()
        isLoading = false
    }
}
