echo Starting Installation...........
sudo apt update -y
sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
#Nvidia
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo dpkg -i cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-get update
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt-get update
sudo apt-get install --no-install-recommends \
    cuda-10-1 \
    libcudnn7=7.6.4.38-1+cuda10.1  \
    libcudnn7-dev=7.6.4.38-1+cuda10.1
sudo apt-get install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 \
    libnvinfer-dev=6.0.1-1+cuda10.1 \
    libnvinfer-plugin6=6.0.1-1+cuda10.1
#Python
sudo apt install python -y
sudo apt install python3-pip -y
pip3 install notebook scikit-learn matplotlib pandas numpy jupyterlab seaborn
sudo apt install jupyter-core -y
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python get-pip.py
sudo apt-get install python-dev -y 
pip install notebook
pip install scikit-learn matplotlib pandas numpy seaborn
pip install nltk==3.0
sudo apt install python-gtk -y
sudo apt install libnss3-dev -y
sudo apt install -y libgdk-pixbuf2.0-0
sudo apt install -y libgtk-3-0
sudo apt install -y libxss1
curl https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -o Anaconda-latest-Linux-x86_64.sh
bash Anaconda-latest-Linux-x86_64.sh
conda install mkl
conda install pytorch torchvision cudatoolkit=10.1 -c pytorch
# NODEJS
sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install nodejs -y
sudo apt install npm -y
sudo npm install -g typescript
sudo npm install -g react-native-cli
sudo npm install -g expo-cli
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
#Docker
curl -fsSL https://get.docker.com -o get-docker.sh
bash get-docker.sh
#Utils
sudo apt install -y x11-apps
sudo apt install -y  golang-go
go get -u github.com/justjanne/powerline-go
cat >> ~/.bashrc << "EOF"
GOPATH=$HOME/go
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? -hostname-only-if-ssh)"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
EOF
source ~/.bashrc
sudo apt install -y httpie
sudo add-apt-repository ppa:linuxuprising/apps
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt update
sudo apt install tlpui
sudo apt-get install grub-customizer
#Aliases
touch ~/.bash_aliases
cat >> ~/.bash_aliases << "EOF"
# Aliases
alias jupyter-notebook="~/miniconda3/bin/jupyter-notebook --no-browser"
alias explorer="explorer.exe ."
alias portall="sudo lsof -i -P -n"
alias portl="sudo lsof -i -P -n | grep LISTEN"
alias cprun="g++ -Wall  -fsanitize=address -fsanitize=undefined  main.cpp -o main && ./main"
alias clksync="sudo ntpdate time.windows.com"
alias memfree="echo 1 | sudo tee /proc/sys/vm/drop_caches"
alias getip="ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
alias jupyter-cpp="docker run -p 5000:8888 -v /mnt/c/Users/shiva/OneDrive/Documents/ESO207A/:/home/jovyan/eso207/ b0hr/cling-notebook"
alias jupyter-go="docker run -it -p 5001:8888 gopherdata/gophernotes"
# Functions
cpx(){
    if [ "$#" -ne 1 ]; then
        echo "Usage: cpx <file.cpp>"
    else
        name=$(echo $1 | cut -f 1 -d '.')
        g++ -Wall  -fsanitize=address -fsanitize=undefined -ggdb3  $1 -o $name; ./$name
    fi
}
debug(){
    if [ "$#" -ne 1 ]; then
        echo "Usage: cpx <file.cpp>"
    else
        name=$(echo $1 | cut -f 1 -d '.')
        g++ -Wall -ggdb3  $1 -o $name; 
        valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out-$name.txt ./$name 
    fi
}
EOF
