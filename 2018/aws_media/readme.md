autoscale: true
slidenumbers: true
theme: Plain Jane, 3

## AWS Media Services でつくる
## ライブ動画配信システム
#### @mizmarine

---

# who are you?

![right](./images/face.jpg)

- 泉 雅彦(@mizmarine)
- 株式会社VOYAGE GROUP 2015入社
  - 広告業界４年目
  - Scala / Golang で 配信サーバ書いてる
- Like
  - :computer: Python / Scala
  - :runner: 脱出ゲーム

---

# agenda

1. Introduction
1. 動画配信技術の基礎
1. AWS Media Services とは
1. AWS Media Services で作る動画配信システム

---

# Introduction

### このトークの目的

---

# 動画配信サービスの隆盛

- 動画投稿/生配信
  - YouTube, ニコニコ動画, ..
- ビデオオンデマンド
  - Netfrix, Hulu, Amazon PrimeVideo, AbemaTV, ..
- 個人配信
  - instagram ストーリー, facebook live, ...
- ライブコマース
  - メルカリチャンネル、SHOPROOM, ..

---

# 技術的に難しそう...

- 大量の専門用語
  - Live / VOD, HLS / MPEG2-DASH, RTP / RTMP, ...
- WEB API サーバとは異なる技術領域
  - とりあえずjson返そう、とは別のパラダイム
- ライブ配信
  - 情報のリアルタイム性、インフラ構築

---

# AWS Media Services 発表

- 動画関連の新しい５つのサービス
- フルマネージドな配信基盤サービスも

---

# 触ってみた

- ちょっとした動画配信は **１時間もあれば作れた**
- とはいえ概念として難しいところはある
- 触ってみた経験を元に 各サービス概要 & ハマりどころを紹介
- AWS Media Services に興味を持つ人が増えると幸い

---

# 動画配信技術の基礎

---

AWS Media Services の雰囲気を知るるため最低限必要なワードについて１問１答

- Live / VOD
- HTTP Live Streaming
- Adaptive BitRate

---

# Live / VOD

動画コンテンツが「リアルタイムに」作られているものか、「過去」作られたものか、の配信形式の違い

- リアルタイムのものを Live配信
- 過去のもの（アーカイブ）を Video On Demand(VOD)配信

と呼ぶ

Live配信は入力されるストリームを常に変換しながら配信する必要がある
一方VOD配信はコンテンツが事前にわかっているが、コンテンツの持ち方を工夫しないとストレージがすぐにいっぱいに

---

# HTTP Live Streaming

通称HLS

https://dev.classmethod.jp/tool/http-live-streaming/

---

# Adaptive BitRate

通称:ABR

再生環境に合せて配信する動画のビットレートを動的に変えること
HLSはABR可能

それぞれの状況に合わせた動画コンテンツを事前に用意しておく
もしくは都度適した形式に変換する


---

# AWS Media Services?

---

![](./images/mediaservices.jpg)

---

# 5つのサービス

- AWS Elemental MediaConvert
- AWS Elemental MediaLive
- AWS Elemental MediaPackage
- AWS Elemental MediaStore
- AWS Elemental MediaTailor

---

![fit](./images/icons/MediaConvert_icon.png)

# AWS Elemental MediaConvert

オンデマンドコンテンツ作成のための動画ファイル変換サービス

- 視聴環境に合わせた様々な動画コンテンツを用意できる
  - ABR対応のための複数bitrate
  - 配信デバイスに合わせた配信形式(HLS, MPEG-DASH, ..)
  - デジタル著作権管理 (DRM)処理やキャプション追加なども
- 変換してS3に出力するだけ

---

![fit](./images/workflows/mediaconvert.png)

---

![fit](./images/icons/MediaLive_icon.png)

# AWS Elemental MediaLive

ライブ動画ストリーミングのリアルタイムエンコードサービス

- MediaConvertのライブ動画版
  - こちらも多様な形式で変換できる
- 出力先はS3だけでなくストリームとして扱う事ができる
  - S3に置く場合 MediaConvert同様VOD向けコンテンツ作成になる
  - ストリームをMediaPackageなどに渡すことで ライブ配信が可能
- AWS Media Services でライブ動画を扱う場合の「入り口」

---

![fit](./images/workflows/medialive.png)

---

![fit](./images/icons/MediaPackage_icon.png)

# AWS Elemental MediaPackage

様々な配信デバイスにむけた動画コンテンツパッケージングサービス

- 単一ビデオ入力から配信面にあわせたストリームを提供
  - 配信形式ごとにendpointを作成
- 最大72時間のタイムシフト再生も可能
- 負荷に合わせて自動でスケール
- AWS Media Services でライブ動画を扱う場合の「出口」

---

![fit](./images/workflows/mediapackage.png)

---

![fit](./images/icons/MediaStore_icon.png)

# AWS Elemental MediaStore

メディア向けに最適化された AWSストレージサービス

- 低レイテンシーの読み取りと書き込みを可能とするストレージ
  - 「動画特化S3」
- ライブ動画のアーカイブとして利用できる
- AWS Media Services でライブ動画を扱う場合の「出口」

---

![fit](./images/icons/MediaTailor_icon.png)

# AWS Elemental MediaTailor

ビデオストリームにターゲティング広告を配信できるサービス

- ServerSide Ad Insertion(SSAI) 対応
  - メインコンテンツと同じ配信系で広告挿入できる
    - bitrate変動やデバイスの影響うけにくい
    - アドブロック影響うけにくい
- メディアとしてはより収益化しやすくなる

---

![fit](./images/workflows/mediatailor.png)


---

# AWS Media Services でつくる動画配信サービス

---

- イメージ２通り
  - MediaLive * MediaPackage
  - MediaLive * MediaStore
  - 同時もできる

- 柔軟配信系
  - MediaLive * MediaPackage
    - MediaLiveの設定が鬼
    - outputgroups 数課金
    - channel ON の間課金
    - channel runningまで時間かかる -> hot standbyがよい
    - medialive のchannel上限
    - inputの設定で課金額変わる
- 動画アーカイブ配信系
  - MediaLive * MediaStore
    - outputgroups HLS設定
