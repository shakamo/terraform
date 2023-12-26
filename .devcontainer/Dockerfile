FROM python:3.12.1

# install command
RUN apt-get update && apt-get install -y vim wget unzip vim sudo

# aws cli v2 のインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
## RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install

# install terraform
RUN wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
RUN unzip ./terraform_1.6.6_linux_amd64.zip -d /usr/local/bin/

# install terraform-docs
RUN curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz
RUN tar -xzf terraform-docs.tar.gz
RUN mv terraform-docs /usr/local/bin/terraform-docs

# install checkov
RUN pip install --upgrade pip && pip install --upgrade setuptools
RUN pip install checkov

# install tflint
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
