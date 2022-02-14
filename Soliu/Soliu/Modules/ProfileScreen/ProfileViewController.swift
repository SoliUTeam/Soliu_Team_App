import UIKit
import Charts

class ProfileViewController: UIViewController {
    
    @IBOutlet var informationStackView: UIStackView!
    @IBOutlet var chartView: BarChartView!
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
        chartSetUp()
    }
    
    func chartSetUp() {
        chartView.noDataText = "Your data is not read."
        chartView.noDataFont = .systemFont(ofSize: 20)
        chartView.noDataTextColor = .lightGray
        
        // 레이블 포지션
        chartView.xAxis.labelPosition = .bottom
        
        chartView.xAxis.drawGridLinesEnabled = false
        
        //왼쪽 눈금
        chartView.leftAxis.drawGridLinesEnabled = false
        
        // 오른쪽 눈금
        chartView.rightAxis.enabled = false

    }
    
    func setUpChart(dataPoints: [String], testScoreAverageList: [Double]) {
        
        
        var entries = [BarChartDataEntry]()
         for index in 0..<3 {
            entries.append(BarChartDataEntry(x: Double(index), y: testScoreAverageList[index]))
        }
        
        let set = BarChartDataSet(entries: entries, label: "Your Mind-Set Score")
        set.colors = [NSUIColor.systemGreen,  NSUIColor.systemBlue, NSUIColor.systemPink]
        let data = BarChartData(dataSet: set)
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        data.setDrawValues(true)
        chartView.data = data
        
    }
    
    func populate() {
        let label = ["Depression", "Anxiety", "Stress"]
        setUpChart(dataPoints: label, testScoreAverageList: profileViewModel.getTestScore())
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
