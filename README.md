# LeetCode
该repo用于记录LeetCode做题时的解题思路和Swift代码，该解题方式可能不是最优解，非常欢迎针对最优解的讨论和交流。

## 算法
### 排序
好的排序排序算法时间复杂度应该是nlogn，以下是常见的7中排序：

| 名称 | 时间复杂度 | 空间复杂度 | 是否稳定 |
| --- | --- | --- | --- |
| 冒泡排序 | O(n^2) | O(1) | 是 |
| 插入排序 | O(n^2) | O(1) | 是 |
| 选择排序 | O(n^2) | O(1) | 否 |
| 堆排序 | O(nlogn) | O(1) | 否 |
| 归并排序 | O(nlogn) | O(n) | 是 |
| 快速排序 | O(nlogn) | O(logn) | 否 |
| 桶排序 | O(n) | O(k) | 是 |

### 双指针技巧
#### 对撞指针
**同时使用两个指针**进行迭代，使用双指针技巧的典型场景之一是你想要**从两端向中间迭代**数组。这时你可以使用双指针技巧：**一个指针从始端开始，而另一个指针从末端开始**。值得注意的是，这种技巧经常在**排序数组**中使用。

常见场景：
1. 反转数组中的元素  
2. 快速排序变种算法
3. 数据排序  

[344. 反转字符串](#344-反转字符串)  
[167. 两数之和 II - 输入有序数组](#167-两数之和-ii-输入有序数组)   

#### 滑窗指针
**使用两个指针一前一后遍历**，根据前后指针不同位置，指针闭区间内可以覆盖所有连续组合。



## LeetCode
[14. 最长公共前缀](#14-最长公共前缀)  
[27. 移除元素](#27-移除元素)  
[167. 两数之和 II - 输入有序数组](#167-两数之和-ii-输入有序数组)  
[209. 长度最小的子数组](209-长度最小的子数组)  
[344. 反转字符串](#344-反转字符串)  
[485. 最大连续1的个数](485-最大连续1的个数)  
[561. 数组拆分 I](#561-数组拆分-i)

### 14. 最长公共前缀
时间复杂度：O(n)  
控件复杂度：O(1)

遍历一次`strs`数组，每两个比较一次获取 `commonPrefix` ，这样只需遍历一次O(n)时间复杂度。
> leetCode中使用`commonPrefix(with:)`无法得到正确值，所以手写了一次匹配公共前缀逻辑，性能上不确定是否是最优。

``` objective-c
//MARK:14. 最长公共前缀
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0{
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
### 209. 长度最小的子数组
时间复杂度：O(n)  
控件复杂度：O(1)  
要求是连续子数组，所以我们必须定义 i，j两个指针，i 向前遍历，j 向后遍历，相当与一个滑块，这样所有的子数组都会在 [i...j] 中出现，如果 nums[i..j] 的和小于目标值 s，那么j向后移一位，再次比较，直到大于目标值 s 之后，i 向前移动一位，缩小数组的长度。遍历到i到数组的最末端，就算结束了，如果不存在符合条件的就返回 0。  

```swift
 func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        var pre = 0
        var after = -1
        var total = 0
        
        var lestCount = nums.count+1;
        
        while pre < nums.count {
            if after+1<nums.count && total<s {
                after += 1
                total += nums[after]
                
            } else {
                total -= nums[pre]
                pre += 1;
            }
            
            if total >= s {
                if  after - pre + 1 < lestCount {
                    lestCount = after - pre + 1
                }
            }
        }
        if lestCount == nums.count + 1 {
            return 0
        }
        
        return lestCount
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

### 167. 两数之和 II - 输入有序数组
时间复杂度：O(n^2 )  
空间复杂度：O(1)  
2次遍历数组，内存其实下标比外层大1。  

```objective-c
 //MARK: 167. 两数之和 II - 输入有序数组
    func twoSum2(_ numbers: [Int], _ target: Int) -> [Int] {
        if numbers.count == 0 {
            return numbers
        }
        for i in 0..<numbers.count {
            for j in i+1..<numbers.count {
                if numbers[i] + numbers[j] == target {
                    return [i+1, j+1]
                }
            }
        }
        
        return []
    }
    func testTwosum2() {
        _ = self.twoSum2([], 0)
        _ = self.twoSum2([2, 7, 11, 15], 0)
        _ = self.twoSum2([2, 7, 11, 15], 9)
        _ = self.twoSum2([2, 7, 11, 15], 26)
    }
```

### 27. 移除元素
时间复杂度：O(n)  
控件复杂度：O(1)  
**双指针**法，一个快指针执行遍历数据，一个慢指针指向需要储存被移除数据。遍历所有数据时间复杂度为O(n).同一个数组中储存未删除项和删除项，空间复杂度O(1)。  

```swift
//MARK: 27. 移除元素
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var startIndex = 0
        var removedIndex = nums.count-1
        
        while startIndex <= removedIndex {
            if nums[startIndex] == val {
                (nums[startIndex], nums[removedIndex]) = (nums[removedIndex], nums[startIndex])
                removedIndex -= 1
            } else {
                startIndex += 1
            }
        }
        
        if removedIndex < 0 {
            nums.removeAll()
        } else {
            nums.removeSubrange(removedIndex+1..<nums.endIndex)
        }
        
        return nums.count
    }
    func testRemoveElement() {
        var a1 = [3,2,2,3]
        _ = self.removeElement(&a1, 3)
        
        var a2 = [3]
        _ = self.removeElement(&a2, 3)
    }
```

### 485. 最大连续1的个数
时间复杂度：O(n)  
空间复杂度：O(1)  
遍历数组，时间复杂度O(n)。

```swift
//MARK: 485. 最大连续1的个数
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var mostLength = 0
        var tmpLength = 0
        for (index, value) in nums.enumerated() {
            if value == 1 {
                tmpLength += 1
            } else if value == 0 {
                if tmpLength > mostLength {
                    mostLength = tmpLength
                }
                tmpLength = 0
            }
            
            if index == nums.count-1 {
                if tmpLength > mostLength {
                    mostLength = tmpLength
                }
            }
        }
        
        return mostLength
    }
    func testFindMaxConsecutiveOnes() {
        _ = self.findMaxConsecutiveOnes([1,1,0,1,1,1])
        _ = self.findMaxConsecutiveOnes([])
        _ = self.findMaxConsecutiveOnes([0,0,0])
    }
```