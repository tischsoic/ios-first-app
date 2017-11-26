import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var albumsLoadDataTask: URLSessionDataTask?
    
    var masterViewControllerTableView: UITableView?
    
    func loadAlbums() {
        let url = URL(string: "https://isebi.net/albums.php")
        let urlRequest = URLRequest(url: url!)
        
        print("load albums")
        albumsLoadDataTask = defaultSession.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                do {
                    print(data)
                    let res = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue:0)) as! [AnyObject]
                    
                    for item in res{
                        if (item is NSNull) {
                            continue
                        }
                        var newAlbum = AlbumRecord()
                        newAlbum.title = item["album"] as! String
                        newAlbum.genre = item["genre"] as! String
                        newAlbum.performer = item["artist"] as! String
                        newAlbum.publicationYear = String(item["year"] as! Int)
                        newAlbum.tracksNumber = String(item["tracks"] as! Int)
                        albums.append(newAlbum)
                    }
                    
                    DispatchQueue.main.async {
                        self.masterViewControllerTableView?.reloadData()
                    }
                } catch let error as NSError{
                    print("The error in the catch block is \(error)")
                }
                catch
                {
                    print("Catch Block")
                }
            }
            
        })
        
        albumsLoadDataTask?.resume()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        loadAlbums();
        
        let splitViewController = window!.rootViewController as! UISplitViewController
        splitViewController.delegate = self
        
        let leftNavigationController = splitViewController.viewControllers.first as! UINavigationController
        let masterViewController = leftNavigationController.topViewController as! MasterViewControllerTableViewController
        let rightNavigationController = splitViewController.viewControllers.last as! UINavigationController
        let detailViewController = rightNavigationController.topViewController as! DetailTableViewController
        
        self.masterViewControllerTableView = masterViewController.tableView
        masterViewController.delegate = detailViewController
        detailViewController.masterViewController = masterViewController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailTableViewController else { return false }
        if topAsDetailController.albumIndex == nil {
            return true
        }
        return false
    }
}
