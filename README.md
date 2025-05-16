### Prodしか利用していない


### Git Clone

```
git clone https://github.com/shakamo/terraform.git
```

### VS Code Dev Container とは

- https://code.visualstudio.com/docs/devcontainers/containers
- https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

### AWS Profile 設定

```
aws s3 ls --profile default
```

or

```
export AWS_PROFILE="default"
```

### Terraform 初期化

- main.tf がある場所で以下のコマンドを実行

```
terraform init
```

### Terraform plan & apply

```
terraform plan
terraform apply
```

### Terraform フォーマッタ＆バリデータ

```
terraform fmt
terraform validate
```

### Terraform-docs 実行 ¥

```
terraform-docs markdown modules/s3 --output-file doc.md
```

### Terraform 静的分析ツール

```
checkov --directory ./
```

### Terraform Lint

```
tflint --recursive --fix
```

### 基本

- https://tama-shira.github.io/note/terraform/terraform-01-basic/
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

### 構成

- https://cloud.google.com/docs/terraform/best-practices-for-terraform?hl=ja
- https://dev.classmethod.jp/articles/terraform-bset-practice-jp/
- https://zenn.dev/himekoh/articles/202208191916
- https://zoo200.net/terraform-tutorial-module-and-directory/
- https://blog.pepese.com/terraform-modules-env/
- https://blog.gruntwork.io/how-to-manage-multiple-environments-with-terraform-32c7bc5d692

### Terraform Import

- https://qiita.com/masato930/items/f5707be8077dba995978
