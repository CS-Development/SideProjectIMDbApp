//
//  ViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 24.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    var manager: BaseAPIManager // = FakeAPIManager.shared //APIManager.shared
    
    init(manager: BaseAPIManager) {
        self.manager = manager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        manager = APIManager.shared
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.login()
        manager.getAlbums(completion: { album in
            // show the album
        })
        
    }
}

//    func getOldAlbums() {
//            // Create request
//            var request = createRequest("/getAlbums")
//
//            // Specify HTTP Method to use
//            request.httpMethod = "GET"
//            // Set HTTP Request Header
//            request.setValue("Bearer BQD8NtKU2MjsTOqup1RyScIvlmZoP_x53ZGabiRSHBGqvPIkRxE7dIU8IbUhsmeZPUkec8boXLr_gst5L-o", forHTTPHeaderField: "Authorization")
//
//            // Send HTTP Request
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//                // Check if Error took place
//                if let error = error {
//                    print("Error took place \(error)")
//                    return
//                }
//
//                // Read HTTP Response Status code
//                if let response = response as? HTTPURLResponse {
//                    print("Response HTTP Status code: \(response.statusCode)")
//                }
//
//                // Convert HTTP Response Data to a simple String
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print("Response data string:\n \(dataString)")
//
//                    if let album = self.parseJSONAlbumModel(data: data) {
//                        print("album href = \(album.href)")
//                    }
//                }
//            }
//            task.resume()
//        }
