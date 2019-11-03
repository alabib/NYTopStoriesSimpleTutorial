//
//  ServerManager.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

enum WebserviceError : Error {
    case wrongURL
    case dataEmptyError
    case responseError
    case unKnown
}

struct Resource<A>
{
    var url: String
    let parse: (Any) -> A?
}

class ServerManager {
    
    typealias DidFinishDelegate = (AnyObject?) -> ()
    typealias DidFinishWithErrorDelegate = (WebserviceError, Any?) -> ()
    
    private var session: SessionProtocol
    
    init(session: SessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    var didFinish: DidFinishDelegate?
    var didFinishWithError: DidFinishWithErrorDelegate?
    
    //MARK: - HTTPHandling -
    func httpConnect<A>(resource:Resource<A>, completion: @escaping (Any?) -> (), errorHandler: @escaping (WebserviceError, Any?) -> ())
    {
        
        guard let url = constructURL(urlString: resource.url) else {
            errorHandler(.wrongURL, nil)
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                errorHandler(.responseError, error)
                return
                
            }
            guard let data = data else {
                errorHandler(.dataEmptyError, nil)
                return
            }
            
            let result = resource.parse(data)
            
            DispatchQueue.main.async {
                completion(result)
            }
            
            }.resume()
    }
    
    private func constructURL(urlString: String) -> URL? {
        guard
            let baseURL = URL(string: urlString),
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
                return nil
        }
        
        let queryItemAppKey = URLQueryItem(name: Constants.APIKey.name, value: Constants.APIKey.value)
        components.queryItems = [queryItemAppKey]
        return components.url
    }
}


protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping
        (Data?, URLResponse?, Error?) -> Void)
        -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}


