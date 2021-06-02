//
//  JEStudent.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation

class JEStudent {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mFullName:String
    private var mID:String
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    public init(id:String, fullName:String) {
        
        mID = id
        mFullName = fullName
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func getID() -> String {
        
        return mID
        
    }
    
    public func getFullName() -> String {
        
        return mFullName
        
    }
    
}
