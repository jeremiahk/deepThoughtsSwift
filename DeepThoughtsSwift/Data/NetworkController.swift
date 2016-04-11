//
//  NetworkManager.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 4/5/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func getAllThoughts(closure: [String: AnyObject] -> ())
    func getAllCategories(closure: [String: AnyObject] -> ())
}

class NetworkController: NSObject, NetworkProtocol {
    let queue = NSOperationQueue()

    func getAllThoughts(closure: [String: AnyObject] -> ()) {
        let request = AllThoughts()
        request.closure = closure
        queue.addOperation(request)
    }

    func getAllCategories(closure: [String: AnyObject] -> ()) {
    }
}

class BaseOperation: NSOperation, NSURLSessionDataDelegate {
    private var task: NSURLSessionTask?
    private let incomingData = NSMutableData()
    var closure: ([String: AnyObject] -> ())?

    lazy var session: NSURLSession = {
        return NSURLSession(configuration: .defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
    }()

    var myData = NSMutableData()
    var myError: ErrorType?
    
    var internalFinished = false
    override var finished: Bool {
        get {
            return internalFinished
        }
        set (newAnswer){
            willChangeValueForKey("isFinished")
            internalFinished = newAnswer
            willChangeValueForKey("isFinished")
        }
    }

    // MARK: - NSURLSessionDataDelegate
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        if cancelled {
            finished = true
            return
        }

        guard let httpResponse = response as? NSHTTPURLResponse else {
            fatalError("Unexpected Response")
        }
        if httpResponse.statusCode != 200 {
            fatalError("Unexpected Response: \(httpResponse.statusCode)")
        }

        completionHandler(.Allow)
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        if cancelled {
            finished = true
            return
        }
        
        myData.appendData(data)
    }
}

class AllThoughts: BaseOperation {
    override func start() {
        queuePriority = .High
        if cancelled {
            finished = true
            return
        }
        
        guard let url = NSURL(string: "http://localhost:3000/thought") else {
            fatalError("Problem with error")
        }
        let urlRequest = NSURLRequest(URL: url)

        let task = session.dataTaskWithRequest(urlRequest)
        task.resume()
    }

    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if cancelled {
            finished = true
            return
        } else if error != nil {
            myError = error
            finished = true
            
            //TODO: Add error handling
            return
        }

        processData()
    }

    func processData() {
        guard let json = try! NSJSONSerialization.JSONObjectWithData(myData, options: []) as? [String: AnyObject] else {
            fatalError("Bad Data")
            //TODO: Handle bad data
        }

        closure!(json)
    }
}
