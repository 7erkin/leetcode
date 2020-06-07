final class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var tmp: [Int] = .init(repeating: 1, count: m)
        for _ in 1..<n {
            for j in 0..<m {
                if j != 0 {
                    tmp[j] += tmp[j - 1]
                }
            }
        }
        return tmp.last!
    }
}