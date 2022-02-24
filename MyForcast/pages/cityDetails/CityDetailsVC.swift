//
//  CityDetailsVC.swift
//  MyForcast
//
//  Created by Nidhal on 23/2/2022.
//

import UIKit

class CityDetailsVC: UIViewController {
    @IBOutlet weak var lbCityName: UILabel!
    @IBOutlet weak var lbDistrictName: UILabel!
    @IBOutlet weak var lbTempView: UILabel!
    @IBOutlet weak var lbTimeView: UILabel!
    @IBOutlet weak var imgIconWeather: UIImageView!
    @IBOutlet weak var lbHumidityView: UILabel!
    @IBOutlet weak var lbSpeedWindView: UILabel!
    @IBOutlet weak var lbPressureView: UILabel!
    
    var model: WeatherResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() {
        self.lbCityName.text = self.model?.cityName ?? ""
        self.lbDistrictName.text = self.model?.districtName ?? ""
        self.lbTempView.text = "\(self.model?.current?.temp ?? 0)° C"
        if let firstWeather = self.model?.current?.weather.first {
            let imgPath = Constants.pathImgIcon.replacingOccurrences(of: "**_**", with: firstWeather.icon)
            self.imgIconWeather.sd_setImage(with: URL(string: imgPath),
                                            placeholderImage: UIImage(named: ""),
                                            options: .waitStoreCache) {  _, _, _, _ in
            }
        }
        
        self.lbTimeView.text = self.getCurrenTime()
        let pressureVal = self.model?.current?.pressure ?? 0
        let humidityVal = self.model?.current?.humidity ?? 0
        let speedWindVal = self.model?.current?.windSpeed ?? 0
        
        self.lbPressureView.text = "\(pressureVal) Bar"
        self.lbHumidityView.text = "\(humidityVal)%"
        self.lbSpeedWindView.text = "\(speedWindVal) Km/h"
    }
    
    func getCurrenTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
