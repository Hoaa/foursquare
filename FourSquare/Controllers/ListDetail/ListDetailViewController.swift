//
//  ListsDetailViewController.swift
//  FourSquare
//
//  Created by nmint8m on 21.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListDetailViewController: ViewController {
    
    // MARK: - Properties
    fileprivate var listName: String = "Your saved places"
    fileprivate var venues: [(venueName: String, venueAddress: String, venueRate: Float, image: UIImage)] = []
    fileprivate let venueReuseIdentifier = "VenueTableViewCell"
    fileprivate let itemHeight: CGFloat = 110
    
    private var isLoadDone = false
    
    // MARK: - Outlet
    @IBOutlet private weak var imagesContainerView: UIView!
    @IBOutlet private weak var listIconImageView: UIImageView!
    @IBOutlet private weak var userAvatarImageView: UIImageView!
    @IBOutlet private weak var listNameLabel: UILabel!
    @IBOutlet private weak var numberOfPlacesLabel: UILabel!
    @IBOutlet private weak var defaultContentContainerView: UIView!
    @IBOutlet private weak var venuesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var venuesTableView: UITableView!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoadDone {
            return
        }
        isLoadDone = !isLoadDone
        configureImagesContainerView()
        configureVenueCollectionView()
    }
    
    override func loadData() {
        super.loadData()
        venues = [(venueName: "Pho xua", venueAddress: "Dien Bien Phu", venueRate: 9.0, image: #imageLiteral(resourceName: "Feature_Like")),
                  (venueName: "Ca phe COng", venueAddress: "Bach Dang", venueRate: 8.0, image: #imageLiteral(resourceName: "Feature_Rate")),
                  (venueName: "Ca phe COng", venueAddress: "Bach Dang", venueRate: 8.0, image: #imageLiteral(resourceName: "Feature_Rate")),
                  (venueName: "Pho xua", venueAddress: "Dien Bien Phu", venueRate: 7.0, image: #imageLiteral(resourceName: "Feature_Price")),
                  (venueName: "Ca phe COng", venueAddress: "Bach Dang", venueRate: 6.0, image: #imageLiteral(resourceName: "Feature_Rate")),
                  (venueName: "Pho xua", venueAddress: "Dien Bien Phu", venueRate: 5.0, image: #imageLiteral(resourceName: "Feature_Like")),
                  (venueName: "Ca phe COng", venueAddress: "Bach Dang", venueRate: 4.0, image: #imageLiteral(resourceName: "Feature_Like")),
                  (venueName: "Pho xua", venueAddress: "Dien Bien Phu", venueRate: 3.0, image: #imageLiteral(resourceName: "Feature_Price")),
                  (venueName: "Ca phe COng", venueAddress: "Bach Dang", venueRate: 1.0, image: #imageLiteral(resourceName: "Feature_Price"))]
    }
    
    override func configureUI() {
        super.configureUI()
        self.title = "List detail"
        listIconImageView.layer.cornerRadius = listIconImageView.bounds.width / 2
        listNameLabel.text = listName
        switch venues.count {
        case 0:
            numberOfPlacesLabel.text = "0 place"
        case 1:
            defaultContentContainerView.isHidden = true
            numberOfPlacesLabel.text = "1 place"
        default:
            defaultContentContainerView.isHidden = true
            numberOfPlacesLabel.text = "\(venues.count) places"
        }
    }
    
    // MARK: - Private func
    private func configureImagesContainerView() {
        let containerSize = imagesContainerView.bounds.size
        let imageSize = CGSize(width: containerSize.width / 4, height: containerSize.height / 2)
        let numberOfItem = venues.count
        switch numberOfItem {
        case 0...4:
            for i in 0..<numberOfItem {
                let frame = CGRect(x: CGFloat(i) * imageSize.width, y: 0, width: imageSize.width, height: imageSize.height)
                let imageView = UIImageView(frame: frame)
                imageView.image = venues[i].image
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imagesContainerView.addSubview(imageView)
            }
        case 0...8:
            for i in 0..<4 {
                let frame = CGRect(x: CGFloat(i) * imageSize.width, y: 0, width: imageSize.width, height: imageSize.height)
                let imageView = UIImageView(frame: frame)
                imageView.image = venues[i].image
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imagesContainerView.addSubview(imageView)
            }
            for i in 4..<numberOfItem {
                let frame = CGRect(x: CGFloat(i - 4) * imageSize.width, y: imageSize.height, width: imageSize.width, height: imageSize.height)
                let imageView = UIImageView(frame: frame)
                imageView.image = venues[i].image
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imagesContainerView.addSubview(imageView)
            }
        default:
            for i in 0..<4 {
                let frame = CGRect(x: CGFloat(i) * imageSize.width, y: 0, width: imageSize.width, height: imageSize.height)
                let imageView = UIImageView(frame: frame)
                imageView.image = venues[i].image
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imagesContainerView.addSubview(imageView)
            }
            for i in 4..<8 {
                let frame = CGRect(x: CGFloat(i - 4) * imageSize.width, y: imageSize.height, width: imageSize.width, height: imageSize.height)
                let imageView = UIImageView(frame: frame)
                imageView.image = venues[i].image
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imagesContainerView.addSubview(imageView)
            }
        }
    }
    
    private func configureVenueCollectionView() {
        // Height
        let lines = venues.count
        let height = CGFloat(lines) * itemHeight
        venuesTableViewHeightConstraint.constant = height
        
        // Register
        let nibForVenueTableView = UINib(nibName: venueReuseIdentifier, bundle: nil)
        venuesTableView.register(nibForVenueTableView, forCellReuseIdentifier: venueReuseIdentifier)
        
        // DataSource and delegate
        venuesTableView.dataSource = self
        venuesTableView.delegate = self
    }
}

extension ListDetailViewController: UITableViewDataSource {
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let venueTableViewCell = tableView.dequeueReusableCell(withIdentifier: venueReuseIdentifier, for: indexPath) as? VenueTableViewCell else { return UITableViewCell() }
        venueTableViewCell.venueImageView.image = venues[indexPath.row].image
        venueTableViewCell.venueNameLabel.text = venues[indexPath.row].venueName
        venueTableViewCell.venueAdressLabel.text = venues[indexPath.row].venueAddress
        switch venues[indexPath.row].venueRate {
        case 0..<2:
            venueTableViewCell.rateColorImageView.image = #imageLiteral(resourceName: "Rate_Red_32")
        case 2..<4:
            venueTableViewCell.rateColorImageView.image = #imageLiteral(resourceName: "Rate_Orange_32")
        case 4..<6:
            venueTableViewCell.rateColorImageView.image = #imageLiteral(resourceName: "Rate_Yellow_32")
        case 6..<8:
            venueTableViewCell.rateColorImageView.image = #imageLiteral(resourceName: "Rate_Cyan_32")
        default:
            venueTableViewCell.rateColorImageView.image = #imageLiteral(resourceName: "Rate_Green_32")
        }
        venueTableViewCell.rateLabel.text = "\(venues[indexPath.row].venueRate)"
        return venueTableViewCell
    }
}

extension ListDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
