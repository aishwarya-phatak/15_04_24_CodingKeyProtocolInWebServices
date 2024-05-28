//
//  ViewController.swift
//  15_04_24_CodingKeyProtocolInWebServices
//
//  Created by Vishal Jagtap on 28/05/24.
//

import UIKit

class ViewController: UIViewController {
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSONUsingDecoder()
    }
    
    func parseJSONUsingDecoder(){
        url = URL(string: "https://reqres.in/api/users?page=2")
        
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            let jsonDecoder = JSONDecoder()
            let apiReqponseObject = try! jsonDecoder.decode(APIResponse.self, from: data!)
            print(apiReqponseObject.perPage)
            print(apiReqponseObject.firstName)
            print(apiReqponseObject.lastName)
        })
        dataTask?.resume()
    }
}

