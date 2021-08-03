# wordpress_lightsail構築用手順
## common_network作成
以下のコマンドを実行し、route53のホストゾーンを作成する
```
cd aws-infrastructure
make remote-enable ENV=dev TARGET=common_network
make create-env ENV=dev TARGET=common_network
make plan ENV=dev TARGET=common_network
make apply ENV=dev TARGET=common_network
```

## domainの取得
```
route53であらかじめ、自分のサイトに使用するドメインを取得する。  
https://console.aws.amazon.com/route53/home#DomainListing:  
※ムームードメインやお名前.comで取らずに必ずroute53上でドメインを取得すること。
```

## 変数の変更
以下のファイルのドメイン部分を上で取得した自分のドメイン名に変更する
```$xslt
・terraform/wordpress_server_lightsail/route53.tf
```

## lightsailの構築
以下のコマンドを実行し、lightsail関係のインフラを作成する。  
※applyは失敗するが、後でもう一度実行する
```
make remote-enable ENV=dev TARGET=wordpress_server_lightsail
make create-env ENV=dev TARGET=wordpress_server_lightsail
make plan ENV=dev TARGET=wordpress_server_lightsail
make apply ENV=dev TARGET=wordpress_server_lightsail
```

## 上で取得したドメインのネームサーバ変更
以下のroute53のコンソール画面より、3.で作成されたホストソーンを選択する。  
https://console.aws.amazon.com/route53/home#hosted-zones:  

タイプ"NS"のところをみると以下のような値が設定されていると思う。これをメモ
```
ns-xxx.awsdns-xx.org.
ns-xxx.awsdns-xx.net.
ns-xxx.awsdns-xx.com.
ns-xxx.awsdns-xx.co.uk.
```
次に以下の画面で対象のドメインを選択する。  
https://console.aws.amazon.com/route53/home#DomainListing:

ドメインの詳細画面に遷移したら、ネームサーバーの追加/編集というリンクがあるので、それを押下。  
そこでメモしておいた、上の値を入れる。

## 動作確認
http://${domain_name}にアクセスできるか確認する  
※ssl化が済んでないのでhttpでしたアクセスできない

## httpsリダイレクト, ssl化実施
### ssh接続
以下のlightsailのコンソール画面から作成したインスタンスを選択
```$xslt
https://lightsail.aws.amazon.com/ls/webapp/home/instances
```

### bitnami https設定ツールを実行
インスタンスへssl接続できたらbitnami https設定ツールを実行する
```$xslt
sudo /opt/bitnami/bncert-tool
```

### mysqlのpassword確認
```$xslt
cat ~/bitnami_application_password
```

### wordpressの管理画面のユーザ名とパスワード確認
```
cat ./bitnami_credentials
```
