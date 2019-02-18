//
//  DisplayViewController.swift
//  Foodentify
//
//  Created by Wayne Yu on 12/6/18.
//  Copyright © 2018 Wayne Yu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class DisplayViewController : UIViewController {
    
    let cache = ImageCache.shared
    var queryName : String = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var confidenceLevel: UILabel!
    @IBOutlet weak var nutitionText: UILabel!
    
    override func viewDidLoad() {
        let image = cache["food"]
        print("Loaded Display VC")
        imageView.image = image
        processImage(image!)
        searchFood()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func processImage(_ image: UIImage) {
        let model = Food101()
        let size = CGSize(width: 299, height: 299)
        
        guard let buffer = image.resize(to: size)?.pixelBuffer() else {
            fatalError("Scaling or converting to pixel buffer failed!")
        }
        
        guard let result = try? model.prediction(image: buffer) else {
            fatalError("Prediction failed!")
        }
        
        let confidence = result.foodConfidence["\(result.classLabel)"]! * 100.0
        let converted = String(format: "%.2f", confidence)
        
        print("\(result.classLabel) - \(converted) %")
        
        queryName = result.classLabel
        let displayNameArr = result.classLabel.components(separatedBy: "_")
        var displayName = ""
        for str in displayNameArr {
            displayName += str.capitalized
            displayName += " "
        }
        foodName.text = displayName
        confidenceLevel.text = "\(converted) %"
        nutitionText.text = "Could not load content details."
    }
    
    func searchFood() {
        let searchTerm = queryName
        
        Alamofire.request("https://api.nal.usda.gov/ndb/search/?format=json&q=\(searchTerm ?? "")&max=1&api_key=4EiLjR1ulvncyYplSpL6cj7eSYKMiA8M74s6NEOa").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let dbNumber = json["list"]["item"][0]["ndbno"].string {
                    print(dbNumber)
                    self.processNutrition(dbNumber)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func processNutrition(_ dbNumber: String) {
        Alamofire.request("https://api.nal.usda.gov/ndb/V2/reports?ndbno=\(dbNumber)&type=b&format=json&api_key=4EiLjR1ulvncyYplSpL6cj7eSYKMiA8M74s6NEOa").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json["foods"][0]["food"])
                if let desc = json["foods"][0]["food"]["ing"]["desc"].string {
                    print(desc)
                    self.nutitionText.text = desc
                } else if let desc = json["foods"][0]["food"]["desc"]["name"].string {
                    print(desc)
                    self.nutitionText.text = desc
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

