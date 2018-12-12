import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class FollowerListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //テーブルビューインスタンス
    var friendsCollectionView: UICollectionView!
    private var frindsList: JSON = []

    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        //テーブルビューの初期化
        let collectionFrame = view.frame

        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        friendsCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        friendsCollectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UserCollectionViewCell.self))
        friendsCollectionView.delegate = self
        friendsCollectionView.dataSource = self
        friendsCollectionView.backgroundColor = UIColor.white
        view.addSubview(friendsCollectionView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        friendsCollectionView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    // MARK: くるくるの生成
    func setActivityIndicator() {

        // indicator.frame = CGRect(x: viewWidth*0.35, y: viewHeight*0.25, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.clipsToBounds = true
        // indicator.layer.cornerRadius = viewWidth*0.3*0.3
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.view.bringSubviewToFront(indicator)
        indicator.color = UIColor.init(named: "main")
        self.view.addSubview(indicator)
    }

    // MARK: テーブルビューのセルの数を設定する
    // Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("Num: \(indexPath.row)")

        //画面遷移、ユーザー情報画面へ
        let userInfoView: UserInfoViewController = UserInfoViewController()
        userInfoView.postUserID = frindsList[indexPath.row]["user-id"].intValue

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(userInfoView, animated: true)
    }

    // Cellの総数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }

    // Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UserCollectionViewCell.self), for: indexPath) as! UserCollectionViewCell
        cell.userLabel!.text = "カビゴンカビゴンカビゴンカビゴンカビゴン"
        return cell
    }
}
