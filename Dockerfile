FROM alpine:3.4

ENV TERRAFORM_VERSION 0.6.16
ENV ARUKASFORM_VERSION 0.0.2
ENV GLIBC_VERSION 2.23-r1
ENV ROOT_PASS=""

RUN apk add --update openssh pwgen wget ca-certificates unzip git bash && \
    mkdir -p ~/.ssh && chmod 700 ~/.ssh/ && \
    echo -e "Port 22\n" >> /etc/ssh/sshd_config && \
    cp -a /etc/ssh /etc/ssh.cache && \
    wget -q "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
    apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk && \
    wget -q -O /terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip /terraform.zip -d /bin && \
    wget -q -O /terraform-provider-arukas.zip "https://github.com/yamamoto-febc/terraform-provider-arukas/releases/download/v${ARUKASFORM_VERSION}/terraform-provider-arukas_darwin-amd64.zip" && \
    unzip /terraform-provider-arukas.zip -d /bin && \
    apk del --purge wget ca-certificates unzip && \
    rm -rf /var/cache/apk/* glibc-2.21-r2.apk /terraform.zip /terraform-provider-arukas.zip

EXPOSE 22
 
COPY entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]
