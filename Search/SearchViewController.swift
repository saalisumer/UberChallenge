//
//  SearchViewController.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit
protocol SearchViewInput:class {
    func showAlertWithMessage(message:String)
    func showActivityIndicator(show:Bool)
}

protocol SearchViewOutput:class {
    func didTapSearchWithKeyword(keyword:String?)
}

class SearchViewController: UIViewController,SearchViewInput {

    weak var presenter : SearchViewOutput?
    @IBOutlet weak var searchTextFeild:UITextField?
    @IBOutlet weak var searchButton:UIButton?
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView?

    @IBAction func didTapSearchButton(sender:UIResponder)
    {
        self.presenter?.didTapSearchWithKeyword(keyword: self.searchTextFeild?.text)
    }
    
    func showAlertWithMessage(message:String) {
        let alert = UIAlertController(title: "Error", message:message , preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            self.activityIndicator?.startAnimating()
            self.searchButton?.isEnabled = false
        }
        else
        {
            self.activityIndicator?.stopAnimating()
            self.searchButton?.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
