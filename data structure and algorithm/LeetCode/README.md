# LeetCode
用于记录LeetCode做题时的**解题思路**和 Swift 代码，该解题方式可能不是最优解。

[14. 最长公共前缀](./source/14.md)  
[27. 移除元素](#27-移除元素)  
[53. 最大子序和](./source/53.md)
[119. 杨辉三角 II](./source/119.md)  
[146. LRU缓存机制](./source/146.md)
[160. 相交链表](#160-相交链表)
[167. 两数之和 II - 输入有序数组](#167-两数之和-ii-输入有序数组)  
[189. 旋转数组](189-旋转数组) 
[200. 岛屿的个数](200-岛屿的个数)
[206. 反转链表](./source/206.md)
[209. 长度最小的子数组](./source/209.md)  
[344. 反转字符串](#344-反转字符串)  
[485. 最大连续1的个数](485-最大连续1的个数)  
[561. 数组拆分 I](#561-数组拆分-i)  

[打开转盘锁](打开转盘锁)

### 344. 反转字符串
时间复杂度：O(n)  
空间复杂度：O(1)  
**使用双指针**一个在头部，一个在尾部，指针迭代向中间靠拢。

```swift
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

```swift
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
### 160. 相交链表
时间复杂度：O(n )  
空间复杂度：O(1)  

方法一：
O(n^2) 时间复杂度

1. 嵌套 2 个 for 循环，找到第一个相同元素

方法二：
O(n) 时间复杂度 O(n)空间复杂度

1. 遍历 A 节点时，将 A 节点所有元素存到 map 中，map是以元素地址作为 key ，val 做为 value 。
2. 便利 B 节点，遍历时在 map 中查找当前对象在 map 中是否存在相同 key 元素如果第一个存在的元素就为最近相交节点。

方法三(最优)：

O(n) 时间复杂度， O(1) 空间复杂度

1. 便利 A 后获得 A 链表长度，便利 B 后获得 B 链表长度。
2. 2 个长度做差值，进行裁剪得到 2 个相同长度链表。
3. 同时遍历 2 个链表，遍历是比较 2 个元素是否相同。



```swift
class Solution {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
     

        guard let headA = headA, let headB = headB else {
            return nil
        }

      	// 获取 A 和 B 的长度
        var lengthOfA = getLisNodeLength(headA)
        var lengthOfB = getLisNodeLength(headB)

      	// 裁剪对齐 A 和 B
        var newHeadA: ListNode? = headA
        var newHeadB: ListNode? = headB
        var newLength = lengthOfA

        if lengthOfA > lengthOfB {
            newLength = lengthOfB
            var delta = lengthOfA - lengthOfB
            while delta > 0 {
                delta -= 1
                newHeadA = newHeadA?.next
            }
        } else if lengthOfA < lengthOfB  {
            newLength = lengthOfA
            var delta = lengthOfB - lengthOfA
            while delta > 0 {
                delta -= 1
                newHeadB = newHeadB?.next
            }
        }
        
      	// 同时比较 A 和 B
        while newLength > 0 {
            newLength -= 1
            if newHeadA === newHeadB {
                return newHeadA
            }
            newHeadA = newHeadA?.next
            newHeadB = newHeadB?.next
        }

        return nil
    }

    func getLisNodeLength(_ listNode: ListNode) -> Int {
        var length = 0
        var currentNode: ListNode? = listNode
        while currentNode != nil {
            length += 1
            currentNode = currentNode?.next
        }

        return length
    }
}
```

### 167. 两数之和 II - 输入有序数组
时间复杂度：O(n^2 )  
空间复杂度：O(1)  
2次遍历数组，内存其实下标比外层大1。  

```swift
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
### 189. 旋转数组
时间复杂度：O(n)  
控件负载度：O(1)  
方法一：while循环的终止条件是所有元素都遍历完。使用的是原地数据保存所有空间复杂度O(1)。  
方法二：思路更简单但是时间复杂度更高，空间复杂度还是O(1)。移动k次可以拆解成1+1+1...+1，每次右移一次，移动了k次。  

```swift
//方法一
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
```

```swift
// 方法二
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
```
### 200. 岛屿的个数

时间复杂度：O(n*m)  

控件复杂度：O(n)  

这个问题使用了BFS来解决：  

1. 嵌套for循环遍历所有点。
2. 最内层循环中只要当前的点等于"1"，则进行3.
3. 在2中对等于"1"点，进行BFS寻找所有临点的临点直到临点不为"1"。并且把BFS遍历过的置为"0"
4. 直到1中遍历完所有点。

因为使用了2层嵌套`O(n*m)`，并且在嵌套中进行了BFS遍历这是一个`n*m`,这是`O(n*m)`的一个常数，总时间复杂度就为`O(n*m)`。创建了一个数组存一次广度的所有邻居节点，所以最大则为`O(n)`。

```swift
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



### 750. 打开转盘锁

时间复杂度：  

控件复杂度：  

这道题说有一种可滑动的四位数的锁，貌似行李箱上比较常见这种锁。给了我们一个目标值，还有一些死锁的情况，就是说如果到达这些死锁的位置，就不能再动了，相当于迷宫中的障碍物。然后问我们最少多少步可以从初始的0000位置滑动到给定的target位置。如果各位足够老辣的话，应该能发现其实本质就是个迷宫遍历的问题，只不过相邻位置不再是上下左右四个位置，而是四位数字每个都加一减一，总共有八个相邻的位置。遍历迷宫问题中求最短路径要用BFS来做，那么这道题也就是用BFS来解啦，和经典BFS遍历迷宫解法唯一不同的就是找下一个位置的地方，这里我们要遍历四位数字的每一位，然后分别加1减1，我们用j从-1遍历到1，遇到0跳过，也就是实现了加1减1的过程。然后我们要计算要更新位上的数字，为了处理9加1变0，和0减1变9的情况，我们统一给该位数字加上个10，然后再加或减1，最后再对10取余即可，注意字符和整型数之间通过加或减'0'来转换。我们用结果res来记录BFS遍历的层数，如果此时新生成的字符串等于target了，直接返回结果res，否则我们看如果该字符串不在死锁集合里，且之前没有遍历过，那么加入队列queue中，之后将该字符串加入visited集合中

```c++
class Solution {
public:
    int openLock(vector<string>& deadends, string target) {
        unordered_set<string> deadlock(deadends.begin(), deadends.end());
        if (deadlock.count("0000")) return -1;
        int res = 0;
        unordered_set<string> visited{{"0000"}};
        queue<string> q{{"0000"}};
        while (!q.empty()) {
            ++res;
            for (int k = q.size(); k > 0; --k) {
                auto t = q.front(); q.pop();
                for (int i = 0; i < t.size(); ++i) {
                    for (int j = -1; j <= 1; ++j) {
                        if (j == 0) continue;
                        string str = t;
                        str[i] = ((t[i] - '0') + 10 + j) % 10 + '0';
                        if (str == target) return res;
                        if (!visited.count(str) && !deadlock.count(str)) q.push(str);        
                        visited.insert(str);
                    }
                }
            }
        }
        return -1;
    }
};
```

