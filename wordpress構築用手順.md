# wordpress構築用手順
## common_network作成
以下のコマンドを実行し、network関係のインフラを作成する。
```
cd aws-infrastructure
make remote-enable ENV=dev TARGET=common_network
make create-env ENV=dev TARGET=common_network
make plan ENV=dev TARGET=common_network
make apply ENV=dev TARGET=common_network
```

## amiの作成
以下のリポジトリからwordpress用のamiを作成する
https://github.com/kubotama358/aws-ami-create

## domainの取得
```
route53であらかじめ、自分のサイトに使用するドメインを取得する。  
https://console.aws.amazon.com/route53/home#DomainListing:  
※ムームードメインやお名前.comで取らずに必ずroute53上でドメインを取得すること。
```

## 変数の変更
以下のファイルのドメイン部分を上で取得した自分のドメイン名に変更する
```$xslt
・terraform/wordpress_server/acm.tf
・terraform/wordpress_server/route53.tf
```

## wordpress_server用のkey_pair作成
以下のコマンドを実行
```$xslt
./create_wordpress_server_keypair.sh dev ap-northeast-1
※権限が足りないようなら 'chmod 600 create_wordpress_server_keypair.sh'を実行
```

## wordpress_serverの構築
以下のコマンドを実行し、wordpress_server関係のインフラを作成する。  
※applyは失敗するが、後でもう一度実行する
```
make remote-enable ENV=dev TARGET=wordpress_server
make create-env ENV=dev TARGET=wordpress_server
make plan ENV=dev TARGET=wordpress_server
make apply ENV=dev TARGET=wordpress_server
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

### SSL証明書のDNS承認
以下の画面を開いて、"route53でのレコード作成"ボタンを押下する。  
https://ap-northeast-1.console.aws.amazon.com/acm/home?region=ap-northeast-1#/  
※数分経てば、無事証明書の状況が"検証中"→"発行済み"に変わる。  
変わったらalbの作成ができるようになる。

### 動作確認
https://${domain_name}にアクセスできるか確認

アクセスできたなら以下のurlからwordpressの初期設定へと進む  
https://${domain_name}/wordpress/wp-admin/setup-config.php