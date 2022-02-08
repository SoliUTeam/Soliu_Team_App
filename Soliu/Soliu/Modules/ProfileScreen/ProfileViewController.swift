import UIKit
import Charts

class ProfileViewController: UIViewController {
    
    @IBOutlet var charView: BarChartView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    lazy var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        populate()
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
    
    func populate() {
        let month = ["Depression", "Anxiety", "Stress"]
        let data = profileViewModel.getTestScore()
        charView.noDataText = "Please sign in."
        charView.noDataFont = .systemFont(ofSize: 20)
        charView.noDataTextColor = .lightGray
        setChart(month: month, data: data)
    }
    
    func setChart(month: [String], data: [Int]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(data[i]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Score")

        // 차트 컬러
        chartDataSet.colors = [.systemBlue]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        charView.data = chartData
    }
}
