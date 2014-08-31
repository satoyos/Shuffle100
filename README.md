Shuffle100 (百首読み上げ)
==========

[![Code Climate](https://codeclimate.com/github/satoyos/Shuffle100.png)](https://codeclimate.com/github/satoyos/Shuffle100)
[![Build Status](https://travis-ci.org/satoyos/Shuffle100.png?branch=master)](https://travis-ci.org/satoyos/Shuffle100)

実際の百人一首かるたを使って対戦や練習をするときに、人の代わりに百人一首の歌の読み手を務めるiPhoneアプリです。
RubyMotionで作っています。

![Image](http://postachio-images.s3-website-us-east-1.amazonaws.com/bdc9788b9b5c8ff218c37223f302b9a4/511242b6e6a9f3507107fc8f1c2af6e2/w600_df90791d0bf5c6022857a54b3700d61b.png)

ボーカロイド音声(※1)で、百人一首の歌をランダムに読み上げます。  
[こちらの動画](https://vimeo.com/88511077)で、実際に使っている様子をご覧いただけます。(競技かるた用の通常モードで遊ぶ場合の動画です)  
また、歌を上の句から読み上げ始める「初心者モード」も用意しています。([こちらの動画](https://vimeo.com/104796183)をご覧ください。)

[App Store](https://itunes.apple.com/jp/app/bai-shou-dumi-shangge/id857819404?mt=8)で公開中です。

■ 設定できること

* New! 【通常モード / 初心者モード】  
  上の句から読み始めるのか(初心者モード)、前の歌の下の句から読み始めるのか(通常モード)を選べます。

    - 通常モード(競技かるたモード)の流れ: (試合再開) → 下の句読み上げ → 次の歌の上の句読み上げ → (試合一次停止)
    - 初心者モード(散らし取りモード)の流れ: (試合再開) → 上の句読み上げ → 下の句読み上げ →  (試合一次停止)

* 【試合に使う歌の選択】  
  100首の中から、試合に使う歌をお好みで選べます。

* 【空札(からふだ)の有無】(通常モードのみ)  
  読み上げる札の中に、空札(取り札が無い「ハズレ」札)を入れるかどうかを設定できます。
  空札は、「試合に使う歌」と同数の札がランダムに選ばれます。

* 【歌と歌の間隔(秒数)】  
  下の句を読み終えてから、次の歌の上の句を読み上げるまでの間隔を調整できます。

* 【上の句と下の句の間隔(秒数)】(初心者モードのみ)  
  初心者モードで、上の句を読み終えてから下の句を読み始めるまでの間隔を調整できます。


This software is released under the MIT License, see LICENSE.txt.

- - -

(※1) ボーカロイドはヤマハ株式会社の登録商標です。
