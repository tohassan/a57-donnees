FROM python:3.7
ARG USER="user01"
ENV SHELL "/bin/bash"
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"

RUN apt-get update && apt-get install -y neovim curl tmux tree jq locales

RUN useradd -ms /bin/bash ${USER}
RUN mkdir -p /home/${USER}/docker-compose-tr-sess && chown ${USER} /home/${USER}/docker-compose-tr-sess
ENV PYTHONPATH ${PYTHONPATH}:/home/${USER}/docker-compose-tr-sess
ENV PATH ${PATH}:/home/${USER}/.local/bin
USER ${USER}

RUN locale-gen en_US.UTF-8

RUN python -m pip install -U pip
RUN python -m pip install dvc[s3]

WORKDIR /home/${USER}/docker-compose-tr-sess
COPY requirements.txt .
RUN python -m pip install --user -r requirements.txt
