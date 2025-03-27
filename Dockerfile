# ベースとして使用するイメージ名
FROM ruby:3.3.6-alpine

# 利用可能なパッケージのリストを更新するコマンドを実行
RUN apk update

# パッケージをインストールするコマンドを実行
RUN apk add g++ make mysql-dev tzdata vips

# コンテナを起動した時の作業ディレクトリを/appにする
WORKDIR /app

# ビルドコンテキスト上のGemfileを/appにコピー
COPY Gemfile .
COPY Gemfile.lock .

# bundle installでGemfileに記述されているgemをインストール
RUN bundle install
