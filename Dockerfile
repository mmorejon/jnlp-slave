FROM jenkins/jnlp-slave:3.29-1

ENV DOCKER_VERSION=18.06.3-ce
ENV DOCKER_COMPOSE_VERSION=1.24.0
ENV KUBECTL_VERSION=v1.14.2
ENV HELM_VERSION=v2.14.1

USER root
RUN \
		# docker
		curl -fsSLO "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" \
		&& tar --strip-components=1 -xvzf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin \
		&& chmod -R +x /usr/local/bin/docker \
		# docker compose
		&& curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
		# kubectl
		&& curl -L "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
		# helm
		&& curl -fsSLO "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" \
		&& tar --strip-components=1 -xvzf helm-${HELM_VERSION}-linux-amd64.tar.gz \
		&& mv helm /usr/local/bin \
		&& chmod -R +x /usr/local/bin/helm

RUN groupadd -for -g 999 docker \
		&& usermod -aG docker jenkins
USER jenkins