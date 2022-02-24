//
//  HomePageVC.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import UIKit

class HomePageVC: UIViewController {
    
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mTextFieldSearch: UITextField!
    let viewModel = HomePageVM()
    
    var timer: Timer?
    var searchValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.loadListCities()
        self.viewModel.loadListWeatherByCities()
        self.initTableView()
        self.initTextField()
    }
    
    /*
     This function will init tableView
    */
    func initTableView() {
        self.mTableView.register(WeatherItemCell.nib(), forCellReuseIdentifier: WeatherItemCell.nibName)
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
    }
    
    /*
     This function to initialize textField actions
     */
    func initTextField() {
        self.mTextFieldSearch.delegate = self
        self.mTextFieldSearch.addTarget(self,
                                           action: #selector(textFieldEditingDidChange(_:)),
                                           for: .editingChanged)
    }
    
    @IBAction func onClickAddNewCity(_ sender: Any) {
        let vcSearch = SearchCityVC()
        vcSearch.modalTransitionStyle = .coverVertical
        vcSearch.modalPresentationStyle = .popover
        vcSearch.delegate = self
        self.present(vcSearch, animated: true)
    }
}

/*
 This extenstion will handle actions got from searchPageVC
 */
extension HomePageVC: SearchCityVCDelegate {
    func onSelectItemCity(city: ResultCity) {
        self.viewModel.addCityToList(city: city)
        self.viewModel.loadListWeatherByCities()
    }
}

/*
 This extenstion to handle the ViewModel actions
 */
extension HomePageVC: HomePageVMDelegate {
    func onLoadNewLists() {
        DispatchQueue.main.async {
            self.mTableView.reloadData()
        }
    }
}

/*
 This extension will handle tableView's rows
 */
extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
       
        self.viewModel.getListWeatherItems().count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.removeItemAtIndexOf(index: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let mCell = tableView.dequeueReusableCell(withIdentifier: WeatherItemCell.nibName, for: indexPath) as? WeatherItemCell {
            if let model = self.viewModel.getItemAtIndexOf(index: indexPath.row) {
                mCell.initView(model: model)
                mCell.delegate = self
            }
            return mCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}

/*
 This extension will handle the cell's actions
 */
extension HomePageVC: WeatherItemCellDelegate {
    func onClickItemCell(model: WeatherResponse?) {
        guard model != nil else {
            return
        }
        print("redirect to details page to present weather for city \(model?.cityName ?? "")")
        let vcDetails = CityDetailsVC()
        vcDetails.model = model
        vcDetails.modalTransitionStyle = .coverVertical
        vcDetails.modalPresentationStyle = .fullScreen
        self.present(vcDetails, animated: true)
    }
}

/*
    This extension is to handle the TextField's changes
 */
extension HomePageVC: UITextFieldDelegate {

    /*
     This function is used to handle textChanging
     */
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
        if let textField = sender as? UITextField {
            let value = textField.text ?? ""
            timer?.invalidate()
            self.searchValue = value
            timer = Timer.scheduledTimer(timeInterval: 0.5,
                                         target: self,
                                         selector: #selector(searchForKeyDelayed),
                                         userInfo: nil,
                                         repeats: false)
        }
    }
    
    /*
     This function will be executed after delay (0.5 seconds) of the last character written
     */
    @objc func searchForKeyDelayed() {
        self.viewModel.searchForCityWeaher(value: self.searchValue)
    }
    
}
