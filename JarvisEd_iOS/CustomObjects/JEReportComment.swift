//
//  JEReportComment.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation

class JEReportComment {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mCommentDate:String
    private var mCommentee:String
    private var mComment:String
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    public init(date:String, comment:String, commentee:String) {
        
        mCommentDate = date
        mComment = comment
        mCommentee = commentee
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func getDate() -> String {
        
        return mCommentDate
        
    }
    
    public func getComment() -> String {
        
        return mComment
        
    }
    
    public func getCommentee() -> String {
        
        return mCommentee
        
    }
    
}
