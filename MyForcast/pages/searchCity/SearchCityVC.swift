//
//  SearchCityVC.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import UIKit

protocol SearchCityVCDelegate: AnyObject {
    func onSelectItemCity(city: ResultCity)
}

class SearchCityVC: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mTextFieldSearch: UITextField!
    
    weak var delegate: SearchCityVCDelegate?
    
    let viewModel = SearchCityVM()
    var timer: Timer?
    var searchValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        self.initTextField()
    }
    
    /*
     This function will init tableView
    */
    func initTableView() {
        self.mTableView.register(CityItemCell.nib(), forCellReuseIdentifier: CityItemCell.nibName)
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
}

/*
 This extension will handle tableView's rows
 */
extension SearchCityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getListCitiesItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let mCell = tableView.dequeueReusableCell(withIdentifier: CityItemCell.nibName, for: indexPath) as? CityItemCell {
            if let model = self.viewModel.getItemAtIndexOf(index: indexPath.row) {
                mCell.delegate = self
                mCell.initView(model: model)
            }
            return mCell
        }
        return UITableViewCell()
    }
}

/*
 This extension will handle the cell's actions
 */
extension SearchCityVC: CityItemCellDelegate {
    func onClickItemCell(model: ResultCity?) {
        guard model != nil else {
            return
        }
        print("tessss")
        self.delegate?.onSelectItemCity(city: model!)
        self.dismiss(animated: true)
    }
}

/*
    This extension is to handle the TextField's changes
 */
extension SearchCityVC: UITextFieldDelegate {

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
        self.viewModel.searchForCityByName(value: self.searchValue, completion: {
            DispatchQueue.main.async {
                self.mTableView.reloadData()
            }
        })
    }
    
}
