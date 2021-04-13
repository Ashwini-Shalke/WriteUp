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
        errorView.backgroundColor = .red
        self.view.addSubview(errorView)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
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
        dataView.backgroundColor = .green
        self.view.addSubview(dataView)
        
        dataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dataView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            dataView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            dataView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            dataView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    fileprivate func removeLoadingView() {
        loadingView.removeFromSuperview()
        isLoading = false
    }
}
