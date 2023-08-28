import UIKit

class CatViewController: UIViewController {
    private var cats: [Cat] = []
    
    // 1
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "CatLib"
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = UIColor(red: 0.949, green: 0.945, blue: 0.965, alpha: 1.0)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        addViewsInHierarchy()
        setupConstraints()
        fetchRemotePopularCats()
    }
    
    // 2
    private func addViewsInHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    // 3
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func fetchRemotePopularCats() {
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?&has_breeds=1&limit=30&api_key=live_4hT1tf5ADL9bIxKfo0xXynjeqH68k8y2cvzoZphUpm50w4PqESd4hCNpNZS7a8PD")!

        let request = URLRequest(url: url)

                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    if error != nil { return }

                    guard let data else { return }

                    do {
                        
                        let remoteCats = try JSONDecoder().decode([TMDBRemoteCat].self, from: data)
                        let catsArray = remoteCats.map { remoteCat -> Cat in
                            let breed = remoteCat.breeds.first
                            let weight = breed?.weight.metric ?? "Unknown"
                            return Cat(name: breed?.name ?? "Unknown",
                                       origin: breed?.origin ?? "Unknown",
                                       weight: weight,
                                       temperament: breed?.temperament ?? "Unknown",
                                       lifespan: breed?.lifeSpan ?? "Unknown",
                                       description: breed?.description ?? "No description",
                                       url: remoteCat.url
                            )
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.cats = catsArray
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                }

        task.resume()
    }
}

extension CatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CatCell()
        let cat = cats[indexPath.row]
        cell.setup(cat: cat)
        cell.backgroundColor = UIColor(red: 0.949, green: 0.945, blue: 0.965, alpha: 1.0)
        return cell
    }
}

extension CatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat = cats[indexPath.row]
        let storyboard = UIStoryboard(name: "Detail", bundle: Bundle(for: DetailViewController.self))
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        detailViewController.cat = cat
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
