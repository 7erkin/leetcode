import Foundation

struct Tweet {
    let id: Int
    let date: Int
    init(_ id: Int, _ date: Int) {
        self.id = id
        self.date = date
    }
}

final class Twitter {
    private var _internalTweetTimeId = 0
    private var userTweets: [Int:[Tweet]] = [:]
    private var followers: [Int:Set<Int>] = [:]
    private let maxTweetCountToGet = 10
    func postTweet(_ userId: Int, _ tweetId: Int) {
        if userTweets[userId] == nil {
            userTweets[userId] = []
        }
        _internalTweetTimeId += 1
        userTweets[userId]!.append(Tweet(tweetId, _internalTweetTimeId))
    }
    
    func getNewsFeed(_ userId: Int) -> [Int] {
        let selfTweets = userTweets[userId]?.reversed() ?? []
        var allTweets: [[Tweet]] = followers[userId]?.compactMap { userTweets[$0]?.reversed() } ?? []
        allTweets.append(selfTweets)
        let tweetCount = allTweets.reduce(0) { (acc, tweets) -> Int in
            return acc + tweets.count
        }
        let requiredTweetCount = tweetCount >= maxTweetCountToGet ? maxTweetCountToGet : tweetCount
        return (0..<requiredTweetCount).reduce(into: [Int]()) { (acc, _) in
            let tweets: [Tweet] = allTweets.compactMap { $0.isEmpty ? nil : $0[0] }
            let index = tweets.indexOfRecentlyTweet
            acc.append(tweets[index].id)
            if allTweets[index].count == 1 {
                allTweets.remove(at: index)
            } else {
                allTweets[index].remove(at: 0)
            }
        }
    }
    
    func follow(_ followerId: Int, _ followeeId: Int) {
        if followeeId == followerId { return }
        
        if followers[followerId] == nil {
            followers[followerId] = []
        }
        followers[followerId]!.insert(followeeId)
    }
    
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        if followerId == followeeId { return }
        
        followers[followerId]?.remove(followeeId)
    }
}

extension Array where Element == Tweet {
    var indexOfRecentlyTweet: Int {
        var index = 0
        self.enumerated().forEach { i, el in
            if el.date > self[index].date {
                index = i
            }
        }
        return index
    }
}