---
title: 算法
type: docs
---
# 名词
    graph                           图
    TSP                             traveling salesman problem 旅行商问题
    graph-coloring-problem          图填色问题
    combinatorial problems          组合问题
    geometric algorithm             几何问题
    closest-pair problem            最近对时间
    convex-hull problem             凸包问题
    numerical problem               数值问题
    lexicographic order             字典序
    on-line algorithm               联机算法
    ADT abstract data type          抽象数据类型
    activation record               活动记录, 递归栈所存的信息
    stack frame                     栈桢, 同 activation record
    circular array                  循环数组
    amoritzed                       摊还
    biased deletion                 偏删除, 二叉树删除节点引起平衡不足问题的删除
    symbol table                    符号表, 编译器用
    tranposition table              变换表, 游戏用
    tick                            滴答, 模拟的一份时间
    external sorting                外部排序
    comparison-based sorting        基于比较的排序
    transposition table             置换表

# 排序
## 插入排序(insert sort)
```golang
/*
    插入排序

    时间 n^2, 稳定
    向前插入，先找位置再移动
*/
func InsertSort(arr []int) {
	length := len(arr)
	for i := 1; i < length; i++ {
		j := i - 1
		for j >= 0 {
			if arr[j] < arr[i] {
				break
			}
			j--
		}
		if j != i-1 {
			temp := arr[i]
			k := i - 1
			for ; k > j; k-- {
				arr[k+1] = arr[k]
			}
			arr[k+1] = temp
		}
	}
}

// 向前插入，边移动边找位置
func InsertSort2(arr []int) {
	length := len(arr)
	for i := 1; i < length; i++ {
		if arr[i-1] > arr[i] {
			temp := arr[i]
			j := i - 1
			for ; j >= 0 && arr[j] > temp; j-- {
				arr[j+1] = arr[j]
			}
			arr[j+1] = temp
		}
	}
}

// 向前插入，值向前冒泡
func InsertSort3(arr []int) {
	length := len(arr)
	for i := 1; i < length; i++ {
		for j := i - 1; j >= 0 && arr[j] > arr[j+1]; j-- {
			arr[j], arr[j+1] = arr[j+1], arr[j]
		}
	}
}
```

## 冒泡排序(bubble sort)
```golang
/*
    时间 n^2, 稳定
*/
func BubbleSort(arr []int) {
	length := len(arr)
	for i := 0; i < length; i++ {
		for j := 1; j < length-i; j++ {
			if arr[j-1] > arr[j] {
				arr[j-1], arr[j] = arr[j], arr[j-1]
			}
		}
	}
}

func BubbleSortSwapFlag(arr []int) {
	flag := true
	for i := len(arr); flag == true; i-- {
		flag = false
		for j := 1; j < i; j++ {
			if arr[j-1] > arr[j] {
				arr[j-1], arr[j] = arr[j], arr[j-1]
				flag = true
			}
		}
	}
}

func BubbleSortTailFlag(arr []int) {
	flag := len(arr)
	for flag > 1 {
		i := flag
		flag = 0
		for j := 1; j < i; j++ {
			if arr[j-1] > arr[j] {
				arr[j-1], arr[j] = arr[j], arr[j-1]
				flag = j
			}
		}
	}
}
```
## 选择排序(select sort)
```golang
/*
    时间 n^2, 不稳定
*/
func SelectSort(arr []int) {
	length := len(arr)
	for i := 0; i < length; i++ {
		ind := i
		for j := i + 1; j < length; j++ {
			if arr[ind] > arr[j] {
				ind = j
			}
		}
		arr[i], arr[ind] = arr[ind], arr[i]
	}
}
```
## 希尔排序(shell sort)
    概念
        diminishing increment sort(缩减增量排序)
        increment sequence(增量序列)
```golang
/*
	1 循环：选gap为一半长度
	2 循环：第一段gap
	3 循环gap间隔序列
	4 选择排序

	时间 n^(1.3-2), 不稳定
*/
func ShellSort(arr []int) {
	length := len(arr)
	for gap := length / 2; gap > 0; gap /= 2 {
		for i := 0; i < gap; i++ {
			for j := i + gap; j < length; j += gap {
				k := j - gap
				if arr[k] > arr[j] {
					temp := arr[j]
					for k >= 0 && arr[k] > temp {
						arr[k+gap] = arr[k]
						k -= gap
					}
					arr[k+gap] = temp
				}
			}
		}
	}
}

/*
	1 循环：选gap为一半长度
	2 循环：第一个gap之后每个元素为j
	3 j向前的gap间隔序列做选择排序
 */
func ShellSort2(arr []int) {
	length := len(arr)
	for gap := length / 2; gap > 0; gap /= 2 {
		for j := gap; j < length; j++ {
			k := j - gap
			if arr[k] > arr[j] {
				temp := arr[j]
				for k >= 0 && arr[k] > temp {
					arr[k+gap] = arr[k]
					k -= gap
				}
				arr[k+gap] = temp
			}
		}
	}
}

/*
	..
	最后用冒泡排序
*/
func ShellSort3(arr []int) {
	length := len(arr)
	for gap := length / 2; gap > 0; gap /= 2 {
		for i := gap; i < length; i++ {
			for j := i - gap; j >= 0 && arr[j] > arr[j+gap]; j -= gap {
				arr[j], arr[j+gap] = arr[j+gap], arr[j]
			}
		}
	}
}
```
## 桶排序(bucket sort)
    介绍
        将数据分到有限数量的桶子里，每个桶分别排序(可能再使用别的排序办法)
        当数据均匀分配时，时间复杂度是O(n), 不受O(nlogn)下限的影响
        适用于小范围、独立均匀分布的整数数据。可以计算数据量大，符合线性期望时间的排序
    步骤
        # 排序7, 36, 65, 56, 33, 60, 110, 42, 42, 94, 59, 22, 83, 84, 63, 77, 67, 101
        设置5个桶, 找到最大值110, 最小值7, 每个桶范围是(110 - 7 + 1)/5 = 20.8
        遍历原始数据，以链表结构分组放入桶中，公式为: 桶编号n = floor((a - 7) / 20.8)
        桶第二次插入数据时，进行插入排序的一次插入
        拼接5个桶

## 快速排序(quick sort)
```golang
/*
	分割，快排左右
	分割：
	1 取轴
	2 中位为start（轴本身占1位），循环除轴的节点
	2.1 节点值小时，中位后移，交换节点和中位的值
	3 交换轴与中位的值

	时间 n^2, 平均时间 nlog(n), 不稳定
*/
func QuickSort(arr []int, start int, end int) {
	swap := func(i int, j int) {
		arr[i], arr[j] = arr[j], arr[i]
	}
	partition := func(start int, end int) int {
		pivot := start
		val := arr[start]

		pos := start
		for i := start + 1; i <= end; i++ {
			if arr[i] < val {
				pos++
				swap(pos, i)
			}
		}
		swap(pivot, pos)
		return pos
	}
	if start < end {
		pivot := partition(start, end)
		QuickSort(arr, start, pivot-1)
		QuickSort(arr, pivot+1, end)
	}
}

/*
	..
	双指针法分割
	1 取轴为开头（或交换到开头），开头为左点，缓存值
	2 向中循环
	2.1 找到右点，向左点赋值
	2.2 找到左点，向右点赋值
	3. 找到中点，赋缓存值
*/
func QuickSort2(arr []int, start int, end int) {
	partition := func(start int, end int) int {
		i := start
		j := end
		val := arr[start]

		for i < j {
			for i < j && arr[j] >= val {
				j--
			}
			if i < j {
				arr[i] = arr[j]
				i++
			}
			for i < j && arr[i] < val {
				i++
			}
			if i < j {
				arr[j] = arr[i]
				j--
			}
		}
		arr[i] = val
		return i
	}
	if start < end {
		pivot := partition(start, end)
		QuickSort2(arr, start, pivot-1)
		QuickSort2(arr, pivot+1, end)
	}
}
```
{{< expand >}}
```golang
func TestQuickSort(t *testing.T) {
	assert := assert.New(t)
	arr := []int{8, 2, 4, 65, 2, 4, 7, 1, 9, 0, 2, 34, 12}
	QuickSort(arr, 0, len(arr)-1)
	assert.Equal([]int{0, 1, 2, 2, 2, 4, 4, 7, 8, 9, 12, 34, 65}, arr)
}
```
{{< /expand >}}
## 堆排序(heap sort)
```golang
/*
	数组表示大顶堆，pos为父节点时, pos*2+1为第一个子节点
	调整堆：父值非最大时下降
	1 给出父节点pos,找到儿子child。
	2 循环直到child越界
	2.1 找大儿子下降，更新pos，计算child

	构建堆: 默认给出数组为堆，从最后一个父节点pos=halfLen开始，向前一个个父节点调整堆

	堆排序:
	1 构建堆，重复2
	2 循环堆节点
	2.1 交换堆顶与末节点叶子, 下降堆顶

	时间 nlog(n), 不稳定
*/
func HeapSort(elements []int) {
	swap := func(i int, j int) {
		elements[i], elements[j] = elements[j], elements[i]
	}
	headAdjust := func(pos int, len int) {
		val := elements[pos]
		child := pos*2 + 1

		for child < len {
			if child+1 < len && elements[child] < elements[child+1] {
				child++
			}
			if elements[pos] >= elements[child] {
				break
			}

			elements[pos] = elements[child]
			pos = child
			child = pos*2 + 1
			elements[pos] = val
		}
	}

	buildHeap := func() {
		halfLen := len(elements) / 2
		for i := halfLen; i >= 0; i-- {
			headAdjust(i, len(elements))
		}

	}

	buildHeap()
	for i := len(elements) - 1; i > 0; i-- {
		swap(0, i)
		headAdjust(0, i)
	}
}

func HeapSort2(arr []int) {
	length := len(arr)
	swap := func(i int, j int) {
		arr[i], arr[j] = arr[j], arr[i]
	}
	parentPos := func(pos int) int {
		return (pos - 1) / 2
	}
	child1Pos := func(pos int) int {
		return pos*2 + 1
	}
	fixDown := func(pos int, l int) {
		val := arr[pos]
		child := child1Pos(pos)
		for child < l {
			if child+1 < l && arr[child+1] > arr[child] {
				child++
			}
			if arr[child] <= val {
				break
			}
			arr[pos] = arr[child]
			pos = child
			child = child1Pos(pos)
		}
		arr[pos] = val
	}
	buildHeap := func() {
		lastParentPos := parentPos(length - 1)
		for i := lastParentPos; i >= 0; i-- {
			fixDown(i, length)
		}
	}

	buildHeap()
	for i := length - 1; i > 0; i-- {
		swap(0, i)
		fixDown(0, i)
	}

	//fixUp := func(child int) {
	//	val := arr[child]
	//	pos := parentPos(child)
	//	for pos >= 0 && child > 0 {
	//		if arr[pos] >= val {
	//			break
	//		}
	//		arr[child] = arr[pos]
	//		child = pos
	//		pos = parentPos(child)
	//	}
	//	arr[child] = val
	//}
}
```
{{< expand >}}
```golang
func TestHeapsort(t *testing.T) {
	assert := assert.New(t)
	elements := []int{3, 1, 5, 7, 2, 4, 9, 6, 10, 8, 33, 2, 21, 2, 15, 22, 77, 11, 0, -1, 23345, 12}
	HeapSort(elements)
	assert.Equal(
		[]int{-1, 0, 1, 2, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 15, 21, 22, 33, 77, 23345},
		elements,
	)
}
```
{{< /expand >}}
## 归并排序(merge sort)
```golang
/*
    时间 nlog(n)
*/
func MergeSort(arr []int) {
	length := len(arr)
	temp := make([]int, length)

	merge := func(start int, mid int, end int) {
		i := start
		j := mid + 1
		m := mid
		n := end
		k := 0
		for i <= m && j <= n {
			if arr[i] <= arr[j] {
				temp[k] = arr[i]
				k++
				i++
			} else {
				temp[k] = arr[j]
				k++
				j++
			}
		}
		for i <= m {
			temp[k] = arr[i]
			k++
			i++
		}
		for j <= n {
			temp[k] = arr[j]
			k++
			j++
		}
		for r := 0; r < k; r++ {
			arr[start+r] = temp[r]
		}
	}

	recurse := func(start int, end int) {}
	recurse = func(start int, end int) {
		if start < end {
			mid := (start + end) / 2
			recurse(start, mid)
			recurse(mid+1, end)
			merge(start, mid, end)
		}
	}

	recurse(0, length-1)

}
```
# 查找
## 二分查找(binary search)
```golang
/*
    时间 log(n)
*/
func BinarySearch(nums []int, low int, high int, val int) int {
	for low <= high {
		mid := (low + high) / 2
		if nums[mid] == val {
			return mid
		} else if nums[mid] > val {
			high = mid - 1
		} else {
			low = mid + 1
		}
	}
	return -1
}

/*
    递归
*/
func BinarySearch2(nums []int, low int, high int, val int) int {
	if low > high {
		return -1
	}
	mid := (low + high) / 2
	if nums[mid] == val {
		return mid
	} else if nums[mid] > val {
		return BinarySearch2(nums, low, mid-1, val)
	} else {
		return BinarySearch2(nums, mid+1, high, val)
	}
}

```
## 倒排索引
# 数字
```golang

/*
	返回第n个斐波那契数

	时间 n
*/
func Fibonacci(n int) int {
	if n < 3 {
		return 1
	}
	a, b := 1, 1
	for i := 3; i <= n; i++ {
		r := a + b
		a, b = b, r
	}
	return b
}

/*
	时间 n
*/
func Fibonacci2(n int) int {
	if n < 3 {
		return 1
	}
	return Fibonacci2(n-2) + Fibonacci2(n-1)
}

/*
	猴子吃桃：每天吃一半加1个，第n天剩1个，一共几个
*/
func MonkeyEat(n int) int {
	if n == 1 { //指倒数第一天
		return 1
	}
	return MonkeyEat(n-1)*2 + 2
}

/*
	爬楼梯问题：一次走1或2级，爬上n级有多少走法

	要走到n+1层，只能从n层或n-1层走。n+1层方法数为n层与n-1层方法数的和。所以是个斐波那契数列问题
*/
func ClimbStairs(n int) int {
	if n == 1 {
		return 1
	}
	if n == 2 {
		return 2
	}
	return ClimbStairs(n-1) + ClimbStairs(n-2)
}

/*
	正整数和
	递归
*/
func CommonSum(n int) int {
	if n == 1 {
		return 1
	}
	return CommonSum(n-1) + n
}

/*
	最大公约数

	每执行一次循环, m或n至少缩小了2倍，故时间复杂度上限为log(2)(M),M是循环次数
	对于大量随机测试样例, 每次循环能便m与n值缩小一个10进位，所以平均复杂度为O(lgM)
*/
func GCD(m int, n int) int {
	var max, min int
	if m > n {
		max, min = m, n
	} else {
		max, min = n, m
	}
	for max%min != 0 {
		r := max % min
		max = min
		min = r
	}
	return min
}

/*
	..

	递归

	时间 logM 空间 logM
*/
func GCD2(m int, n int) int {
	var max, min int
	if m > n {
		max, min = m, n
	} else {
		max, min = n, m
	}

	if max%min == 0 {
		return min
	}
	return GCD2(min, max%min)
}

/*
	最小公倍数
*/
func LCM(m int, n int) int {
	return m * n / GCD(m, n)
}

/*
	最大子序列和

	时间 n
*/
func SumArr(arr []int) int {
	tmp := arr[0]
	max := tmp

	for i := 1; i < len(arr); i++ {
		if tmp >= 0 {
			tmp += arr[i]
		} else {
			tmp = arr[i]
		}

		if max < tmp {
			max = tmp
		}
	}
	return max
}
```
# 数组
## 翻转
```golang

/*
	翻转数组

	双指针
	时间 n，空间 1
*/
func Inverse(arr []int) {
	for i, j := 0, len(arr)-1; i < j; i, j = i+1, j-1 {
		arr[i], arr[j] = arr[j], arr[i]
	}
}

/*
	单指针
*/
func Inverse2(arr []int) {
	length := len(arr)
	for i, half := 0, length/2; i < half; i++ {
		j := length - 1 - i
		arr[i], arr[j] = arr[j], arr[i]
	}
}
```
## 轮换
```golang
/*
	轮换，如：[1,2,3,4,5],指定2时，结果[4,5,1,2,3]

	翻转前段，翻转后段，再整体翻转

	时间 n，空间 1
*/
func Rotate(arr []int, k int) {
	if k == 0 {
		return
	}

	length := len(arr)
	if k >= length {
		k = k % length
	}

	inverse := func(start int, end int) {
		for i, j := start, end; i < j; i, j = i+1, j-1 {
			arr[i], arr[j] = arr[j], arr[i]
		}
	}
	inverse(0, length-1-k)
	inverse(length-k, length-1)
	inverse(0, length-1)
}
```
## 回文
```golang
/*
	回文
*/
func IsPalindrome(s string) bool {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		if s[i] != s[j] {
			return false
		}
	}
	return true
}

/*
	回文数
	1. 计算位
	2. 循环到half
	2.1 判断高低位余数。
		如 num = 12321, 则 t = 10000
		第一步 1 == (12321 / 10000) % 10 == 12321 % 10
		t /= 10 , 12321 /= 10
		第二步 2 == (12321 ／ 1000) % 10 == 1232 % 10
		判断成功
*/
func IsPalindromeNum(num int) bool {
	if num < 10 {
		return true
	}

	countWei := func() int {
		num := num
		count := 0
		for num > 0 {
			num /= 10
			count++
		}
		return count
	}

	wei := countWei()
	t := math.Pow(10, float64(wei-1))
	half := wei / 2
	n := num
	for i := 0; i < half; i++ {
		if (num/int(t))%10 == n%10 {
			t /= 10
			n /= 10
		} else {
			return false
		}
	}
	return true
}
/*
	最长回文子串

	时间 n^3
*/
func LongestPalindrome(s string) string {
	isPalindrome := func(start int, end int) bool {
		for start < end {
			if s[start] != s[end] {
				return false
			}
			start++
			end--
		}
		return true
	}

	length := len(s)
	from, to, max := 0, 0, 0
	for i := 0; i < length; i++ {
		for j := i; j < length; j++ {
			if isPalindrome(i, j) && (j-i) > max {
				from, to = i, j
				max = to - from
			}
		}
	}

	return s[from : to+1]
}

/*
	中心扩展法

	1 循环所有元素i（i为中心）
	2 循环向两边扩展 start, end。(start=i, end=i+1查找偶数串)
	2.1 记录left, right回文子串
	3 记录此i中心边缘子串是否最大
	*2 ..(start=i-1, end=i+1查找奇数串)
	*3 ..

	时间 n^2，空间 1
 */
func LongestPalindrome2(s string) string {
	maxLeft, maxRight, max := 0, 0, 1
	length := len(s)
	for i := 0; i < length; i++ {
		start, end, length1 := i, i+1, 0
		left, right := start, end
		for start >= 0 && end < length {
			if s[start] == s[end] {
				left, right, length1 = start, end, length1+2
				start, end = start-1, end+1
			} else {
				break
			}
		}
		if length1 > max {
			maxLeft, maxRight, max = left, right, length1
		}

		start, end, length1 = i-1, i+1, 1
		left, right = start, end
		for start >= 0 && end < length {
			if s[start] == s[end] {
				left, right, length1 = start, end, length1+2
				start, end = start-1, end+1
			} else {
				break
			}
		}
		if length1 > max {
			maxLeft, maxRight, max = left, right, length1
		}
	}
	return s[maxLeft : maxRight+1]
}
```
{{< expand >}}
```golang
func TestLongestPalindrome(t *testing.T) {
	assert := assert.New(t)
	assert.Equal("woabcbaow", LongestPalindrome("sdbsdaswoabcbaowe"))
}

func TestLongestPalindrome2(t *testing.T) {
	assert := assert.New(t)
	assert.Equal("woabcbaow", LongestPalindrome2("sdbsdaswoabcbaowe"))
}
```
{{< /expand >}}
## 连续正整数和为s的序列
```golang

/*
	描述：给正整数s, 写出连续正整数和为s的所有序列

	双指针法
	由等差数列求和公式知，数列最开始不能过一半
	移end加sum, 移start减sum
	sum找到后，只能同时加减sum，即同时移start、end
*/
func SeriesSum(s int) {
	half := (s + 1) / 2
	start := 1
	end := 2
	sum := 0

	for start < half {
		sum = (start + end) * (end - start + 1) / 2
		if sum == s {
			println(start, end)
			start++
			end++
		} else if sum < s {
			end++
		} else {
			start ++
		}
	}
}
```
## 两元素和为s(升序不重复数组)
```golang
/*
	升序不重复数组中，所有两个元素和为s的组合
	时间 n^2
*/
func TwoSum(arr []int, s int) {
	n := len(arr)

	for i := 0; i < n-1; i++ {
		for j := i + 1; j < n; j++ {
			if arr[i]+arr[j] == s {
				println(i, j)
				break
			}
		}
	}
}

/*
	二分查找

	时间 nlog(n)
*/
func TwoSum2(arr []int, s int) {
	n := len(arr)
	for i, j := 0, 0; i < n-1; i++ {
		another := s - arr[i]
		j = sort.SearchInts(arr, another)
		if j > i {
			println(i, j)
		}
	}
}

/*
	双指针

	移i加sum, 移j减sum
	sum找到后，只能同时加减sum，即同时移i,j

	时间 n
*/
func TwoSum3(arr []int, s int) {
	i := 0
	j := len(arr) - 1
	for i < j {
		if arr[i]+arr[j] == s {
			println(i, j)
			i++
			j--
		} else if arr[i]+arr[j] < s {
			i++
		} else {
			j--
		}
	}
}
```
{{< expand >}}
```golang
func TestTwoSum(t *testing.T) {
	TwoSum([]int{ 1, 2, 3, 4, 5, 6, 7, 8, 9 },10)
}
```
{{< /expand >}}
## 有序数组去重
```golang
/*
	有序数组去重

	时间 n，空间 n
*/
func RemoveDuplicates(arr []int) int {
	if arr == nil || len(arr) == 0 {
		return 0
	}
	if len(arr) == 1 {
		return 1
	}

	end := len(arr) - 1
	list0 := list.New()

	for i := 0; i <= end; {
		if i == end {
			list0.PushBack(arr[i])
			i++
		} else {
			j := i + 1
			if arr[i] == arr[j] {
				for j <= end && arr[i] == arr[j] {
					j++
				}
			}
			list0.PushBack(arr[i])
			i = j
		}
	}

	eleInd := 0
	for ele := list0.Front(); nil != ele; ele = ele.Next() {
		arr[eleInd] = ele.Value.(int)
		eleInd++
	}
	return eleInd
}

/*
	..
	时间 n，空间 1
*/
func RemoveDuplicates2(arr []int) int {
	if arr == nil || len(arr) == 0 {
		return 0
	}
	if len(arr) == 1 {
		return 1
	}

	length := len(arr)
	num := 1
	for i, tmp := 1, arr[0]; i < length; i++ {
		if arr[i] != tmp {
			arr[num] = arr[i]
			tmp = arr[i]
			num++
		}
	}
	return num
}
```
# 字符串
## 最后一词长度
```golang
func LastWordLen(s string) int {
	isLetter := func(c uint8) bool {
		if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') {
			return true
		} else {
			return false
		}
	}
	length := len(s)
	if length < 1 {
		return 1
	}
	pos := length - 1
	for pos >= 0 {
		if isLetter(s[pos]) {
			break
		} else {
			pos--
		}
	}
	retLen := 0
	for pos >= 0 {
		if !isLetter(s[pos]){
			break
		} else {
			pos--
			retLen++
		}
	}
	return retLen
}
```
## 翻转词序
```golang
/*
	翻转词序
*/
func ReverseWords(s []rune) {
	reverse := func(start int, end int) {
		for start < end {
			s[start], s[end] = s[end], s[start]
			start++
			end--
		}
	}

	if s == nil || len(s) <= 1 {
		return
	}
	n := len(s)
	i := 0
	for i < n {
		j := i
		for j < n {
			if s[j] == ' ' {
				break
			} else {
				j++
			}
		}
		reverse(i, j-1)
		for j < n && s[j] == ' ' {
			j++
		}
		i = j
	}
	reverse(0, n-1)
}
```
{{< expand >}}
```golang
func TestReverseWords(t *testing.T) {
	assert := assert.New(t)
	s := []rune("in the world")
	ReverseWords(s)
	assert.Equal([]rune("world the in"), s)
}
```
{{< /expand >}}
## 同字异序
```golang
const ALPHABET_LENGHT = 26
/*
	是否同字异序, 如eel, lee
*/
func Anagram(source string, target string) bool {
	if len(source) != len(target) {
		return false
	}
	length := len(source)
	table1 := make([]int, ALPHABET_LENGHT)
	table2 := make([]int, ALPHABET_LENGHT)

	for i := 0; i < length; i++ {
		table1[source[i]-'a']++
		table2[target[i]-'a']++
	}
	for i := 0; i < ALPHABET_LENGHT; i++ {
		if table1[i] != table2[i] {
			return false
		}
	}
	return true
}
```
## count and say
```golang
/*
	题目解释：原题的意思就是用一个新的字符串描述上一个字符串，用数字表示上一个：
	当n=1时：输出1；
	当n=2时，解释1，1读作1个 ，表示为11；
	当n=3时，解释上一个11，读作2个1，表示为21；（注意相同数字的描述）
	当n=4时，解释上一个21，读作1个2，一个1，表示为1211；
	当n=5时，解释上一个1211，读作1个1，1个2，2个1，表示为111221；
	当n=6时，解释上一个111221，读作3个1，2个2，1个1，表示为312211；

	时间 n^3, 空间 n^2, n是输入的值
*/
func CountAndSay(n int) string {
	if n <= 0 {
		return ""
	}
	if n == 1 {
		return "1"
	}
	if n == 2 {
		return "11"
	}
	s := "11"
	result := ""
	for i := 3; i <= n; i++ {
		temp := s[0]
		count := 1
		for j := 1; j < len(s); j++ { // len的时间复杂度在for中越来越接近n^2
			if s[j] == temp {
				count++
			} else {
				// result的长度越来越接近n^2
				result += strconv.Itoa(count) + strconv.Itoa(int(temp-48))
				count = 1
				temp = s[j]
			}
		}
		result += strconv.Itoa(count) + strconv.Itoa(int(temp-48))
		s = result
		result = ""
	}
	return s
}
```
## 模式匹配
```golang
/*
	模式匹配，brute force法
	时间 m*n，空间1
*/
func BruteForce(s string, matcher string) int {
	m := len(s)
	n := len(matcher)
	for i := 0; i < m; i++ {
		count := 0
		for j := 0; j < n && i+j < m; j++ {
			if s[i+j] != matcher[j] {
				break
			} else {
				count++
			}
		}
		if count == n {
			return i
		}
	}
	return -1
}

/*
	时间m+n
*/
func KMP() {

}
```
# 图
## BFS(breadth first search)
## DFS(depth first search)
## A*
    启发式搜索
## Dijkstra
## Bellman-Ford
## Floyd-Warshall
# 动态规划
## 背包问题
    背包有大小，物品有大小和价值，向背包装最大价值物品
## 最长公共子串
# 分类与回归
    分类是编组，回归是预测
## k最近邻(KNN, k-nearest neighbours)
    实现
        特征抽取

    应用
        推荐系统
## 贝叶斯
# 概率算法
## 布隆过滤器
    介绍
        判断值一定不存在，或可能存在
        高效插入和查询
        占空间中，hash占空间大
    实现
        bitmap，多个hash函数
        插入值计算多个hash, bit数组位置变1
        查找值计算多个hash, 找bit数组位置是否全为1
        不可删除

        拆分到多bitmap时，key先hash到bitmap
    应用
        redis用setbit()和getbit()
## hyperLogLog
    介绍
        来值, 去重计数(基数)
        占空间小, hash占空间大
    实现
        来值, 计算hash再转bit数组，取前导0的数量n。
        比较保存所有n的最大值为max
        基数就为 2^(max+1)

        o-> 减误差, 用桶
        分桶m个，来值的bit数组为, 前几位映射到桶, 后面位记录前导0数量
            # 分桶数根据需要的RSD(相对标准误差)来计算
        每桶有个max
        基数为 桶数x2^(avg(max1+1, max2+1...))
            # LogLog算法avg用平均数, hyperLogLog的avg用调和平均数
        基数乘一个常数来修正到具体值
            # 常数用桶数计算: switch(log2(桶数)), 分情况取参数v, 常数就为 参数x桶数^2

        o-> 减误差, 数量小时预测偏大问题
        算出基数小于(5/2)*桶数时
        基数为 桶数xlog2(桶数/空桶数)

    应用
        redis用pfadd()和pfcount()
# 线性规划
    图算法是线性规划的子集
## 单纯形法(simplex)
    每一次迭代比前次更优
# hash
    介绍
        将任意长度二进制值映射到较短固定长度二进制值。改一个值会生成不同的哈希
        同一个哈希(散列)的二进制值是不存在的
        常见的有: md5, sha, sha1, sha256, sha512, RSA-SHA
    问题
        冲突，拉链
        填装因子: 元素数/总位置数
        散列函数
# 傅里叶变换
    描述
        所有波都可以用多个正弦波叠加表示
    应用
        声音中分离出噪声、人声
        图像增大高频信号提高对比度，相机找高频分量最大来自动对焦
# 加密
    签名
        公钥
            dsa
            ecdsa
            rsa
    散列
        sha
            特点
                sha-0, sha-1已发现缺陷。用sha-2, sha-3和bcrypt
                局部修改敏感
            应用
                比较文件
                计算比较密码
    diffie-hellman
        特点
            双方不需知道加密算法
            公钥和私钥，客户用公钥加密，服务端用私钥解密
# 种群统计
```golang
/*
    统计二进制串置位(位值是1)数

    8位全1数为255, 缓存0-255数的置位数到pc。值为0,1,1,2,1,2,...
    byte()会截断8位，如byte(256) = 0
    byte(x>>(0*8))得到x低8位截断数值，byte(x>>(1*8))得到x低9-16位截断数值
    累加8段数值在pc中映射的置位数，得到x的置位数

    时间 n/8
*/
func Count(x uint64) int {
    var pc [256]byte
	for i := range pc {
		pc[i] = pc[i/2] + byte(i&1)
	}
	count := int(pc[byte(x>>(0*8))] +
        pc[byte(x>>(1*8))] +
        pc[byte(x>>(2*8))] +
        pc[byte(x>>(3*8))] +
        pc[byte(x>>(4*8))] +
        pc[byte(x>>(5*8))] +
        pc[byte(x>>(6*8))] +
        pc[byte(x>>(7*8))])
    return count
}
```
# 资源
    token bucket
        # 令牌桶
        通过多少流量，删除多少令牌
        突发流量
            丢弃
            排队
            特殊标记发送，网络过载时丢弃加标记的包
        过程
            产生令牌
            消耗令牌
            判断数据包是否通过
        作用
            限制平均传输速率，允许突发传输
    leaky bucket
        # 漏桶
        作用
            强行限制数据传输速率
    max-min fairness
        # 加权分配资源
        dominant resource fairness (DRF)
            # 一种 max-min fairness实现，可以多资源分配
# 分布式算法
    特点
        分布性，并发性
    一致性hash
        # 负载
        取余hash
            服务器号 % 节点数      # 容错性和扩展性不好
        一致性hash
            建立环坐标, hash每个ip到坐标, 称为节点
            hash每个请求到坐标，顺序向后找第一个节点处理
        均匀一致性hash
            设置虚拟节点, 使请求分配尽量均匀
        虚拟槽     # redis
            建固定数个槽, 节点负责多个槽，请求映射到槽
    paxos
        # 共识(consensus)算法
        角色
            proposer        # 提案发起者
            acceptor        # 提案投票者
            learner         # 提案chosen后，同步到其它acceptor
        第一阶段
            proposer向超过半数acceptor发送prepare(带编号和value)
            acceptor收到prepare, 编号最大时回复promise(带上之前最大value), 小则不理会
        第二阶段
            proposer收到超过半数promise, 选取最大value, 发送accept
            acceptor收到accept, 编号同自身时更新value, 回复accepted
    raft
        # 共识算法
        角色
            leader      # 接受请求，向follower同步请求日志并通知提交日志
            follower
            candidate   # leader选举中的临时角色
        过程
            开始一个leader,其它follower
            leader挂掉，一个follower timeout变为candidate, 发送选举请求(RequestVote)
            超一半同意，该节点变leader, 并发送heartbeat持续刷新timeout
            两个candidate未过半，等timeout后重试
            旧leader重连，选举编号小，自动变follower
    BFT(拜占庭算法)
        # 在部分捣乱中达成一致
        总数大于3m, 背叛m，可达成一致
    PBFT(实用拜占庭算法)
        pre-prepare
        prepare
        commit
    map-reduce
        映射函数
        归并函数
# NP问题
    介绍
        polynomial problem(p问题), 可以在多项式时间内解决的问题
        non-deterministic polynomial problem(np, 非确定性多项式问题)，指可以在多项式时间内得到一个解的问题
        non-deterministic polynomial hard problem(np-hard, np-hard问题)很难找到多项式时间算法的问题
        non-deterministic polynomial complete problem(npc，np完全问题)很难找到多项式时间算法的np问题, 包含np-hard
    np完全问题的某些特点    # 到处都是np完全问题, 有时与普通问题差别不大
        不能再细分成小问题，且必须考虑所有可能的情况
        涉及"所有组合"
        涉及序列且难解决    # 旅行商问题
        涉及集合且难解决    # 广播台集合
        可转换为集合覆盖问题或旅行商问题




## 旅行商问题
    # TSP, travelling salesman problem, 组合优化中的np困难问题
    介绍
        遍历n地点，找总路程最短的路径
        分别以n地点开始，找下个起点(n-1个), 时间复杂度为O(n!)。方向变路程不变时为n!/2
    近似求解