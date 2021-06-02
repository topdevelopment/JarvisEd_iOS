//
//  JEAdmin.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation

class JEAdmin {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mFullName: String
    private var mId: String
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    public init(id:String, fullName:String) {
        
        mId = id
        mFullName = fullName
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func getFullName() -> String {
        
        return mFullName
        
    }
    
    public func getID() -> String {
        
        return mId
        
    }
    
}
