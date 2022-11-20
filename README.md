# dl_remote

## Usage

ref: [nerfstudio](https://github.com/nerfstudio-project/nerfstudio#1-installation-setup-the-environment)

setup turn server on your machine: https://zenn.dev/srgr0/articles/build_coturn_server

### 1. Setup WSL2
```
1.NVIDIAドライバーのインストール
検索して入れてください。
nvidia experienceは任意です。


2. WSL2-Ubuntuのセットアップ
# wsl2/ubuntu
sudo -i
apt update
apt upgrade -y
## systemctlの有効化
nano /etc/wsl.conf
##### add
[boot]
systemd=true
#####

# ホスト
wsl --shutdown
wsl

# wsl2/ubuntu
## systemctlの確認
systemctl
## ロケール関係の設定
apt -y install language-pack-ja
update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
sed -i 's/#NTP=/NTP=ntp.nict.jp/g' /etc/systemd/timesyncd.conf


3. Dockerのインストール
apt install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
docker version
```

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
