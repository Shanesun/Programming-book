# LeetCode
该repo用于记录LeetCode做题时的解题思路和Swift代码，该解题方式可能不是最优解，非常欢迎针对最优解的讨论和交流。

[14. 最长公共前缀](#14. 最长公共前缀)

### 14. 最长公共前缀
时间复杂度：O(n)
控件复杂度：O(1)

遍历一次`strs`数组，每两个比较一次获取 `commonPrefix` ，这样只需遍历一次O(n)时间复杂度。
> leetCode中使用`commonPrefix(with:`无法得到正确值，所以手写了一次匹配公共前缀逻辑，性能上不确定是否是最优。

``` objective-c
//MARK:14. 最长公共前缀
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 {
            return ""
        }
        guard var commonPrefix = strs.first else {
            return ""
        }
        
        for (index, value) in strs.enumerated() {
            if index == 0 { continue }
            if value == "" { return "" }
            if commonPrefix == value { continue }
            
//            let tmpPrefix = value.commonPrefix(with: commonPrefix!) // leetCode 编译器无法正确返回commonPrefix 方法
            let commonPrefixArray = Array(commonPrefix)
            let valueArray = Array(value)
            
            var tmpPrefix = ""
            for (prefixIndex, char) in commonPrefixArray.enumerated() {
                if prefixIndex < value.count {
                    if char == valueArray[prefixIndex] {
                        tmpPrefix.append(char)
                    } else {
                        break
                    }
                }
            }
            
            if tmpPrefix.count > 0 {
                commonPrefix = tmpPrefix
            } else {
                return ""
            }
        }
        
        return commonPrefix
    }
    
    func testlongestCommonPrefix() {
         _ = self.longestCommonPrefix(["abca","abc"])
        _ = self.longestCommonPrefix(["flower","flow","flight"])
        _ = self.longestCommonPrefix(["dog","racecar","car"])
        _ = self.longestCommonPrefix(["dog","racecar",""])
        _ = self.longestCommonPrefix([])
    }
```

