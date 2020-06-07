final class Solution {
    func minPathSum(_ grid: [[Int]]) -> Int {
        var tmp: [Int] = .init(repeating: -1, count: grid.first!.count)
        for r in grid {
            for (idx, el) in r.enumerated() {
                if idx == 0 {
                    if tmp[idx] == -1 {
                        tmp[idx] = el
                    } else {
                        tmp[idx] += el
                    }
                } else {
                    if tmp[idx] == -1 {
                        tmp[idx] = tmp[idx - 1] + el
                    } else {
                        tmp[idx] = min(tmp[idx], tmp[idx - 1]) + el
                    }
                }
            }
        }
        return tmp.last!
    }
}