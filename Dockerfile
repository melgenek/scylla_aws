FROM hashicorp/terraform:0.14.6

RUN wget https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x ./aws-iam-authenticator && \
    mv aws-iam-authenticator /usr/bin/aws-iam-authenticator
