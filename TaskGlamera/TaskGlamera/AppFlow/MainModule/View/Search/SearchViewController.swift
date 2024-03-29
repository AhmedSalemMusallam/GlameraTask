//
//  SearchViewController.swift
//  TaskGlamera
//
//  Created by Ahmed Salem on 29/03/2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var SearchTF: UITextField!
    @IBOutlet weak var BGViewSearch: UIView!
    
    @IBOutlet weak var ResultsTableView: UITableView!
    
    //actions
    @IBAction func ClearSearchAction(_ sender: Any) {
        
        SearchTF.text = ""
        
    }
    
    //variables
    var mainPresenter:ViewToPresenterMainProtocol?
    var results : [CharacterModelResult?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardManagerConfig()
        setStyleForScreen()
        
        //seach configuration
        SearchTF.delegate = self
        SearchTF.returnKeyType = .done
        setUpAddressTableViewTableView()
        
    }
    
    func setStyleForScreen()
    {
        BGViewSearch.layer.cornerRadius = 5
        BGViewSearch.layer.borderWidth = 1
        BGViewSearch.layer.borderColor = UIColor.lightGray.cgColor
        
        SearchTF.borderStyle = .none
        SearchTF.backgroundColor = .clear
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        
        // Perform search process
        if let searchText = textField.text {
            //fire search here
            print("searchText-> \(searchText)")
            //FireSearch
            mainPresenter = MainPresenter(mainView: self)
            mainPresenter?.startFetchingMain(search: searchText, offset: 0)
        }
        
        return true
    }
}

extension SearchViewController
{
    fileprivate func keyboardManagerConfig() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
}

//set up collection view
extension SearchViewController
{
    func setUpAddressTableViewTableView()
    {
        
        ResultsTableView.separatorStyle = .none
        ResultsTableView.delegate = self
        ResultsTableView.dataSource = self
    
        ResultsTableView.showsVerticalScrollIndicator = false
        ResultsTableView.showsHorizontalScrollIndicator = false
        ResultsTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
       
    }
}
extension SearchViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // Set your desired row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.configure(item: results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        BGNavigator.rootNavigation(newViewController: MainRouter.showCharactersDetails(characterDetails: results[indexPath.row]))
    }
}

extension SearchViewController:PresenterToViewMainProtocol
{
    func onCharacterResponseSuccess(mainModelArrayList: CharacterModel) {
        print("Back To View")
        self.results = mainModelArrayList.data?.results ?? []

        ResultsTableView.reloadData()
        
        
    }
    
    func onCharacterResponseFailed(error: String) {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
