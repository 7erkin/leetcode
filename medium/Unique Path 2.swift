final class Solution {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let rows = obstacleGrid.count
        let columns = obstacleGrid.first!.count
        var tmp: [Int] = .init(repeating: -1, count: columns)
        for i in 0..<rows {
            for j in 0..<columns {
                let isObstacle = obstacleGrid[i][j] == 1
                if j == 0 {
                    if tmp[j] == 0 {
                        continue
                    }
                    tmp[j] = isObstacle ? 0 : 1
                } else {
                    if tmp[j] == -1 {
                        if tmp[j - 1] == 0 {
                            tmp[j] = 0
                            continue
                        }
                        tmp[j] = isObstacle ? 0 : 1
                    } else {
                        if isObstacle {
                            tmp[j] = 0
                        } else {
                            tmp[j] += tmp[j - 1]
                        }
                    }
                }
            }
        }
        
        return tmp.last!
    }
}