class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

final class Codec {
    func serialize(_ root: TreeNode?) -> String {
        guard root != nil else { return " " }
        var serializedNodeValues: [String] = []
        var nodes = [root]
        repeat {
            if let node = nodes.remove(at: 0) {
                serializedNodeValues.append(String(node.val))
                nodes += [node.left, node.right]
                continue
            }
            serializedNodeValues.append(" ")
        } while !nodes.isEmpty
        return serializedNodeValues.joined(separator: ",")
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        guard data != " " else { return nil }
        var serializedNodeValues = data.split(separator: ",")
        let root = TreeNode(Int(serializedNodeValues.remove(at: 0))!)
        var nodes = [root]
        repeat {
            let node = nodes.remove(at: 0)
            if let number = Int(serializedNodeValues.remove(at: 0)) {
                let leftNode = TreeNode(number)
                node.left = leftNode
                nodes.append(leftNode)
            }
            if let number = Int(serializedNodeValues.remove(at: 0)) {
                let rightNode = TreeNode(number)
                node.right = rightNode
                nodes.append(rightNode)
            }
        } while !serializedNodeValues.isEmpty
        return root
    }
}
