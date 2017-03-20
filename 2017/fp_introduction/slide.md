autoscale: true
slidenumbers: true
# はじめる関数型プログラミング
## - Haskellではじめよう -
##### 株式会社VOYAGE GROUP
##### 泉雅彦 @mizmarine

---

# who are you?

![right](./images/face.jpg)

- 泉 雅彦@mizmarine
- 株式会社VOYAGE GROUP
  - そろそろ2年目終わります
  - Pythonで広告配信書いてます
- Like
  - :computer: Python / Haskell
  - :book: ミステリ
  - :runner: 脱出ゲーム

---

# agenda

1. 関数型プログラミングとは
1. Haskell入門
1. 再帰を用いた繰り返し
1. 高階関数を用いた集合演算

---

# 本日の参考資料

![inline 80%](./images/haskell.jpg)![inline 120%](./images/scala.jpg)

^ すごいHaskellたのしく学ぼう！
^ Scala関数型デザイン&プログラミング

---

# 関数型プログラミングとは

---

# 関数型プログラミングとは

- プログラミングパラダイムの１つ
  - パラダイム: 考え方.捉え方
  - ex.手続き型/オブジェクト指向/etc..
- 書き方が異なるだけ
  - できること自体は変わりません
  - 異なるパラダイムを学び，応用できるところは活かしていこう

---

# 関数型プログラミングとは

- 関数型プログラミング
  - 「純粋関数」をベースとしたプログラミングのこと
- 小さな「関数」をパーツとし，組み合わせて様々な処理を作る
  - linuxコマンドをイメージしてください
  - cat, grep, sort, ...

---

# 例: テキストファイルの操作

- 「#」から始まるデータを取得する

```
cat slide.md | grep -e '^#' | sort | head -n 3
# Features
# Haskellとは
# Haskell入門
```

- 手続き型で素直にかくと，listにしてloopまわして 1行ずつifで場合分けして...みたいな感じ

---

# 何が嬉しいの？

- 1つ１つのパーツ（関数）がコンパクトになる
  - テスト性，メンテナンス性が上がる
- 再利用性も高い
  - ex. grepした後にsedで変換しよう
- ではそもそも「関数」とはなにか？

---

# 関数

- 「値を渡したら」「何か返ってくる処理」のこと

```python
# addOneは 受け取った数に1を足して返す関数
In [1]: def addOne(x):
   ...:     return x + 1
   ...:

In [2]: addOne(1)
Out[2]: 2

In [3]: addOne(3)
Out[3]: 4
```

---

# 関数

```python
# 関数型プログラミングの世界において，返り値がないものは関数ではない
In [1]: def greeting(name):
   ...:     print 'hello,' + name
   ...:

In [2]: result = greeting('izumi')
hello,izumi

In [3]: print result
None
```

^処理をまとめたもの: procedure

---

# 副作用

- 関数呼び出し前後で「状態」を書き換えること
- ex
  - オブジェクトの状態更新
  - DBへの書き込み

---

# 例: オブジェクトの状態更新

```python
In [1]: class User(object):
  ...:     def __init__(self, name):
  ...:         self.name = name

In [2]: def rename(user, new_name):
  ...:     user.name = new_name

In [3]: u = User('izumi')

In [4]: u.name
Out[4]: 'izumi'

In [5]: rename(u, 'masahiko')

In [6]: u.name
Out[6]: 'masahiko'  # 状態が書き換わっている！
```

---

# 純粋関数

- 副作用がない関数のこと
  - 数学における関数と同じもの

$$
f(x) = x^2
$$

- 何が嬉しい？
  - 同じ引数なら，いつでも同じ値を返す（参照透過性）
  - 同じ式は置換可能なので，等価性推論が容易
  - 引数だけ考えれば良いので 状態意識したコード書かなくて良い


---

# ここまでのまとめ

- 関数型プログラミング
  - 純粋関数を組み合わせて処理を記述するスタイルのこと
- 純粋関数
  - 副作用のない関数
- 何が嬉しい？
  - メンテナンス性，再利用性が高い

---

# Haskell入門

---

![fit original](./images/haskell_logo.png)



---

# Haskellとは

> An advanced, purely functional programming language
-- https://www.haskell.org


- 純粋関数型言語として有名です
- 以降 Haskell を用い関数型プログラミングに触れていきます

---

# Features

- Statically typed
- **Purely** functional
- Type interface
- Concurrent
- Lazy
- Packages


---

# how to isntall

- macの場合

```
brew cask install haskell-platform
```

- 他は公式サイトで調べてどうぞ
  - https://www.haskell.org/downloads
- 公式サイト上オンラインでも試せます
  - ...が，関数定義面倒なので手元で動かすのがお勧めです

![right](./images/ghci_sample.png)


---

# 数値計算

```haskell
-- 演算子は優先度あり
Prelude> 3 + 5
8
Prelude> 50 * 100 - 4999
1
Prelude> 100 - 10 * 9
10

-- 負値は注意
Prelude> 5 * -3

interactive:4:1: error:
    Precedence parsing error
        cannot mix ‘*’ [infixl 7] and prefix `-' [infixl 6] in the same infix expression
Prelude> 5 * (-3)
-15
```

---

# 論理演算

```haskell
-- 論理演算
Prelude> True && True
True
Prelude> True && False
False
Prelude> True || False
True
Prelude> not True
False

-- 比較演算
Prelude> 1 == 1
True
Prelude> 1 /= 1 -- not equal
False
```

---

# リテラル

```haskell
-- 文字
Prelude> 'a'
'a'

-- 文字列
Prelude> "hoge"
"hoge"

-- リスト
Prelude> [1,2,3]
[1,2,3]

-- 文字列は文字リストのsyntax sugar
Prelude> "masa" == ['m', 'a', 's', 'a']
True
```

---

# 関数呼び出し: succ

```haskell
-- 関数名のあと空白おくと関数適用になる
-- succ: 1引数をうけて，「次に続くもの」を返す
Prelude> succ 1
2
-- succ(1) とは書かない！

-- 文字の場合はアルファベット順
Prelude> succ 'a'
'b'

-- 「次に続くもの」が明確でない場合，error
Prelude> succ "masa"

interactive:33:1: error:
    • No instance for (Enum [Char]) arising from a use of ‘succ’
    • In the expression: succ "masa"
      In an equation for ‘it’: it = succ "masa"
```

---

# 関数呼び出し: toUpper

```haskell
-- 外部モジュールのコードはimportして利用できる
Prelude> import Data.Char
Prelude Data.Char> toUpper 'a'
'A'
-- toUpper('a') とは書かない!
```


---

# 関数呼び出し: max

```haskell
-- max: 2引数を受け，大きい方を返す
Prelude> max 3 5
5
-- max(3,5) とは書かない！

Prelude> max 'a' 'b'
'b'

-- listの場合，先頭から比較していく
Prelude> max [1,2,3] [2,1]
[2,1]
Prelude> max "hoge" "huga"
"huga"
```

---

# 型の確認

```haskell
-- :type x もしくは :t x で xの型を調べられる
Prelude> :type 'a'
'a' :: Char
Prelude> :t "masa"
"masa" :: [Char]

-- 関数の型をみることもできる
Prelude> import Data.Char
Prelude Data.Char> :t toUpper
toUpper :: Char -> Char  -- Char型を受けてChar型を返す関数
```

---

# 関数定義

```haskell
-- sample.hsとして定義
doubleMe :: Int -> Int
doubleMe x = x * 2
```

```haskell
-- ghciから読み込み
Prelude> :l sample.hs
[1 of 1] Compiling Main             ( sample.hs, interpreted )
Ok, modules loaded: Main.
*Main> doubleMe 3
6
```

---

# 関数定義の便利構文

- 場合分け
  - パターンマッチ
  - ガード
- 型クラス

---

# パターンマッチ

- マッチしたケースにあわせて処理を行う
  - イメージはこれ

$$
f(x) = \left\{
\begin{array}{ll}
100 & (x = 1) \\
50 & (x = 0) \\
0 & (otherwise)
\end{array}
\right.
$$

---

# パターンマッチ

```haskell
weekday :: Int -> String
weekday 0 = "Sunday"
weekday 1 = "Monday"
weekday 2 = "Tuesday"
weekday 3 = "Wednesday"
weekday 4 = "Thursday"
weekday 5 = "Friday"
weekday 6 = "Saturday"
weekday otherwise = "unknown"
```

---

# パターンマッチ

```haskell
Prelude> :l sample.hs
[1 of 1] Compiling Main             ( sample.hs, interpreted )
Ok, modules loaded: Main.
*Main> weekday 0
"Sunday"
*Main> weekday 4
"Thursday"
*Main> weekday 7
"unknown"
```

---

# ガード

- マッチした引数の条件分けができる
  - イメージはこれ

$$
g(x) = \left\{
\begin{array}{ll}
2x & (x \geq 1) \\
x & (1 \gt x \geq 0) \\
0 & (otherwise)
\end{array}
\right.
$$

---

# ガード
```haskell
scoreCheck :: Int -> String
scoreCheck x
  | x == 100 = "Excellent!!"
  | x > 90 = "very good!"
  | x > 80 = "good."
  | x > 70 = "so so."
  | otherwise = "do your best ><"
```

---

# ガード

```haskell
Prelude> :l sample.hs
[1 of 1] Compiling Main             ( sample.hs, interpreted )
Ok, modules loaded: Main.
*Main> scoreCheck 100
"Excellent!!"
*Main> scoreCheck 85
"good."
*Main> scoreCheck 59
"do your best ><"
```

---

# 型クラス

- 同じような処理の関数も，型が違ったら適用できない

```haskell
equalInt :: Int -> Int -> Bool
equalInt x y = x == y

*Main> equalInt 1 1
True

*Main> equalInt 'a' 'b'
interactive:4:10: error:
    • Couldn't match expected type ‘Int’ with actual type ‘Char’
    • In the first argument of ‘equalInt’, namely ‘'a'’
      In the expression: equalInt 'a' 'b'
      In an equation for ‘it’: it = equalInt 'a' 'b'
```

---

# 型クラス

- 具体的な型(Int, Char,..)が どのような性質をもつか，を示すもの
  - 同値比較ができるか，順序比較ができるか..など
  - java や golang における interface に近い
- ex. Eq型クラス
  - `==` 演算子で比較演算ができるか
  - Int, Charは `1 == 1`, `'a' == 'b'` という比較演算ができる
  - Int, Char は Eq型クラスに属する，という

---

# 型クラス

- equalIntを Eq型クラスに対する関数として定義

```haskell
equalEq :: (Eq a) => a -> a -> Bool
equalEq x y = x == y

*Main> equalEq 1 1
True
*Main> equalEq 'a' 'b'
False
```

---

# その他型クラスの例

- Ord型クラス
  - 順序比較計算( `>` )ができるもの
- Enum型クラス
  - 値を列挙できるもの
- Num型クラス
  - 数値演算( `+`, `*`, etc..)ができるもの

---

# ここまでのまとめ

- 基本構文
  - 数値, 真偽値, 文字列, リスト
  - 関数定義
- 便利構文
  - パターンマッチ
  - ガード
- 型クラス

---

# 再帰を用いた繰り返し

---

# 再帰を用いた繰り返し

- Haskellにはfor文やwhile文は存在しません
- 繰り返しを利用する場合，再帰定義を使います
  - 高校でやった「数列」を思い出してください
  - ex: フィボナッチ数

$$
a_n = \left\{
\begin{array}{ll}
a_{n-1} + a_{n-2} & (n > 2) \\
a_2 & (n = 2) \\
a_1 & (n = 1)
\end{array}
\right.
$$

---

# 例1：リストの合計を求めてみよう

- 配列 a<sub>n</sub>の合計 S<sub>n</sub> を求めてみよう

$$
S_n = a_1 + a_2 + ... + a_n
$$

$$
S_n = \left\{
\begin{array}{ll}
S_{n-1} + a_n  & (n > 0) \\
0 & (n = 0)
\end{array}
\right.
$$

---

# 例1：リストの合計を求めてみよう

- Pythonで 手続き型っぽく書いてみます

```python
def mysum(xs):
  v = 0
  for i in xs:
    v += i
  return v

if __name__ == '__main__':
  print mysum([1, 2, 3, 4, 5])  # 15
```

---

# 例1：リストの合計を求めてみよう

- Haskellで再帰的に書いてみます
  - ポイントは基底部と再帰部を見極めること

```haskell
mysum :: [Int] -> Int
mysum [] = 0
mysum (x:xs) = x + mysum xs

main = do
    print $ mysum [1,2,3,4,5]  -- 15

```

---

# 例2：フィボナッチ数を求めよう

- 定義再掲

$$
a_n = \left\{
\begin{array}{ll}
a_{n-1} + a_{n-2} & (n > 2) \\
a_2 & (n = 2) \\
a_1 & (n = 1)
\end{array}
\right.
$$

---

# 例2：フィボナッチ数を求めよう

- Pythonで 手続き型っぽく書いてみます

```python
def fib(x):
    a_1, a_2 = 1, 1

    if x == 1:
        return a_1
    if x == 2:
        return a_2

    v = 0
    i = 2
    while i < x:
        i += 1
        v = a_1 + a_2
        a_1 = a_2
        a_2 = v
    return v
```

---

# 例2：フィボナッチ数を求めよう

- Haskellで再帰的に書いてみます

```haskell
fib :: Int -> Int
fib 1 = 1
fib 2 = 1
fib x = fib (x-1) + fib (x-2)
```

```haskell
*Main> fib 1
1
*Main> fib 2
1
*Main> fib 3
2
*Main> fib 4
3
*Main> fib 5
5
*Main> fib 6
8
```

---

# 再帰にを用いた繰り返し

- 手続き型の繰り返しで書く場合
  - ループごとの状態を意識する必要がある
- 再帰的な繰り返しで書く場合
  - 数学定義そのままで書けることが多い
  - 基底部と再帰部を記述するだけ

---

# 高階関数を用いた集合演算

---

# 高階関数

- 関数自体を値として利用する関数のこと
  - 関数型プログラミングの最初の一歩！
- 関数型プログラマの武器
  - map
  - filter
  - fold

---

# 「関数を引数に取る」とは？

- こんな関数を考えてみよう
  - ある処理を引数に対し2回適用する
- f(x) と x を引数として取り x に f(x)を2回適用した値を返す
  - `twice` と名付ける

---

# twice

```haskell
-- 「受け取った関数」をxに2回適用する関数
twice :: (Int -> Int) -> Int -> Int
twice f x = f (f x)

*Main> twice succ 1
3
-- succ を 1に 2回適用する
-- succ (succ 1) と同じ
```

---

# twice

- succ 以外にも `Int -> Int` な関数ならなんでも渡せる

```haskell
addThree :: Int -> Int
addThree x = x + 3

*Main> twice addThree 5
11

mulTwo :: Int -> Int
mulTwo x = x * 2

*Main> twice mulTwo 3
12
```

---

# twice

- 共通パターン（2回繰り返す）に対し，具体的なロジックを切り替えるだけで 様々な処理が作れる
- ロジックを切り替えられる，というのが高階関数のメリット
  - ロジックの抽象化
  - オブジェクト指向でいう strategy パターン

---

# 無名関数(ラムダ式)

- その場でしか利用しない関数を定義できる
  - 高階関数の引数として渡すことが多い
  - 明示的に関数定義せずにロジックを表現できるのがメリット

```haskell
*Main> a = \x -> x + 2
*Main> a 1
3
```

---

# twice * 無名関数


- 無名関数を利用すると，高階関数がより便利になります

```haskell
*Main> twice (\x -> x + 1) 1
3
*Main> twice (\x -> x * 3) 4
36
```

---

# 部分適用とカリー化

- 部分適用
  - 複数引数の関数において，一部引数だけ適用した状態の関数
  - Haskellの関数はすべて部分適用が可能
- カリー化
  - 複数引数の関数において，部分適用できるようにすること
  - Haskellの関数はすべてカリー化されている

---

# 例: 部分適用

```haskell
*Main> :t (+ 1)  -- 引数に1を足す関数. addOne
(+ 1) :: Num a => a -> a
*Main> (+ 1) 3
4

*Main> :t (* 3)  -- 引数を3倍する関数. mulThree
(* 3) :: Num a => a -> a
*Main> (* 3) 2
6
```

---

# twice * カリー化関数

- こちらも非常に高階関数と相性が良い

```haskell
*Main> twice (+1) 1
3
*Main> twice (*3) 4
36
```

---

# 集合と高階関数

- xに対する処理 f(x)
- xの集合に対してf(x)を一括で適用したい
- 「一括で適用とする」というパターンにf(x)を渡す
- 高階関数として表現できる！

---

# map

- 集合の各要素に対し，f(x)による変換処理を行う高階関数
  - [source](http://hackage.haskell.org/package/base-4.9.1.0/docs/Prelude.html#v:map)

```haskell
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs
```

---

# 例: map

```haskell
*Main> a = [1,2,3,4,5]

*Main> map succ a
[2,3,4,5,6]
*Main> map (\x -> x + 3) a
[4,5,6,7,8]
*Main> map (*2) a
[2,4,6,8,10]
```

---

# filter

- 集合に対し，f(x)がTrueになる要素のみにする高階関数
  - [source](http://hackage.haskell.org/package/base-4.9.1.0/docs/Prelude.html#v:filter)

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter _pred []    = []
filter pred (x:xs)
  | pred x         = x : filter pred xs
  | otherwise      = filter pred xs
```

---

# 例: filter

```haskell
*Main> a = [1,2,3,4,5]

*Main> filter even a  -- even: 引数が偶数の時 Trueを返す関数
[2,4]
*Main> filter (\x -> mod x 2 == 1) a  -- mod: 余りを返す関数
[1,3,5]
Main> filter (> 3) a
[4,5]
```

---

# fold

- リストの「畳み込み」を行う
  - 2引数関数fと初期値（アキュムレータ）acc，走査するリストxsを受取る
  - f を acc とリストの最初の要素に適用し，新しいアキュムレータacc'とする
  - f を acc' とリストの次の要素に適用し，新しいアキュムレータacc''とする
  - コレを繰り返し，リストすべて舐めたときのアキュムレータを返す
- リストを左から読む場合「左畳み込み」，逆の場合「右畳み込み」という

---

# 畳み込みのイメージ

- 関数: (+), 初期値: 0, リスト: [1, 2, 3, 4]
  - 0 + 1 = 1  # [1, 2, 3, 4]
  - 1 + 2 = 3  # [2, 3, 4]
  - 3 + 3 = 6  # [3, 4]
  - 6 + 4 = 10 # [4]
- result: 10

---

# foldl

```
Prelude> :t foldl
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
```

- Foldable は 「畳み込み対応可能」という型クラス
- listの場合は以下と同義

```
foldl :: (b -> a -> b) -> b -> [a] -> b
```

---

# 例: foldl

```haskell
Prelude> foldl (+) 0 [1,2,3,4]
10

Prelude> foldl (*) 1 [1,2,3,4]
24
```

---

# 例: foldr

```haskell
Prelude> :t foldr
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b

Prelude> foldr (:) [] [1,2,3,4]  -- (:) cons関数.リストを作成する
[1,2,3,4]
```

---

# foldingの例

```haskell
-- listを走査する系の処理は foldingで記述できる
Prelude> sum = foldl (+) 0
Prelude> sum [1,2,3,4]
10

Prelude> reverse = foldl (flip (:)) []
Prelude> reverse [1,2,3,4]
[4,3,2,1]

-- challenge: map / filter を foldingで書いてみよう
-- hint: foldrをつかおう
```
---

# 高階関数のための便利機能

- 関数合成
  - 既存の関数を組み合わせて，新しい関数を作成できます
  - こんなイメージ

$$
h(x) = g(f(x))
$$

---

# 例: 関数合成


```haskell
-- f(x)
addOne :: Int -> Int
addOne x = x + 1

-- g(x)
doubleMe :: Int -> Int
doubleMe x = x * 2

-- h(x) = g(f(x))
addOneThenDouble :: Int -> Int
addOneThenDouble x = doubleMe (addOne x)

*Main> addOneThenDouble 4
10
*Main> 2 * (1 + 4)
10
```

---

# 関数合成


```haskell
-- 関数合成演算子を使うと よりシンプルに書けます
-- ポイントフリースタイルという
addOneThenDouble' :: Int -> Int
addOneThenDouble' = doubleMe . addOne

-- 部分適用との相性も抜群
addOneThenDouble'' :: Int -> Int
addOneThenDouble'' = (*2) . (+1)
```

---

# 関数型プログラミングのパターン

- 部分適用した関数を
- ドット演算子で関数合成して
- 高階関数に渡す

というのがよくあるパターンです

---

# 例: 冒頭のfilter処理

```
cat slide.md | grep -e '^#' | sort | head -n 3
```

- 関数合成つかって書いてみましょう

---

# 例: 冒頭のfilter処理

```haskell
Prelude Data.List> text = ["# title1", "text1", "text2", "## subtitle1", "text3", "# title2", "text4" ]

Prelude Data.List> startWithSharp = (==) '#' . head
Prelude Data.List> take 3 . sort . filter startWithSharp $ text
["# title1","# title2","## subtitle1"]
```

---

# ここまでのまとめ

- 高階関数
  - 関数を値として扱う関数のこと
  - 共通パターンをくくり出し，処理の抽象化を行える
- 集合に対する演算として高階関数が便利
  - map
  - filter
  - fold

---

# まとめ

---

# まとめ

- Haskellを題材に関数型プログラミングの考え方を紹介しました
  - 純粋関数を最小パーツとする
  - 小さなパーツを組み合わせて大きな処理を作る
  - 集合に対する演算を意識する
- 手続き型/オブジェクト指向でも活かせると思うので，美味しいところを味わっていきましょう

---

# さらなる学びのために...

- 型コンストラクタ
  - List, Maybe, IO, etc..
- 代数データ型
  - data構文
- 型クラス
  - Functor, Monoid, Monad, etc..

---

# :tada: Happy Functional Life :tada:

