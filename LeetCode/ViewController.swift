//
//  ViewController.swift
//  LeetCode
//
//  Created by Shane on 2018/9/7.
//  Copyright © 2018 Shane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1
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
        wordPattern("abba", "dog cat cat dog")
        wordPattern("abba", "dog cat cat fish")
        wordPattern("aaaa", "dog cat cat dog")
        wordPattern("abba", "dog dog dog dog")
        wordPattern("aba", "dog dog dog dog")
    }
    

    
    
    // 2
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
        twoSum([2, 7, 11, 15], 15)
    }
  
    
    
    // 2
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
        addTwoNumbers(node1, node2)
    }
    
    // 寻找数组的中心索引
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
        
        for (index, value) in mutablNums.enumerated() {
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
    
    //  加一
    func plusOne(_ digits: [Int]) -> [Int] {
        var mutableDigits = digits
        var jinwei = 1
        
        if digits.count == 0 {
            return digits
        }
        
        for (index, value) in mutableDigits.enumerated() {
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
    
    // 对角线遍历
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
        let tmp4 = self.findDiagonalOrder([[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]])
        let tmp0 = self.findDiagonalOrder([[2,5],[8,4],[0,-1]])
       let tmp1 = self.findDiagonalOrder([[1,2,3],[4,5,6],[7,8,9]])

        let tmp2 = self.findDiagonalOrder([[1,2,3]])
        let tmp3 = self.findDiagonalOrder([[]])
    }
    
    
    //////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.testfindDiagonalOrder()
    }
}

