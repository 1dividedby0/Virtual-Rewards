//
//  StudentsViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/14/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var searchBar:UISearchBar!
    var studentsToBeDisplayed:[Student] = [Student]()
    var refreshControl: UIRefreshControl!
    override func viewWillAppear(animated: Bool) {
        studentsToBeDisplayed = VirtualRewardsClient.sharedInstance.getClass().students
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        studentsToBeDisplayed = VirtualRewardsClient.sharedInstance.getClass().students
        if studentsToBeDisplayed == VirtualRewardsClient.sharedInstance.getClass().students{
            VirtualRewardsClient.sharedInstance.getClass().printClass()
        }
        tableView.reloadData()
        searchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
        println("test");
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.placeholder = "Search Students"
        var leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    func refresh(){
        tableView.reloadData()
        refreshControl.endRefreshing()
        VirtualRewardsClient.sharedInstance.getClass().printClass()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        println("DidEndEditing")
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(" in searchBar");
        println("studentsToBeDisplayed\(studentsToBeDisplayed)")
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
            classRoom.removeStudent(indexPath.row)
            VirtualRewardsClient.sharedInstance.updateSavedClass(classRoom)
            studentsToBeDisplayed.removeAtIndex(indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.endUpdates()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("test4\(studentsToBeDisplayed.count)");
        return studentsToBeDisplayed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("studentsToBeDisplayed\(studentsToBeDisplayed)")
        let currentClass = VirtualRewardsClient.sharedInstance.getClass()
        let cell = tableView.dequeueReusableCellWithIdentifier("studentCell") as StudentTableViewCell
        let student:Student? = studentsToBeDisplayed[indexPath.row]
        if student != nil{
        cell.student = student
        cell.index = indexPath.row
        cell.selectedStudents = studentsToBeDisplayed
        cell.inSearch = studentsToBeDisplayed.endIndex != currentClass.students.endIndex
        }
        cell.reload()
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
