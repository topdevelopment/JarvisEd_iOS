//
//  StudentTVC.swift
//  JarvisEd_iOS
//  TOP Development
//

import UIKit

class StudentTVC: UITableViewCell {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oStudentNameLabel: UILabel!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    public static let mReuseIdentifier = "studentCell"
    private var mInfoButtonProtocol:InfoButtonProtocol? = nil
    private var mCurrentIndex:Int = -1
    
    
    
    /*
     *
     * Class Methods
     *
     */

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    public func setInfoProtocol(infoProtocol:InfoButtonProtocol) {
        
        mInfoButtonProtocol = infoProtocol
        
    }
    
    public func setCurrentStudent(student:JEStudent, index:Int) {
        
        oStudentNameLabel.text = student.getFullName()
        mCurrentIndex = index
        
    }
    
    
    
    /*
     *
     * IBAction Methods
     *
     */
    
    @IBAction func aInfoButtonClicked(_ sender: UIButton) {
        
        if (mInfoButtonProtocol != nil) {
            
            mInfoButtonProtocol?.infoButtonClicked(index: mCurrentIndex)
            
        }
        
    }
    

}
