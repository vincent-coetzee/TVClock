//
//  GridView.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/30.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

class GridView:UIScrollView
    {
    fileprivate var _contents:[UIView] = []
    fileprivate var _cellsPerRow:Int = 1
    fileprivate var _edgeInsets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    fileprivate let _contentView:UIView = UIView(frame:CGRect.zero)
    fileprivate var _padding:CGSize = CGSize.zero
    fileprivate var _rowHeight:CGFloat = 0
    
    open var rowHeight:CGFloat
        {
        get
            {
            return(_rowHeight)
            }
        set
            {
            _rowHeight = newValue
             setNeedsLayout()
            }
        }
    
    open var padding:CGSize
        {
        get
            {
            return(_padding)
            }
        set
            {
            _padding = newValue
             setNeedsLayout()
            }
        }
    
    open var contents:[UIView]
        {
        get
            {
            return(_contents)
            }
        set
            {
            for cell in _contents
                {
                cell.removeFromSuperview()
                }
            _contents = newValue
            for cell in _contents
                {
                _contentView.addSubview(cell)
                }
             setNeedsLayout()
            }
        }
    
    open var cellsPerRow:Int
        {
        get
            {
            return(_cellsPerRow)
            }
        set
            {
            _cellsPerRow = newValue
            setNeedsLayout()
            }
        }
    
    open var edgeInsets:UIEdgeInsets
        {
        get
            {
            return(_edgeInsets)
            }
        set
            {
            _edgeInsets = newValue
            setNeedsLayout()
            }
        }
    
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        self.addSubview(_contentView)
        _contentView.backgroundColor = UIColor.magenta
        _contentView.translatesAutoresizingMaskIntoConstraints = false
        }
    
    required init?(coder aDecoder: NSCoder)
        {
        super.init(coder:aDecoder)
        self.addSubview(_contentView)
        _contentView.backgroundColor = UIColor.magenta
        _contentView.translatesAutoresizingMaskIntoConstraints = false
        }
    
    override func layoutSubviews()
        {
        super.layoutSubviews()
        self.contentOffset = CGPoint.zero
        let xPadding = CGFloat(cellsPerRow - 1) * _padding.width + _edgeInsets.left + _edgeInsets.right
        let width = (self.bounds.size.width - xPadding) / CGFloat(_cellsPerRow)
        var offset = CGPoint(x:_edgeInsets.left,y:_edgeInsets.top)
        var cellIndex = 0
        for cell in _contents
            {
            cell.frame = CGRect(origin: offset, size: CGSize(width:width,height:_rowHeight))
            cell.backgroundColor = UIColor.red
            offset.x += width + _padding.width
            cellIndex += 1
            if cellIndex % _cellsPerRow == 0
                {
                offset.x = _edgeInsets.left
                offset.y += _rowHeight + _padding.height
                }
            }
        _contentView.frame = CGRect(origin:CGPoint(x:0,y:0),size:CGSize(width:self.bounds.size.width,height:offset.y + _rowHeight))
        self.contentSize = _contentView.bounds.size
        }
}
