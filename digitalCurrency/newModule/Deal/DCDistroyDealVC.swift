//
//  DCDistroyDealVC.swift
//  digitalCurrenc
//
//  Created by 余洁洁 on 1/9/21.
//

import UIKit

typealias RequestParams = Dictionary<String,Any>
class DCDistroyDealVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "销毁交易"
        
        
        custom()
    }
    
    func custom() {
        getDeviceInfo()
        getDeviceList()
        buyDeviceOrder(deviceId: "")
    }
    
}

extension DCDistroyDealVC {
    ///获取矿机统计信息，用于首页显示
    func getDeviceInfo() {
        let params = RequestParams()
        let path = "device/index/info"
        BaseNetManager.noTokenRequest(withPost: path, parameters: params) { (data, code) in
            let root = data
            
            printLog(path)
            printLog(root)
        }
    }
    
    ///获取矿机列表
    func getDeviceList() {
        let params = RequestParams()
        let path = "device/index/list"
        BaseNetManager.request(withGET: path, parameters: params) { (data, code) in
            let root = data
            
            printLog(path)
            printLog(root)
        }
        
    }
    
    ///下单购买
    func buyDeviceOrder(deviceId: String) {
        var params = RequestParams()
        params["deviceId"] = deviceId
        let path = "device/order/buy"
        BaseNetManager.noTokenRequest(withPost: path, parameters: params) { (data, code) in
            let root = data
            
            printLog(path)
            printLog(root)
        }
    }
}
