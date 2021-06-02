//
//  FirebaseProtocol.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation

protocol FirebaseProtocol {
    
    func successResponse(method:FirebaseComm.FirebaseMethod)
    func successObjResponse(method:FirebaseComm.FirebaseMethod, obj:AnyObject)
    func errorResponse(method:FirebaseComm.FirebaseMethod)
    
}
