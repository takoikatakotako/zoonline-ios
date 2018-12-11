import UIKit

class FieldCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private static let kMaxRow = 3
    var maxColumn = kMaxRow
    
    private var sectionCells = [[CGRect]]()
    private var contentSize = CGSize.zero
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.minimumLineSpacing = 4
        self.minimumInteritemSpacing = 4
        self.sectionInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    override func prepare() {
        super.prepare()
        sectionCells = [[CGRect]]()
        
        if let collectionView = self.collectionView {
            contentSize = CGSize(width: collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right, height: 0)
            let smallCellSideLength: CGFloat = (contentSize.width - super.sectionInset.left - super.sectionInset.right - (super.minimumInteritemSpacing * (CGFloat(maxColumn) - 1.0))) / CGFloat(maxColumn)
            
            for section in (0..<collectionView.numberOfSections) {
                var cells = [CGRect]()
                let numberOfCellsInSection = collectionView.numberOfItems(inSection: section)
                var height = contentSize.height
                
                var x: CGFloat = 0
                var y: CGFloat = 0
                var cellwidth: CGFloat = 0
                var cellheight: CGFloat = 0
                
                for i in (0..<numberOfCellsInSection) {
                    let position = i  % (numberOfCellsInSection)
                    let cellPosition = position % 6
                    
                    switch cellPosition {
                    case 0:
                        if section % 2 == 0 {
                            x = super.sectionInset.left
                            y = contentSize.height + super.sectionInset.top
                            cellwidth = 2 * smallCellSideLength + super.minimumInteritemSpacing
                            cellheight = 2 * smallCellSideLength + super.minimumLineSpacing
                        }else {
                            x = super.sectionInset.left
                            y = contentSize.height + super.sectionInset.top
                            cellwidth = smallCellSideLength
                            cellheight = smallCellSideLength
                        }
                    case 1:
                        if section % 2 == 0 {
                            x = 2 * (smallCellSideLength + super.minimumInteritemSpacing) + super.sectionInset.left
                            y = 0 * (smallCellSideLength + super.minimumLineSpacing) + contentSize.height + super.sectionInset.top
                            cellwidth = smallCellSideLength; cellheight = smallCellSideLength
                        }else {
                            x = smallCellSideLength + super.minimumInteritemSpacing + super.sectionInset.left
                            y = (0 * (smallCellSideLength + super.minimumLineSpacing)) + contentSize.height + super.sectionInset.top
                            cellwidth = 2 * smallCellSideLength  + super.minimumInteritemSpacing
                            cellheight = 2 * smallCellSideLength + super.minimumLineSpacing
                        }
                    case 2:
                        if section % 2 == 0 {
                            x = 2 * (smallCellSideLength + super.minimumInteritemSpacing) + super.sectionInset.left
                            y = 1 * (smallCellSideLength + super.minimumLineSpacing) + contentSize.height + super.sectionInset.top
                            cellwidth = smallCellSideLength; cellheight = smallCellSideLength
                        }else {
                            x = super.sectionInset.left
                            y = (1 * (smallCellSideLength + super.minimumLineSpacing)) + contentSize.height + super.sectionInset.top
                            cellwidth = smallCellSideLength; cellheight = smallCellSideLength
                        }
                    case 3:
                        x = super.sectionInset.left
                        y = 2 * (smallCellSideLength + super.minimumLineSpacing) + contentSize.height + super.sectionInset.top
                        cellwidth = smallCellSideLength; cellheight = smallCellSideLength
                    case 4:
                        x = smallCellSideLength + super.minimumInteritemSpacing + super.sectionInset.left
                        y = 2 * (smallCellSideLength + super.minimumLineSpacing) + contentSize.height + super.sectionInset.top
                        cellwidth = smallCellSideLength; cellheight = smallCellSideLength
                    case 5:
                        x = 2 * (smallCellSideLength + super.minimumInteritemSpacing) + super.sectionInset.left
                        y = 2 * (smallCellSideLength + super.minimumLineSpacing) + contentSize.height + super.sectionInset.top
                        cellwidth = smallCellSideLength; cellheight = smallCellSideLength
                    default:
                        x = 0; y = 0
                        cellwidth = 0; cellheight = 0
                        break
                    }
                    
                    let cellRect = CGRect(x: x, y: y, width: cellwidth, height: cellheight)
                    cells.append(cellRect)
                    
                    if (height < cellRect.origin.y + cellRect.height) {
                        height = cellRect.origin.y + cellRect.height
                    }
                }
                contentSize = CGSize(width: contentSize.width, height: height)
                sectionCells.append(cells)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        if let collectionView = self.collectionView {
            for i in 0..<collectionView.numberOfSections {
                let numberOfCellsInSection = collectionView.numberOfItems(inSection: i);
                for j in 0..<numberOfCellsInSection {
                    
                    let indexPath = IndexPath(row: j, section: i)
                    if let attributes = layoutAttributesForItem(at: indexPath) {
                        if (rect.intersects(attributes.frame)) {
                            layoutAttributes.append(attributes)
                        }
                    }
                }
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        attributes?.frame = sectionCells[indexPath.section][indexPath.row]
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
}
