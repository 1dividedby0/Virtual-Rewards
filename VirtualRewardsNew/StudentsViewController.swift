//
//  StudentsViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/14/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UIScrollViewDelegate {

    @IBOutlet weak var addStudentButton: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var searchBar:UISearchBar!
    var studentsToBeDisplayed:[Student] = [Student]()
    var refreshControl: UIRefreshControl!
    var timer:NSTimer = NSTimer()
    var selectedStudent:Student!
    override func viewWillAppear(animated: Bool) {
        studentsToBeDisplayed = VirtualRewardsClient.sharedInstance.getClass().students
        var total = VirtualRewardsClient.sharedInstance.getClass().findTotal()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Total Points: \(total)")
        self.tableView.addSubview(refreshControl)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        //self.addStudentButton.tintColor = UIColor.cyanColor()
        self.refreshControl = UIRefreshControl()
        self.tableView.backgroundColor = UIColor.cyanColor()
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        var total = VirtualRewardsClient.sharedInstance.getClass().findTotal()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Total Points: \(total)")
        self.tableView.addSubview(refreshControl)
        NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("reloadTotal"), userInfo: nil, repeats: true)
        studentsToBeDisplayed = VirtualRewardsClient.sharedInstance.getClass().students
        if studentsToBeDisplayed == VirtualRewardsClient.sharedInstance.getClass().students{
            //VirtualRewardsClient.sharedInstance.getClass().printClass()
        }
        tableView.reloadData()
        searchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.placeholder = "Search Students"
        var leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.titleView = self.searchBar
        searchBar.barTintColor = UIColor.cyanColor()
        }
    func refresh(){
        refreshControl.endRefreshing()
        tableView.reloadData()
        VirtualRewardsClient.sharedInstance.getClass().printClass()
    }
    func reloadTotal(){
        var total = VirtualRewardsClient.sharedInstance.getClass().findTotal()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Total Points: \(total)")
        self.tableView.addSubview(refreshControl)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var classRoom = VirtualRewardsClient.sharedInstance.getClass()
        studentsToBeDisplayed = VirtualRewardsClient.sharedInstance.searchWithTerm(searchText)
        if searchText == ""{
            studentsToBeDisplayed = VirtualRewardsClient.sharedInstance.getClass().students
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let classRoom = VirtualRewardsClient.sharedInstance.getClass()
            if studentsToBeDisplayed.endIndex != classRoom.students.endIndex{
                classRoom.removeStudent(studentsToBeDisplayed[indexPath.row])
                studentsToBeDisplayed.removeAtIndex(indexPath.row)
            }else{
                studentsToBeDisplayed.removeAtIndex(indexPath.row)
                classRoom.students.removeAtIndex(indexPath.row)
            }
            VirtualRewardsClient.sharedInstance.updateSavedClass(classRoom)
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.endUpdates()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var total = VirtualRewardsClient.sharedInstance.getClass().findTotal()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Total Points: \(total)")
        return studentsToBeDisplayed.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedStudent = studentsToBeDisplayed[indexPath.row]
        println(self.selectedStudent)
        var destination = StudentDetailsViewController()
        performSegueWithIdentifier("toDetails", sender: self)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentClass = VirtualRewardsClient.sharedInstance.getClass()
        let cell = tableView.dequeueReusableCellWithIdentifier("studentCell") as! StudentTableViewCell
        cell.backgroundColor = UIColor.cyanColor()
        let student:Student? = studentsToBeDisplayed[indexPath.row]
        if student != nil{
        cell.student = student
        cell.index = indexPath.row
        cell.inSearch = studentsToBeDisplayed.endIndex != currentClass.students.endIndex
        }
        cell.reload()
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toDetails"{
          var destination = segue.destinationViewController as? StudentDetailsViewController
          // selectedStudent appears to be nil here because t
          println(self.selectedStudent)
         destination!.name = self.selectedStudent.name
         destination!.email = self.selectedStudent.email
         destination!.student = self.selectedStudent
        }
    }
    

}
