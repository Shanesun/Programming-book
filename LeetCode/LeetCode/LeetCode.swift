//
//  LeetCode.swift
//  LeetCode
//
//  Created by Shane on 2018/9/30.
//  Copyright © 2018 Shane. All rights reserved.
//

import UIKit

class LeetCode: NSObject {
    //MARK: 字符串模板
    func wordPattern(_ pattern: String, _ str: String) -> Bool {
        let strArray = str.split(separator: " ")
        let characters = Array(pattern)
        
        if strArray.count != characters.count {
            return false
        }
        
        var strToPatternDic = [String: Character]();
        var selfPatternStrin = String()
        
        for (index, value) in strArray.enumerated() {
            let patternChar = characters[index]
            
            if let getPattern = strToPatternDic[String(value)] {
                selfPatternStrin.append(getPattern)
            } else {
                if strToPatternDic.values.contains(patternChar) {
                    return false;
                }
                
                strToPatternDic.updateValue(patternChar, forKey: String(value))
                selfPatternStrin.append(patternChar)
            }
        }
        
        print(selfPatternStrin)
        if pattern == selfPatternStrin {
            return true
        } else {
            return false
        }
    }
    func textWordPattern() {
        _ = wordPattern("abba", "dog cat cat dog")
        _ = wordPattern("abba", "dog cat cat fish")
        _ = wordPattern("aaaa", "dog cat cat dog")
        _ = wordPattern("abba", "dog dog dog dog")
        _ = wordPattern("aba", "dog dog dog dog")
    }
    
    //MARK: 两数求和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for (index, value) in nums.enumerated() {
            let wantInt = target - value
            for subIndex in index+1..<nums.count {
                let subValue = nums[subIndex]
                if wantInt == subValue {
                    return [index, subIndex]
                }
            }
        }
        
        return [Int]()
    }
    func textTwoSum() {
        _ = twoSum([2, 7, 11, 15], 15)
    }
    
    
    
    //MARK: 两数相加
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let one = l1 else {
            if let tow = l2 {
                return tow
            } else {
                return nil
            }
        }
        
        guard let two = l2 else {
            return one
        }
        
        var currentOneNode: ListNode? = nil
        var currentTwoNode: ListNode? = nil
        var currentJinWei = 0
        let resultNode = one
        var currentNode = resultNode
        
        currentOneNode = one
        currentTwoNode = two
        
        
        while (currentOneNode != nil || currentTwoNode != nil) {
            var totalValue = currentJinWei
            if let tmpOne = currentOneNode {
                totalValue = totalValue + tmpOne.val
            }
            if let tmpTwo = currentTwoNode {
                totalValue = totalValue + tmpTwo.val
            }
            
            if totalValue >= 10 {
                currentJinWei = totalValue / 10
                totalValue = totalValue%10
            } else {
                currentJinWei = 0
            }
            
            currentNode.val = totalValue
            
            currentOneNode = currentOneNode?.next
            currentTwoNode = currentTwoNode?.next
            
            if let one = currentOneNode {
                currentNode.next = one
                currentNode = one
            } else if let two = currentTwoNode {
                currentNode.next = two
                currentNode = two
            } else if currentJinWei > 0 {
                let newNode = ListNode.init(currentJinWei)
                
                currentNode.next = newNode
                currentNode = newNode
            } else {
                currentNode.next = nil;
            }
        }
        
        
        return resultNode
    }
    func textaddTwoNumbers() {
        let node1 = ListNode.init(4)
        node1.next = ListNode.init(1)
        
        let node2 = ListNode.init(6)
        _ = addTwoNumbers(node1, node2)
    }
    
    //MARK: 寻找数组的中心索引
    func pivotIndex(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return -1
        }
        
        let pivot = -1
        var leftValue = 0
        var rightValue = nums.count>1 ? nums[1...nums.count-1].reduce(0, +):nums[0]
        if leftValue == rightValue {
            return 0
        }
        
        for (index, value) in nums.enumerated() {
            if index > 0 && index < nums.count {
                leftValue = leftValue + nums[index-1]
                rightValue = rightValue - value
                if leftValue == rightValue {
                    return index
                }
            }
        }
        
        return pivot
    }
    
    //至少是其他数字两倍的最大数
    func dominantIndex(_ nums: [Int]) -> Int {
        guard var maxValue = nums.first else {
            return -1
        }
        
        var mutablNums = nums
        
        var maxIndex = 0
        for (index, value) in mutablNums.enumerated() {
            if value > maxValue {
                maxValue = value
                maxIndex = index
            }
        }
        
        mutablNums.remove(at: maxIndex)
        
        guard var secondValue = mutablNums.first else {
            return maxIndex
        }
        
        for (_, value) in mutablNums.enumerated() {
            if value > secondValue {
                secondValue = value
            }
        }
        
        if secondValue * 2 <= maxValue {
            return maxIndex
        }
        
        return -1
    }
    
    func textdominantIndex() {
        if self.dominantIndex([]) != -1 {
            print("error")
        }
        
        if self.dominantIndex([0]) != 0 {
            print("error")
        }
        
        if self.dominantIndex([2, 4]) != 1 {
            print("error")
        }
        
        if self.dominantIndex([3, 4]) != -1 {
            print("error")
        }
    }
    
    //MARK: 加一
    func plusOne(_ digits: [Int]) -> [Int] {
        var mutableDigits = digits
        var jinwei = 1
        
        if digits.count == 0 {
            return digits
        }
        
        for (index, _) in mutableDigits.enumerated() {
            if (jinwei > 0) {
                let plusValue = mutableDigits[mutableDigits.count-index-1] + jinwei
                jinwei = 0
                
                if plusValue >= 10 {
                    jinwei = (plusValue)/10
                    let value = plusValue%10
                    mutableDigits[mutableDigits.count-index-1] = value
                } else {
                    mutableDigits[mutableDigits.count-index-1] = plusValue
                    break
                }
            } else {
                break
            }
        }
        
        if jinwei > 0 {
            mutableDigits.insert(jinwei, at: 0)
        }
        
        return mutableDigits
    }
    
    func testPlusOne() {
        if self.plusOne([1,2,3]) != [1,2,4] {
            print("error")
        }
        if self.plusOne([9]) != [1,0] {
            print("error")
        }
    }
    
    //MARK: 对角线遍历
    /*
     typeH 0表示横向，1表示竖向。 根据方向来寻找规律。
     */
    func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
        var array = [Int]()
        
        var rIndex = 0
        var cIndex = 0
        
        var typeH = 0
        
        while rIndex < matrix.count && cIndex < matrix.last!.count {
            array.append(matrix[rIndex][cIndex])
            
            if rIndex >= matrix.count-1 && cIndex >= matrix.last!.count-1 {
                break
            }
            
            if rIndex == 0 {
                if typeH == 0 {
                    if cIndex == matrix[rIndex].count-1 {
                        rIndex = rIndex + 1
                    } else {
                        cIndex = cIndex + 1
                    }
                    
                    typeH = 1
                } else if (typeH == 1){
                    if rIndex == matrix.count-1 {
                        cIndex = cIndex + 1
                    } else {
                        rIndex = rIndex + 1
                        cIndex = cIndex - 1
                    }
                }
                
                continue
            } else if (typeH == 1 && cIndex != 0) {
                if rIndex == matrix.count-1 {
                    cIndex = cIndex + 1
                    typeH = 0
                } else {
                    rIndex = rIndex + 1
                    cIndex = cIndex - 1
                }
                
                continue
            }
            
            if cIndex == 0 {
                if typeH == 1 {
                    if rIndex == matrix.count-1 {
                        cIndex = cIndex + 1
                    } else {
                        rIndex = rIndex + 1
                    }
                    typeH = 0
                } else if (typeH == 0) {
                    if cIndex == matrix[rIndex].count - 1 {
                        rIndex = rIndex + 1
                        typeH = 1
                    } else {
                        rIndex = rIndex - 1
                        cIndex = cIndex + 1
                    }
                }
                
                continue
            } else if (typeH == 0 && rIndex != 0) {
                if cIndex == matrix[rIndex].count - 1 {
                    rIndex = rIndex + 1
                    typeH = 1
                } else {
                    rIndex = rIndex - 1
                    cIndex = cIndex + 1
                }
                continue
            }
        }
        
        return array
    }
    func testfindDiagonalOrder() {
        _ = self.findDiagonalOrder([[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]])
        _ = self.findDiagonalOrder([[2,5],[8,4],[0,-1]])
        _ = self.findDiagonalOrder([[1,2,3],[4,5,6],[7,8,9]])
        _ = self.findDiagonalOrder([[]])
    }
    
    //MARK:54. 螺旋矩阵
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var resultArray = [Int]()
        
        if matrix.count == 0 {
            return resultArray
        }
        
        var rIndex = 0
        var cIndex = 0
        var rIndexMax = matrix.count-1
        var cIndexMax = matrix[rIndex].count-1
        
        if rIndexMax-rIndex < 1 {
            for c in cIndex...cIndexMax {
                resultArray.append(matrix[rIndex][c])
            }
            
            return resultArray
        } else if cIndexMax-cIndex < 1 {
            for r in rIndex...rIndexMax {
                resultArray.append(matrix[r][cIndexMax])
            }
            
            return resultArray
        }
        
        while true  {
            for c in cIndex...cIndexMax {
                resultArray.append(matrix[rIndex][c])
            }
            
            for r in rIndex+1..<rIndexMax {
                resultArray.append(matrix[r][cIndexMax])
            }
            
            for c in cIndex...cIndexMax {
                resultArray.append(matrix[rIndexMax][matrix[rIndexMax].count-1-c])
            }
            
            for r in rIndex+1..<rIndexMax {
                resultArray.append(matrix[matrix.count-1 - r][cIndex])
            }
            
            
            cIndexMax = cIndexMax - 1
            cIndex = cIndex + 1
            
            rIndexMax = rIndexMax - 1
            rIndex = rIndex + 1
            
            if (cIndexMax<cIndex || rIndexMax<rIndex) {
                return resultArray;
            }
            
            if rIndexMax-rIndex < 1 {
                for c in cIndex...cIndexMax {
                    resultArray.append(matrix[rIndex][c])
                }
                
                return resultArray
            } else if cIndexMax-cIndex < 1 {
                for r in rIndex...rIndexMax {
                    resultArray.append(matrix[r][cIndexMax])
                }
                
                return resultArray
            }
        }
        
        
        return resultArray
    }
    func testspiralOrder() {
        //[[2,3,4],[5,6,7],[8,9,10],[11,12,13]]
        _ = self.spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]])
        _ = self.spiralOrder([[1,2],[3,4]])
        _ = self.spiralOrder([[3,2]])
        _ = self.spiralOrder([[3],[2]])
        _ = self.spiralOrder([
            [ 1, 2, 3 ],
            [ 4, 5, 6 ],
            [ 7, 8, 9 ]
            ])
    }
    
    //MARK: 118. 杨辉三角
    func generate(_ numRows: Int) -> [[Int]] {
        var array = [[Int]]()
        if numRows == 0 {
            return array
        }
        
        for index in 0..<numRows {
            var arrayOfRow = [Int]()
            if index == 0 {
                arrayOfRow.append(1)
                array.append(arrayOfRow)
                continue
            }
            for row in 0...index {
                if row == 0 || row == index {
                    arrayOfRow.append(1)
                } else {
                    let value = array.last![row-1] + array.last![row]
                    arrayOfRow.append(value)
                }
            }
            
            array.append(arrayOfRow)
        }
        
        return array
    }
    func testgenerate() {
        _ = self.generate(5)
        _ = self.generate(0)
        _ = self.generate(1)
    }
    
    //MARK:67. 二进制求和
    func addBinary(_ a: String, _ b: String) -> String {
        var result = String()
        if a.count == 0 {
            return b
        } else if b.count == 0{
            return a
        }
        
        var jinwei = 0
        
        var aArray = Array(b)
        var bArray = Array(a)
        if Array(a).count >= Array(b).count {
            aArray = Array(a)
            bArray = Array(b)
        }
        
        for (index, value) in aArray.enumerated().reversed() {
            if aArray.count-1-index < bArray.count {
                let bIndex = bArray.count-1 - (aArray.count-1-index)
                var plusValue = Int(String(value))! + Int(String(bArray[bIndex]))! + jinwei
                if plusValue >= 2 {
                    jinwei = 1
                    plusValue = plusValue%2
                    result.insert(Character(String(plusValue)), at: result.startIndex)
                } else {
                    jinwei = 0
                    result.insert(Character(String(plusValue)), at: result.startIndex)
                }
            } else {
                if jinwei == 1 {
                    let value = Int(String(value))! + jinwei
                    
                    if value >= 2 {
                        jinwei = 1
                        result.insert("0", at: result.startIndex)
                    } else {
                        jinwei = 0
                        result.insert(Character(String(value)), at: result.startIndex)
                    }
                } else {
                    let value = Int(String(value))!
                    result.insert(Character(String(value)), at: result.startIndex)
                }
            }
        }
        
        if jinwei == 1 {
            result.insert("1", at: result.startIndex)
            jinwei = 0
        }
        
        return result
    }
    func testaddBinary() {
        _ = self.addBinary("1111", "")
    }
    
    //MARK: 28. 实现strStr()
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.count == 0 {
            return 0
        }
        
        if haystack.count == 0 {
            return -1
        }
        
        let array = Array(haystack)
        let needArray = Array(needle)
        
        for (index, _) in array.enumerated() {
            for (needleIndex, needleValue) in needArray.enumerated() {
                if index + needleIndex > array.count-1 {
                    return -1
                }
                
                if array[index + needleIndex] == needleValue {
                    if needleIndex == needArray.count - 1 {
                        return index
                    }
                } else {
                    break
                }
            }
        }
        
        return -1
    }
    func teststrStr() {
        _ = self.strStr("", "a")
        _ = self.strStr("hello", "ll")
        _ = self.strStr("aaaaa", "bba")
        _ = self.strStr("a", "bba")
        _ = self.strStr("a", "")
        
    }
    
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
    
    //MARK: 209. 长度最小的子数组
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
    func testminSubArrayLen() {
        _ = self.minSubArrayLen(15, [5,1,3,5,10,7,4,9,2,8])
    }
    
    //MARK: 189. 旋转数组
    func rotate(_ nums: inout [Int], _ k: Int) {
        if nums.count == 0 || nums.count == 1 {
            return
        }
        
        var realK = k
        if k>nums.count {
            realK = k%nums.count
        }
        
        var i = 0
        var useCount = 0
        var j = i+realK
        var tmp = nums[i]
        var exchanged = nums[i]
        
        while useCount<nums.count {
            if j >= nums.count {
                j = j%nums.count
            } else {
                tmp = nums[j]
                nums[j] = exchanged
                exchanged = tmp
                
                useCount += 1
                
                if j == i {
                    i += 1
                    if i >= nums.count {
                        break
                    }
                    exchanged = nums[i]
                    j = i+realK
                } else {
                    j += realK
                }
            }
        }
    }
    //MARK: 189. 旋转数组(第二种方法)
    func rotate2(_ nums: inout [Int], _ k: Int) {
        if nums.count == 0 || nums.count == 1 {
            return
        }
        
        var realK = k
        if k > nums.count {
            realK = k%nums.count
        }
        
        for _ in 0..<realK {
            var exchange = nums[nums.count-1]
            var tmp = nums[0]
            
            for (index, value) in nums.enumerated() {
                tmp = value
                nums[index] = exchange
                exchange = tmp
            }
        }
    }
    
    //MARK: 119. 杨辉三角 II
    func getRow(_ rowIndex: Int) -> [Int] {
        var arr = [Int]()
        var preValue = 1
        
        for k in 0...rowIndex {
            for i in 0...k {
                if i == k {
                    arr.append(1)
                } else if i == 0 {
                    preValue = arr[i]
                    arr[i] = 1
                } else {
                    let tmpPreValue = arr[i];
                    
                    arr[i] = tmpPreValue + preValue
                    
                    preValue = tmpPreValue
                }
            }
        }
        
        return arr
    }
    
    // 200. 岛屿的个数
    func numIslands(_ grid: [[Character]]) -> Int {
        var numIsLands = 0
        if grid.count == 0 {
            return 0
        }
        
        var grid = grid
        
        struct Point {
            var i = 0
            var j = 0
        }
        
        // 广度优先
        func BFS( _ grid:inout [[Character]], _ row: Int, _ col: Int) {
            if grid[row][col] == "0" {
                return
            }
            
            var queue = [Point]()
            var tmpChild = [Point]()
            
            queue.append(Point(i: row, j: col))
            
            while queue.count > 0 {
                for (_, point) in queue.enumerated() {
                    // 上方节点
                    if (point.i - 1) >= 0 {
                        let childPoint = Point(i: point.i - 1, j: point.j)
                        if grid[point.i - 1][point.j] == "1" {
                            grid[childPoint.i][childPoint.j] = "0"
                            tmpChild.append(childPoint)
                        }
                    }
                    
                    // 左节点
                    if (point.j - 1) >= 0 {
                        let childPoint = Point(i: point.i, j: point.j-1)
                        if grid[point.i][point.j-1] == "1" {
                            grid[childPoint.i][childPoint.j] = "0"
                            tmpChild.append(childPoint)
                        }
                    }
                    
                    // 下方节点
                    if (point.i + 1) < grid.count {
                        let childPoint = Point(i: point.i+1, j: point.j)
                        if grid[childPoint.i][childPoint.j] == "1" {
                            grid[childPoint.i][childPoint.j] = "0"
                            tmpChild.append(childPoint)
                        }
                    }
                    
                    // 右方节点
                    if (point.j + 1) < grid[point.i].count {
                        let childPoint = Point(i: point.i, j: point.j+1)
                        if grid[childPoint.i][childPoint.j] == "1" {
                            grid[childPoint.i][childPoint.j] = "0"
                            tmpChild.append(childPoint)
                        }
                    }
                    
                }
                
                queue = tmpChild
                tmpChild.removeAll()
            }
            
        }
        
        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                if grid[row][col] == "1" {
                    BFS(&grid, row, col)
                    numIsLands += 1
                }
            }
        }
       
        return numIsLands
    }
}
