//
//  APIResponse.swift
//  15_04_24_CodingKeyProtocolInWebServices
//
//  Created by Vishal Jagtap on 28/05/24.
//

import Foundation
struct APIResponse : Decodable{
    //This class must contain all keys (other than nesting related keys)
    var page : Int
    var perPage : Int
    var total : Int
    var totalPages : Int
    
    var id : Int
    var email : String
    var firstName : String
    var lastName : String
    var avatar : String
    
    var url : String
    var text : String
    
    //this enum should contain all firstlevel keys in terms of cases
    enum APIResponseKeys : String,CodingKey{
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
        case support
    }
    
    enum DataKeys : String,CodingKey{
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
    
    enum SupportKeys : String,CodingKey{
        case url
        case text
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try! decoder.container(keyedBy: APIResponseKeys.self)
        page = try! mainContainer.decode(Int.self, forKey: .page)
        perPage = try! mainContainer.decode(Int.self, forKey: .perPage)
        total = try! mainContainer.decode(Int.self, forKey: .total)
        totalPages = try! mainContainer.decode(Int.self, forKey: .totalPages)
        
        let dataContainer = try! mainContainer.nestedContainer(keyedBy: [DataKeys].self, forKey: .data)
        id = try! dataContainer.decode(Int.self, forKey: .id)
        email = try! dataContainer.decode(String.self, forKey: .email)
        firstName = try! dataContainer.decode(String.self, forKey: .firstName)
        lastName = try! dataContainer.decode(String.self, forKey: .lastName)
        avatar = try! dataContainer.decode(String.self, forKey: .avatar)
        
        let supportContainer = try! mainContainer.nestedContainer(keyedBy: SupportKeys.self, forKey: .support)
        url = try! supportContainer.decode(String.self, forKey: .url)
        text = try! supportContainer.decode(String.self, forKey: .text)
    }
}
