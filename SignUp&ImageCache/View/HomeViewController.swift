//
//  HomeViewController.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/15/22.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    var signInViewModel = SignInViewModel()
    var imageViewModel = ImageViewModel()
  
    
    @IBOutlet weak var tableView: UITableView!
    private  var pageNumber = 1
    var models: [Model] = []
    
    enum Section {
        case main
    }
    typealias DataSource = UITableViewDiffableDataSource<Section, Model >
    typealias  Snapshot = NSDiffableDataSourceSnapshot<Section, Model>
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = self
        self.navigationItem.hidesBackButton = true
//        signInViewModel.getUserInfo { result, error in
//            if let result = result {
//                DispatchQueue.main.async {
//                    self.navigationItem.title = "Welcome \(result)"
//                }
//            }
//        }
        applySnapshot()

        imageViewModel.modelData(page: pageNumber) { [weak self] results, _  in
            guard let self = self else {
                return
            }
            if let results = results {
                self.models = results
            }
            DispatchQueue.main.async {
                self.applySnapshot()
            }
        }
        
        //SignOut Button
        let logOutBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOutButton))
        self.navigationItem.rightBarButtonItem = logOutBarButtonItem
    }
    
    //SignOut func
    @objc func signOutButton(){
        signInViewModel.signOut { error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.coordinator?.start()
        }
    }

    //DataSource
    func makeDataSource() -> DataSource {
      let dataSource = DataSource(
        tableView: tableView,
        cellProvider: { (tableView, indexPath, model) ->
          UITableViewCell? in

            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
                return UITableViewCell()
            }
            cell.loadedImage.image = UIImage(named: "placeHolder")
            cell.loadedImage.contentMode = .scaleAspectFit
            
            let imageId = model.id
            cell.imageId = imageId

            //cell.textLabel?.text = model.description
            
            self.imageViewModel.imageData(model: model) { imageData, _  in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        if (cell.imageId == imageId){
                            cell.loadedImage.image = image
                        }
                    }
                }
            }
          
          return cell
      })
      return dataSource
    }

    func applySnapshot(animatingDifferences: Bool = true){
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(models)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension HomeViewController: UITableViewDelegate {
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 50) - scrollView.frame.size.height {
            pageNumber += 1
            imageViewModel.modelData(page: pageNumber) { [weak self] results, _  in
                guard let self = self else {
                    return
                }
                if let results = results {
                    self.models.append(contentsOf: results)
                }
                DispatchQueue.main.async {
                    self.applySnapshot()
                }
            }
        }
    }
}
