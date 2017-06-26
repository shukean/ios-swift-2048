//
//  Grid.swift
//  2048
//
//  Created by yky on 22/06/2017.
//  Copyright © 2017 yky. All rights reserved.
//

import UIKit

enum MoveDrection {
    case up, down, left, right
}

class Board : UIView{
    
    let cellNum : Int = 4
    let addTileNum : Int = 2
    let tileDefaultVal : Int = 2
    let thinPadding : CGFloat = 3.0
    let tileBgColor = UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 0.7)
    
    var boardWitdh : CGFloat
    var tileWidth : CGFloat
    
    var tiles : [[Tile?]]
    var tileMovedOrMerged : Bool = false
    
    var myGameOverDelegate : GameOverDelegate?
    
    init(width w : CGFloat, height h :CGFloat, backcolor bc : UIColor, gameDelegate: GameOverDelegate) {
        boardWitdh = w
        tileWidth = (boardWitdh - thinPadding * 5) / 4
        tiles = [[Tile?]](repeating:([Tile?](repeating: nil, count: cellNum)), count: cellNum)
        myGameOverDelegate = gameDelegate
        
        super.init(frame: CGRect(x: 0, y: 0, width: w, height: h))
        self.backgroundColor = bc
        setUpBackground()
        setUpAddTiles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpBackground(){
        var x = thinPadding
        var y = thinPadding
        for _ in 0..<cellNum{
            x = thinPadding
            for _ in 0..<cellNum{
                let tile = UIView(frame: CGRect(x: x, y: y, width: tileWidth, height: tileWidth))
                tile.backgroundColor = tileBgColor
                tile.layer.cornerRadius = 8
                addSubview(tile)
                x += tileWidth + thinPadding
            }
            y += tileWidth + thinPadding
        }
    }
    
    func printTiles() {
        var tmp : [[Int]] = [[Int]](repeating:([Int](repeating: 0, count:cellNum)), count: cellNum)
        for x in 0..<cellNum{
            for y in 0..<cellNum{
                if tiles[x][y] == nil {
                    tmp[x][y] = 0
                }else{
                    tmp[x][y] = 1
                }
            }
        }
        print(tmp)
    }
    
    func setUpAddTiles(){
        for _ in 0..<addTileNum{
            _ = insertRanddomPositionTile(value: tileDefaultVal)
        }
    }

    func positionForColumn(row: Int, col: Int) -> CGPoint{
        let y = thinPadding + CGFloat(row) * (tileWidth + thinPadding)
        let x = thinPadding + CGFloat(col) * (tileWidth + thinPadding)
        return CGPoint(x: x, y: y)
    }
    
    func insertTile(pos : (Int, Int), value : Int){
        let (row, col) = pos
        let pos = positionForColumn(row: row, col: col)
        let tile = Tile(position: pos, width: tileWidth, value: value)
        addSubview(tile)
        superview?.bringSubview(toFront: tile)
        print(row, col)
        tiles[row][col] = tile
    }
    
    func insertRanddomPositionTile(value: Int) -> Bool{
        let emptyTiles = getEmptyPositions()
        if emptyTiles.isEmpty {
            return false
        }
        let randomPos = Int(arc4random_uniform(UInt32(emptyTiles.count - 1)))
        let (x, y) = emptyTiles[randomPos]
        insertTile(pos: (x, y), value: value)
        return true
    }
    
    func getEmptyPositions() -> [(Int, Int)] {
        var emptyTiles : [(Int, Int)] = []
        for x in 0..<cellNum{
            for y in 0..<cellNum{
                if tiles[x][y] == nil {
                    emptyTiles.append((x, y))
                }
            }
        }
        return emptyTiles
    }
    
    func getRowNotEmptyPosition(row: Int) -> [Int] {
        var exist : [Int] = []
        for x in 0..<cellNum {
            if tiles[row][x] != nil {
                exist.append(x)
            }
        }
        return exist
    }
    
    func getColNotEmptyPosition(col : Int) -> [Int] {
        var exist : [Int] = []
        for y in 0..<cellNum {
            if tiles[y][col] != nil {
                exist.append(y)
            }
        }
        return exist
    }
    
    
    func moveTile(tile: Tile, fromX: Int, fromY: Int, toX: Int, toY: Int){
        if fromX == toX && fromY == toY {
            return
        }
        tiles[toX][toY] = tiles[fromX][fromY]
        let newPosition = positionForColumn(row: toX, col: toY)
        tile.run(duration: 0.2, position: newPosition, completion: nil)
        tiles[fromX][fromY] = nil
        tileMovedOrMerged = true
    }
    
    func mergeTiles(x: Int, y: Int, withTileAtIndex otherX : Int, otherY: Int){
        let merged = tiles[x][y]
        let other = tiles[otherX][otherY]
        let pos = positionForColumn(row: x, col: y)
        tiles[otherX][otherY] = nil
        
        other?.run(duration: 0.2, position: pos, completion: {
            (finished: Bool) in
            other?.removeFromSuperview()
            merged?.value *= 2
        })
        tileMovedOrMerged = true
    }
    
    func enableMergeTiles(x: Int, y: Int, otherX: Int, otherY: Int) -> Bool{
        return tiles[x][y]?.value == tiles[otherX][otherY]?.value
    }
    
    func moveLeft(){
        for row in 0..<cellNum{
            let exist = getRowNotEmptyPosition(row: row)
            let size = exist.count
            var i : Int = 0
            while i < size {
                if (i + 1 >= size){
                    break
                }
                if enableMergeTiles(x: row, y: exist[i], otherX: row, otherY: exist[i+1]){
                    mergeTiles(x: row, y: exist[i], withTileAtIndex: row, otherY: exist[i+1])
                    print("merge")
                    i+=1
                }
                print("unmerge")
                i+=1
            }
        }
        for row in 0..<cellNum{
            let exist = getRowNotEmptyPosition(row: row)
            print(exist)
//            continue
            if exist.isEmpty || exist.count == cellNum{
                continue
            }
            var enablePos = 0
            for x in 0..<exist.count {
                let tile = tiles[row][exist[x]]!
                moveTile(tile: tile, fromX: row, fromY: exist[x], toX: row, toY: enablePos)
                enablePos += 1
            }
            
        }
    }
    
    func moveRight(){
        for row in 0..<cellNum{
            let exist = getRowNotEmptyPosition(row: row)
            let size = exist.count
            var i : Int = size - 1
            while i >= 0 {
                if (i - 1 < 0){
                    break
                }
                if enableMergeTiles(x: row, y: exist[i], otherX: row, otherY: exist[i-1]){
                    mergeTiles(x: row, y: exist[i], withTileAtIndex: row, otherY: exist[i-1])
                    print("merge")
                    i-=1
                }
                print("unmerge")
                i-=1
            }
        }

        for row in 0..<cellNum{
            let exist = getRowNotEmptyPosition(row: row)
            print(exist)
//            continue
            if exist.isEmpty || exist.count == cellNum{
                continue
            }
            var enablePos = cellNum - 1
            for x in (0..<exist.count).reversed() {
                let tile = tiles[row][exist[x]]!
                moveTile(tile: tile, fromX: row, fromY: exist[x], toX: row, toY: enablePos)
                enablePos -= 1
            }
            
        }
    }
    
    func moveUp(){
        for col in 0..<cellNum{
            let exist = getColNotEmptyPosition(col: col)
            let size = exist.count
            var i : Int = 0
            while i < size {
                if (i + 1 >= size){
                    break
                }
                if enableMergeTiles(x: exist[i], y: col, otherX: exist[i+1], otherY: col){
                    mergeTiles(x: exist[i], y: col, withTileAtIndex: exist[i+1], otherY: col)
                    print("merge")
                    i+=1
                }
                print("unmerge")
                i+=1
            }
        }
        for col in 0..<cellNum{
            let exist = getColNotEmptyPosition(col: col)
            print(exist)
            //            continue
            if exist.isEmpty || exist.count == cellNum{
                continue
            }
            var enablePos = 0
            for x in 0..<exist.count {
                let tile = tiles[exist[x]][col]!
                moveTile(tile: tile, fromX: exist[x], fromY: col, toX: enablePos, toY: col)
                enablePos += 1
            }
            
        }
    }
    
    func moveDown(){
        for col in 0..<cellNum{
            let exist = getColNotEmptyPosition(col: col)
            let size = exist.count
            var i : Int = size - 1
            while i >= 0 {
                if (i - 1 < 0){
                    break
                }
                if enableMergeTiles(x: exist[i], y: col, otherX: exist[i-1], otherY: col){
                    mergeTiles(x: exist[i], y: col, withTileAtIndex: exist[i-1], otherY: col)
                    print("merge")
                    i-=1
                }
                print("unmerge")
                i-=1
            }
        }
        for col in 0..<cellNum{
            let exist = getColNotEmptyPosition(col: col)
            print(exist)
            //            continue
            if exist.isEmpty || exist.count == cellNum{
                continue
            }
            var enablePos = cellNum - 1
            for x in (0..<exist.count).reversed() {
                let tile = tiles[exist[x]][col]!
                moveTile(tile: tile, fromX: exist[x], fromY: col, toX: enablePos, toY: col)
                enablePos -= 1
            }
            
        }
    }
    
    
    func move(direction: MoveDrection){
        switch direction {
        case .up:
            moveUp()
            break
        case .down:
            moveDown()
            break
        case .left:
            moveLeft()
            break
        case .right:
            moveRight()
            break
        }
        printTiles()
        if tileMovedOrMerged {
            _ = insertRanddomPositionTile(value: tileDefaultVal)
            tileMovedOrMerged = false
        }
    }
    
    func isGameOver(){
        if getEmptyPositions().count > 0 {
            return
        }
        
        
        let end = OverView(width: boardWitdh, height: boardWitdh)
        addSubview(end)
        myGameOverDelegate?.setGameOver()
    }
}
