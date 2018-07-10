    //
//  SearchResultViewController.swift
//  UberChallenge
//
//  Created by Saalis Umer on 7/6/18.
//  Copyright © 2018 Saalis Umer. All rights reserved.
//

import UIKit
protocol SearchResultViewInput:class {
    func showSearchResult(pictures: [Picture] , keyword:String)
    func showActivityIndicator(show: Bool)
    func notifyNoMorePicsAvailable()
}

protocol SearchResultViewOutput:class {
    func didTapCloseSearchResult()
    func getPictures()->[Picture]
    func fetchMorePictures()
}

class SearchResultViewController: UIViewController,SearchResultViewInput {
    @IBOutlet var imageCollectionView:UICollectionView?
    @IBOutlet var activityIndicator:UIActivityIndicatorView?
    @IBOutlet var searchKeywordLabel:UILabel?
    @IBOutlet var messageLabel:UILabel?
    weak var presenter : SearchResultViewOutput?
    var pictures = [Picture]()
    var isMessageAnimation:Bool = false

    @IBAction func didTapClose()
    {
        self.presenter?.didTapCloseSearchResult()
    }
    
    override func viewDidLoad() {
        self.imageCollectionView?.dataSource = self
        self.imageCollectionView?.delegate = self
        self.imageCollectionView?.contentInset = UIEdgeInsetsMake(10, 5, 10, 5)
        self.messageLabel?.alpha = 0
        self.messageLabel?.backgroundColor = UIColor(white: 0.0, alpha: 0.9)
        self.messageLabel?.clipsToBounds = true
        self.messageLabel?.textColor = UIColor.white
        self.messageLabel?.layer.cornerRadius = 8.0
        self.imageCollectionView?.register(UINib.init(nibName: PictureCollectionViewCell_Identifier, bundle: Bundle.main), forCellWithReuseIdentifier: PictureCollectionViewCell_Identifier)
        if let pictures = self.presenter?.getPictures() {
            self.pictures = Array(pictures)
            self.imageCollectionView?.reloadData()
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSearchResult(pictures: [Picture], keyword:String) {
        self.pictures = Array(pictures)
        self.imageCollectionView?.reloadData()
        self.searchKeywordLabel?.text = keyword
    }
    
    func showActivityIndicator(show: Bool) {
        if show
        {
            self.messageLabel?.text = "  Fetching More Pictures...  "
            self.activityIndicator?.startAnimating()
            UIView.animate(withDuration: 0.3, animations: {
                self.messageLabel?.alpha = 1
            })
        }
        else
        {
            self.activityIndicator?.stopAnimating()
            UIView.animate(withDuration: 0.3, animations: {
                self.messageLabel?.alpha = 0
            })
        }
    }
    
    func notifyNoMorePicsAvailable()
    {
        if self.isMessageAnimation
        {
            return;
        }
        
        self.isMessageAnimation = true
        self.messageLabel?.text = "  End of Result  "
        UIView.animate(withDuration: 1.0, animations: {
            self.messageLabel?.alpha = 1.0
        }) { (success) in
            UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseOut, animations: {
                self.messageLabel?.alpha = 0
            }, completion: {(success) in
                self.isMessageAnimation = false
            })
        }
    }
}

extension SearchResultViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PictureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell_Identifier, for: indexPath) as! PictureCollectionViewCell
        cell.prepareForReuse()
        cell.imageView?.setImageFrom(imageURLString: self.pictures[indexPath.item].imageURL, completionHandler: { (image, error) in
        })
        cell.label?.text = self.pictures[indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(self.view.bounds.size.width-20)/3.0,height:(self.view.bounds.size.width-20)/3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height - 80
        {
            self.presenter?.fetchMorePictures()
        }
    }
}
