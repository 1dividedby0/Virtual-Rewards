//
//  StudentsViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/14/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //weak var currentClass = VirtualRewardsClient.sharedInstance.getClass()

    //lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
    var searchBar:UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("\(VirtualRewardsClient.sharedInstance) sdf")
        //VirtualRewardsClient().sharedInstance.getClass()
        //VirtualRewardsClient.sharedInstance.getClass()
        searchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
        println("test");
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.placeholder = "Search Students"
        var leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
         println("test1");
        tableView.registerClass(StudentTableViewCell.self, forCellReuseIdentifier: "studentCell")
        println("test2");
        //ClassRoom.sharedInstance.printClass()
        println("test3");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println( " in searchBar");
        //ClassRoom.sharedInstance.students = VirtualRewardsClient.sharedInstance.searchWithTerm(searchText)
        tableView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("test4");
        println(VirtualRewardsClient.sharedInstance.getClass().students)
        //if VirtualRewardsClient.sharedInstance.getClass().students == nil{
        return VirtualRewardsClient.sharedInstance.getClass().students.count
        //}
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("studentCell") as StudentTableViewCell
        cell.student = VirtualRewardsClient.sharedInstance.getClass().students[indexPath.row]
        cell.index = indexPath.row
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
