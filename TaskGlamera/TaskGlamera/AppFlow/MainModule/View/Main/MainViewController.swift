//
//  MainViewController.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 27/03/2024.
//

import UIKit

class MainViewController: UIViewController{

    //outlets
    
    @IBOutlet weak var CharactersCollectionView: UICollectionView!
    
//    @IBOutlet weak var CharactersCollectionViewHeight: NSLayoutConstraint!
    
    
    //actions
    
    @IBAction func SearchAction(_ sender: Any) {
        
        BGNavigator.present(newViewController: MainRouter.showSearchView())
        
    }
    
    //variables
    var CharactersViewDetailsObserver : NSKeyValueObservation?
    var mainPresenter:ViewToPresenterMainProtocol?
    var results : [CharacterModelResult?] = []
    private var footer = ZVRefreshBackAnimationFooter()
    
    var offset:Int = -1
    var limit:Int = 0
    var total:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpCharactersCollectionView()
     
        mainPresenter = MainPresenter(mainView: self)
       
        mainPresenter?.startFetchingMain(search: "", offset: offset)
        
        initialSernairo()
    }
    
    func initialSernairo()
    {
        footer.refreshHandler = { [self] in
            print("Refresh happed here!! -> \(limit) \(offset) \(total)")
            if limit != 0 && offset != -1 && total != 0
            {
                if offset < total
                {
                    print("Load More Data")
                    //load more items
                    footer.isNoMoreData = false
                    mainPresenter?.startFetchingMain(search: "", offset: offset + 1)
                }else{
                    print("No More Data")
                    footer.isNoMoreData = true
                }
            }
            
        }
        CharactersCollectionView.footer = footer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("I'm here ---- will apear")
    }
}

//setup CollectionView
extension MainViewController
{
    func setUpCharactersCollectionView()
    {
        
        // Set the collection view delegate and data source
        CharactersCollectionView.dataSource = self
        CharactersCollectionView.delegate = self
    
        
        CharactersCollectionView.showsVerticalScrollIndicator = false
        CharactersCollectionView.showsHorizontalScrollIndicator = false
        // Register your custom cell class
        CharactersCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
    }
}

//Character CollectionView datasource and delegate
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
        return results.count
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        cell.configure(item: results[indexPath.row])
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        BGNavigator.rootNavigation(newViewController: MainRouter.showCharactersDetails(characterDetails: results[indexPath.row]))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let collectionWidth = collectionView.bounds.width
        let width = (collectionWidth)
        
        let height: CGFloat = 220
        return CGSize(width: width, height: height)
        
        
    }
}


extension MainViewController:PresenterToViewMainProtocol{
    func onCharacterResponseSuccess(mainModelArrayList: CharacterModel) {
        print("Back To View")
//        self.results = mainModelArrayList.data?.results ?? []
        offset = mainModelArrayList.data?.offset ?? 0
        limit = mainModelArrayList.data?.limit ?? 0
        total = mainModelArrayList.data?.total ?? 0
        
        
        var list : [CharacterModelResult?] = results
        var tempNewlist = mainModelArrayList.data?.results ?? []
        var newList:[CharacterModelResult?] = []
        
        list.forEach { item in
            newList.append(item)
        }
        tempNewlist.forEach{ item in
            newList.append(item)
        }
        
        
        results = newList
        
        CharactersCollectionView.reloadData()
        
        
    }
    
    func onCharacterResponseFailed(error: String) {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
}

