FROM nvidia/cuda:11.3.1-devel-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive


# zsh
RUN apt-get update && apt-get install -y wget git zsh
SHELL ["/bin/zsh", "-c"]
RUN wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
RUN sed -i "s/# zstyle ':omz:update' mode disabled/zstyle ':omz:update' mode disabled/g" ~/.zshrc

# python
RUN apt-get update && apt-get install -y python3.9 python3.9-dev python3.9-venv python3-pip
RUN ln -s /usr/bin/python3.9 /usr/bin/python

# vnc
RUN apt-get update && apt-get install -y xvfb x11vnc icewm
RUN echo 'alias vnc="export DISPLAY=:0; Xvfb :0 -screen 0 1400x900x24 &; x11vnc -display :0 -forever -noxdamage > /dev/null 2>&1 &; icewm-session &"' >> /root/.zshrc

# torch
RUN python -m venv /root/venv/torch
RUN source ~/venv/torch/bin/activate && \
    pip install -U pip && \
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

# utils
RUN apt-get update && apt-get install -y vim ffmpeg
RUN source ~/venv/torch/bin/activate && \
    pip install jupyterlab tensorboard ipywidgets && \
    echo 'alias jl="jupyter lab --ip 0.0.0.0 --port 8888 --NotebookApp.token='' --allow-root &"' >> /root/.zshrc && \
    echo 'alias tb="tensorboard --host 0.0.0.0 --port 6006 --logdir runs &"' >> /root/.zshrc

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["zsh"]
