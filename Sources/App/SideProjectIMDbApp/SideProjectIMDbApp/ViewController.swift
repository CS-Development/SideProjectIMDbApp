//
//  ViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 24.07.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    func login() {
            // Create URL
            let url = URL(string: "https://api.spotify.com/v1/login")
            guard let requestUrl = url else { fatalError() }
            // Create URL Request
            var request = URLRequest(url: requestUrl)
            // Specify HTTP Method to use
            request.httpMethod = "GET"
            // Set HTTP Request Header
            request.setValue("Bearer BQD8NtKU2MjsTOqup1RyScIvlmZoP_x53ZGabiRSHBGqvPIkRxE7dIU8IbUhsmeZPUkec8boXLr_gst5L-o", forHTTPHeaderField: "Authorization")
            // Send HTTP Request
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check if Error took place
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                
                // Read HTTP Response Status code
                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                }
                
                // Convert HTTP Response Data to a simple String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                    
                    
                    if let login = self.parseJSONloginModel(data: data) {
                        print("login token = \(login.token)")
                    }
                }
            }
            task.resume()
        }
    func getAlbums() {
            // Create URL
            let url = URL(string: "https://api.spotify.com/V1/getAlbums")
            guard let requestUrl = url else { fatalError() }
            // Create URL Request
            var request = URLRequest(url: requestUrl)
            // Specify HTTP Method to use
            request.httpMethod = "GET"
            // Set HTTP Request Header
            request.setValue("Bearer BQD8NtKU2MjsTOqup1RyScIvlmZoP_x53ZGabiRSHBGqvPIkRxE7dIU8IbUhsmeZPUkec8boXLr_gst5L-o", forHTTPHeaderField: "Authorization")
            // Send HTTP Request
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check if Error took place
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                
                // Read HTTP Response Status code
                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                }
                
                // Convert HTTP Response Data to a simple String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                    
                    if let album = self.parseJSONAlbumModel(data: data) {
                        print("album href = \(album.href)")
                    }
                }
            }
            task.resume()
        }
        
        func parseJSONAlbumModel(data: Data) -> AlbumModel? {
            
            var returnValue: AlbumModel?
            do {
                returnValue = try JSONDecoder().decode(AlbumModel.self, from: data)
            } catch {
                print("Error took place\(error.localizedDescription).")
            }
            
            return returnValue
        }
    
    func parseJSONloginModel(data: Data) -> LoginModel? {
        
        var returnValue: LoginModel?
        do {
            returnValue = try JSONDecoder().decode(LoginModel.self, from: data)
        } catch {
            print("Error took place\(error.localizedDescription).")
        }
        
        return returnValue
    }

}

public struct AlbumModel: Decodable {
    
    public var href: String

    public var description: String {
        return """
        ------------
        href = \(href)
        ------------
        """
    }
}

public struct LoginModel: Decodable {
    
    public var token: String

    public var description: String {
        return """
        ------------
        token = \(token)
        ------------
        """
    }
}
