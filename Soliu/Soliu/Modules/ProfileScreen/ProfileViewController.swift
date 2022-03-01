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
        chartSetUp()
    }
    
    func setupInitialUI() {
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileViewModel.readTestResult()
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
        chartView.noDataText = "Your data is not read."
        chartView.noDataFont = .systemFont(ofSize: 20)
        chartView.noDataTextColor = .lightGray
        
        // 레이블 포지션
        chartView.xAxis.labelPosition = .bottom
        
        chartView.xAxis.drawGridLinesEnabled = false
        
        //왼쪽 눈금
        chartView.leftAxis.drawGridLinesEnabled = true
        
        // 오른쪽 눈금
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelRotationAngle = -25
        
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false

        chartView.leftAxis.setLabelCount(6, force: true)
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 10
    }
    
    func setUpChart(averageTestScore: AverageTestScore) {

        let dataPoints = ["Depression", "Anxiety", "Stress"]
        let BarChartDataSet1 = BarChartDataSet(entries: [BarChartDataEntry(x: 0, y:     averageTestScore.userAverageDepressionScore),
                                                         BarChartDataEntry(x: 1, y: averageTestScore.allUserAverageDepressionScore)], label: "Depression")
        BarChartDataSet1.setColor(.red)

        let BarChartDataSet2: BarChartDataSet = BarChartDataSet(entries:
                                                                    [BarChartDataEntry(x: 2, y:        averageTestScore.userAverageAnxietyScore),
                                                                     BarChartDataEntry(x: 3, y: averageTestScore.allUserAverageAnxietyScore)],
        label: "Anxiety")
        BarChartDataSet2.setColor(.blue)

        let BarChartDataSet3: BarChartDataSet = BarChartDataSet(entries:
                                                                    [BarChartDataEntry(x: 4, y: averageTestScore.userAverageStressScore),
                                                                     BarChartDataEntry(x: 5, y: averageTestScore.allUserAverageStressScore)],
        label: "Stress")
        BarChartDataSet3.setColor(.green)

        let barChartData =  BarChartData(dataSets: [BarChartDataSet1, BarChartDataSet2, BarChartDataSet3])
        barChartData.setDrawValues(true)
        chartView.data = barChartData
        chartView.reloadInputViews()
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func reloadData(averageScore: AverageTestScore) {
        print("reload \(averageScore)")
        setUpChart(averageTestScore: averageScore)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        informationStackView.isHidden = false
    }
}
