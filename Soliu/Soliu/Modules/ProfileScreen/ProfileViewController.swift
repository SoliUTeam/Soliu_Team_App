import UIKit
import Charts

class ProfileViewController: UIViewController {
    
    @IBOutlet var informationStackView: UIStackView!
    @IBOutlet var charView: BarChartView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var majorLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    
    lazy var profileViewModel = ProfileViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        profileViewModel.readTestResult()
        setupInitialUI()
        chartSetUp()
        activityIndicator.hidesWhenStopped =  true
    }
    
    func setupInitialUI() {
        informationStackView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let alert = UIAlertController(title: "You are not logged in", message: "Please sign in your account", preferredStyle: .alert)
        
        if !SupportFirebase.supportFirebase.isLoggedIn() {
            self.present(alert, animated: true)
        }
        
        let loginAction = UIAlertAction(title: "Sign-In", style: .default) { _ in
            self.performSegue(withIdentifier: "openLoginViewController", sender: nil)
        }
        alert.addAction(loginAction)
    }
    
    func chartSetUp() {
        charView.noDataText = "Your data is not read."
        charView.noDataFont = .systemFont(ofSize: 20)
        charView.noDataTextColor = .lightGray
    }
    
    func setUpChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
                
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: 0.0, y: values[i])
            dataEntries.append(dataEntry)
        }
                
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Category")
        let chartData = BarChartData(dataSet: chartDataSet)
        charView.data = chartData
        
    }
    
    func populate() {
        let label = ["Depression", "Anxiety", "Stress"]
        var dataEntries: [BarChartDataEntry] = []
        setUpChart(dataPoints: label, values: profileViewModel.getTestScore())
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func reloadData(testInformation: TestInformation?) {
        majorLabel.text = testInformation?.major ?? "MajorIn"
        genderLabel.text = testInformation?.gender ?? "genderIn"
        gradeLabel.text = testInformation?.grade ?? "gradeLabel"
        populate()
        activityIndicator.stopAnimating()
        informationStackView.isHidden = false
    }
}
