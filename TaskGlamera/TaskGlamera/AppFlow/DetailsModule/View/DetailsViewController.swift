//
//  DetailsViewController.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    //outlets
    @IBOutlet weak var ComicsCollectionView: UICollectionView!
    @IBOutlet weak var SeriesCollectionView: UICollectionView!
    @IBOutlet weak var StoriesCollectionView: UICollectionView!
    @IBOutlet weak var EventsCollectionView: UICollectionView!
    @IBOutlet weak var MainDetailsImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    
    @IBOutlet weak var BackButtonImageView: UIImageView!
    
    //actions
    @IBAction func GoBackToMainScreen(_ sender: Any) {
        
        BGNavigator.rootNavigation(newViewController: DetailsRouter.GoBackToMainScreen())
    }
    
    //variables
    var characterDetails:CharacterModelResult?
    var detailsPresenter:ViewToPresenterDetailsProtocol?
    var comicsItems:[DetailsModelResult?] = []
    var seriesItems:[DetailsModelResult?] = []
    var storiesItems:[DetailsModelResult?] = []
    var eventsItems:[DetailsModelResult?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleForScreen()
        setUpCollectionViews()
        configureData()
        
        
        
    }
    
    func setStyleForScreen()
    {
        self.BackButtonImageView.transform = CGAffineTransform(scaleX: -1, y: -1)
    }
    func configureData()
    {
        guard let detailsData = characterDetails else { return }
        
        let imagePath = detailsData.thumbnail?.path ?? ""
        let imageExtension = detailsData.thumbnail?.Extension ?? ""
        let FullURL = "\(imagePath).\(imageExtension)"
        print("the fullURL is -> \(FullURL)")
        let url = URL(string:  FullURL)
        let placeholderImage = UIImage(named: "CharaterDemo1")
        MainDetailsImage.sd_setImage(with: url, placeholderImage: placeholderImage ,options: SDWebImageOptions(rawValue: 0), completed: { (img, err, cacheType, imgURL) in
            // code
        })
        
        nameLabel.text = detailsData.name ?? ""
        
        DescriptionLabel.text = detailsData.description ?? ""
        
        
        detailsPresenter = DetailsPresenter(detailView: self)
       
        detailsPresenter?.startFetchingDetails(characterID: "\(detailsData.id ?? 0)", type: "comics")
        
        detailsPresenter?.startFetchingDetails(characterID: "\(detailsData.id ?? 0)", type: "series")
        
        detailsPresenter?.startFetchingDetails(characterID: "\(detailsData.id ?? 0)", type: "stories")
        
        detailsPresenter?.startFetchingDetails(characterID: "\(detailsData.id ?? 0)", type: "events")
        
    }

}
//setup collection view
extension DetailsViewController
{
    func setUpCollectionViews()
    {
        
        // Set the collection view delegate and data source
        ComicsCollectionView.dataSource = self
        ComicsCollectionView.delegate = self
        
        ComicsCollectionView.showsVerticalScrollIndicator = false
        ComicsCollectionView.showsHorizontalScrollIndicator = false
        ComicsCollectionView.backgroundColor = UIColor.clear
        // Register your custom cell class
        ComicsCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier)
        
        // Set the collection view delegate and data source
        SeriesCollectionView.dataSource = self
        SeriesCollectionView.delegate = self
        
        SeriesCollectionView.showsVerticalScrollIndicator = false
        SeriesCollectionView.showsHorizontalScrollIndicator = false
        SeriesCollectionView.backgroundColor = UIColor.clear
        // Register your custom cell class
        SeriesCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier)
        
        // Set the collection view delegate and data source
        StoriesCollectionView.dataSource = self
        StoriesCollectionView.delegate = self
        
        StoriesCollectionView.showsVerticalScrollIndicator = false
        StoriesCollectionView.showsHorizontalScrollIndicator = false
        StoriesCollectionView.backgroundColor = UIColor.clear
        // Register your custom cell class
        StoriesCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier)
        
        
        // Set the collection view delegate and data source
        EventsCollectionView.dataSource = self
        EventsCollectionView.delegate = self
        
        EventsCollectionView.showsVerticalScrollIndicator = false
        EventsCollectionView.showsHorizontalScrollIndicator = false
        EventsCollectionView.backgroundColor = UIColor.clear
        // Register your custom cell class
        EventsCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier)
    }
}
//datasource and delegate
extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ComicsCollectionView
        {
            return comicsItems.count
        }else if collectionView == SeriesCollectionView
        {
            return seriesItems.count
        }else if collectionView == StoriesCollectionView
        {
            return storiesItems.count
        }else if collectionView == EventsCollectionView
        {
            return eventsItems.count
        }else{
            return 0
        }
                    
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ComicsCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier, for: indexPath) as! ComicsCollectionViewCell

            cell.configure(item: comicsItems[indexPath.row])
            return cell
            
        }else if collectionView == SeriesCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier, for: indexPath) as! ComicsCollectionViewCell

            cell.configure(item: seriesItems[indexPath.row])
            return cell
            
        }else if collectionView == StoriesCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier, for: indexPath) as! ComicsCollectionViewCell

            cell.configure(item: storiesItems[indexPath.row])
            return cell
            
        }else if collectionView == EventsCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.reuseIdentifier, for: indexPath) as! ComicsCollectionViewCell

            cell.configure(item: eventsItems[indexPath.row])
            return cell
            
        }else{
            return UICollectionViewCell()
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        BGNavigator.present(newViewController: DetailsRouter.showCharacterPopUpView(ComicItem: comicsItems[indexPath.row]))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        
        let width: CGFloat = 150
        let height: CGFloat = 150
        return CGSize(width: width, height: height)
        
        
    }
}


extension DetailsViewController : PresenterToViewDetailsProtocol
{
    func onCharacterResponseSuccess(mainModelArrayList: DetailsModel, type: String) {
        if type == "comics"
        {
            comicsItems = mainModelArrayList.data?.results ?? []
            
            ComicsCollectionView.reloadData()
        }else if type == "series"
        {
            seriesItems = mainModelArrayList.data?.results ?? []
            SeriesCollectionView.reloadData()
        }else if type == "stories"
        {
            storiesItems = mainModelArrayList.data?.results ?? []
            StoriesCollectionView.reloadData()
        }else if type == "events"
        {
            eventsItems = mainModelArrayList.data?.results ?? []
            EventsCollectionView.reloadData()
        }
        
    }
    
    
    
    func onCharacterResponseFailed(error: String) {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
