# LeetCode
该repo用于记录LeetCode做题时的解题思路和Swift代码，该解题方式可能不是最优解，非常欢迎针对最优解的讨论和交流。

## 算法

### 双指针技巧
**同时使用两个指针**进行迭代，使用双指针技巧的典型场景之一是你想要**从两端向中间迭代**数组。这时你可以使用双指针技巧：**一个指针从始端开始，而另一个指针从末端开始**。值得注意的是，这种技巧经常在**排序数组**中使用。

常见场景：
1. 反转数组中的元素  
2. 快排
3. 数据排序


## LeetCode
[14. 最长公共前缀](#14-最长公共前缀)  
[344. 反转字符串](#344-反转字符串)  
[561. 数组拆分 I](#561-数组拆分-i)

### 14. 最长公共前缀
时间复杂度：O(n)  
控件复杂度：O(1)

遍历一次`strs`数组，每两个比较一次获取 `commonPrefix` ，这样只需遍历一次O(n)时间复杂度。
> leetCode中使用`commonPrefix(with:)`无法得到正确值，所以手写了一次匹配公共前缀逻辑，性能上不确定是否是最优。

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

### 344. 反转字符串
时间复杂度：O(n)  
空间复杂度：O(1)  
**使用双指针**一个在头部，一个在尾部，指针迭代向中间靠拢。

```objective-c
    //MARK:344. 反转字符串
    func reverseString(_ s: String) -> String {
        if s.count == 0 {
            return s
        }
        
        var sArray = Array(s)
        var startIndex = 0
        var endIndex = sArray.count - 1
        
        while startIndex < endIndex {
            let tmpStartValue = sArray[startIndex]
            sArray[startIndex] = sArray[endIndex]
            sArray[endIndex] = tmpStartValue;
            
            startIndex += 1
            endIndex -= 1
        }
        
        return String(sArray)
    }
    
    func testreverseString() {
        _ = reverseString("")
        _ = reverseString("A man, a plan, a canal: Panama")
    }
```

### 561. 数组拆分 I
时间复杂度：O(n) + O(nlogn)  
空间复杂度：O(n)  
观察需要数组按照从小到大排序，在按照数组下标为偶数相加，就是题目所求值。使用快排做排序时间复杂度O(nlogn)，快排空间复杂度为O(n)。排好后遍历下标偶数累加，时间复杂度O(n),空间复杂度O(1)  

```objective-c
//MARK: 561. 数组拆分 I
    // 快排排序 nlog(n)，便利: 2n,偶数下标相加
    func arrayPairSum(_ nums: [Int]) -> Int {
        func quickSort(_ array: [Int]) -> [Int]{
            guard array.count > 1 else {
                return array
            }
            
            let pivot = array.first!
            
            var less = [Int]()
            var equal = [Int]()
            var greater = [Int]()
            
            for i in 0..<array.count {
                if array[i] == pivot {
                    equal.append(array[i])
                }
                if array[i] < pivot {
                    less.append(array[i])
                }
                if array[i] > pivot {
                    greater.append(array[i])
                }
            }
            
            return quickSort(less) + equal + quickSort(greater)
        }
        
        if nums.count == 0 {
            return 0
        }
        
        var arrayNums = quickSort(nums)
        
        var totalNum = 0
        for index in 0..<arrayNums.count {
            if index*2 > arrayNums.count-1 {
                return totalNum
            }
            
            totalNum += arrayNums[index*2];
        }

        return totalNum
    }
    func testarrayPairSum() {
        
        _ = self.arrayPairSum([1,2,3,2])
        _ = self.arrayPairSum([1,4,3,2])
        _ = self.arrayPairSum([])
        _ = self.arrayPairSum([2,3])
        _ = self.arrayPairSum([-21,0,2,3])
    }
```