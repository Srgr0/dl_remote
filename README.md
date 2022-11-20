# dl_remote

## Usage

ref: [nerfstudio](https://github.com/nerfstudio-project/nerfstudio#1-installation-setup-the-environment)

setup turn server on your machine: https://zenn.dev/srgr0/articles/build_coturn_server

useful tool:https://sslnow.ml/

```
$ ssh xxx@xxx -p xxx -L 18888:localhost:18888 -L 15900:localhost:15900 -L 16006:localhost:16006
$ docker pull naruya/dl_remote:torch-11.3
$ docker run --gpus all -it -p 0.0.0.0:18888:8888 -p 0.0.0.0:15900:5900 -p 0.0.0.0:16006:6006 \
      -v ~/workspace:/root/workspace --name name_nerfstudio naruya/dl_remote:torch-11.3
% source ~/venv/torch/bin/activate
% pip install -U pip
% pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch  # 時間かかる
% git clone https://github.com/nerfstudio-project/nerfstudio.git
% cd nerfstudio
% nano nerfstudio/viewer/app/src/modules/WebRtcWindow/WebRtcWindow.jsx
if nano is not installed: apt update && apt install nano
edit turn server addresses.
% pip install --upgrade pip setuptools
% pip install -e .
% cd ../

% ns-download-data --dataset=nerfstudio --capture=poster
% ns-train nerfacto --vis viewer --viewer.websocket-port 16006 --data data/nerfstudio/poster
# https://viewer.nerf.studio/versions/22-10-13-0/?websocket_url=ws://localhost:16006
```

```
% vnc  # start x11vnc
% jl  # jupyter lab
% tb  # tensorboard
```

## Test

### Pytorch
- `python -c "import torch; print(torch.cuda.is_available())"`

### x11vnc
```
% vnc  # start x11vnc

% apt install x11-apps mesa-utils
% xeyes  # cpu rendering
% glxgears  # gpu rendering
```
