//
//  JEReport.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation

class JEReport {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mId:String
    private var mDate:String
    private var mReportDetails:String
    private var mReportType:ReportType
    private var mReportedBy:String
    private var mReportedStudent:String
    private var mReportComments:[JEReportComment]
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    public init(id:String, date:String, reportDetails:String, reportType:ReportType, reportedBy:String, reportedStudent:String) {
        
        mId = id
        mDate = date
        mReportDetails = reportDetails
        mReportedBy = reportedBy
        mReportedStudent = reportedStudent
        mReportType = reportType
        mReportComments = []
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func getId() -> String {
        
        return mId
        
    }
    
    public func getReportDate() -> String {
        
        return mDate
        
    }
    
    public func getReportDetails() -> String {
        
        return mReportDetails
        
    }
    
    public func getReportedBy() -> String {
        
        return mReportedBy
        
    }
    
    public func getReportedStudent() -> String {
        
        return mReportedStudent
        
    }
    
    public func getReportType() -> ReportType {
        
        return mReportType
        
    }
    
    public func addReportComment(comment:JEReportComment) {
        
        mReportComments.append(comment)
        
    }
    
    public func getReportComments() -> [JEReportComment] {
        
        return mReportComments
        
    }
    
}
