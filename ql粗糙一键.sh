update(){

if [[ `cat /etc/*-release|grep -E 'ubuntu[^ ]*|debian[^ ]*'` ]];then

        apt update

        elif [[ `cat /etc/*-release|grep -E 'centos[^ ]*|fedora[^ ]*'` ]];then

        yum check-update

        fi

        }

curl_install() {

    echo "检测 curl......."

    if [ -x "$(command -v curl)" ]; then

        echo "检测到 curl 已安装!"

    else

        if [[ `cat /etc/*-release|grep -E 'ubuntu[^ ]*|debian[^ ]*'` ]];then

        apt install curl

        elif [[ `cat /etc/*-release|grep -E 'centos[^ ]*|fedora[^ ]*'` ]];then

        yum install curl

        fi

        fi

     get_char

}

wget_install() {

    echo "检测 wget......"

    if [ -x "$(command -v wget)" ]; then

        echo "检测到 wget 已安装!"

    else

        if [[ `cat /etc/*-release|grep -E 'ubuntu[^ ]*|debian[^ ]*'` ]];then

        apt install wget

        elif [[ `cat /etc/*-release|grep -E 'centos[^ ]*|fedora[^ ]*'` ]];then

        yum install wget

        fi

        fi

     get_char

}

docker_install() {

    echo "检测 Docker......"

    if [ -x "$(command -v docker)" ]; then

        echo "检测到 Docker 已安装!"

    else

        if [ -r /etc/os-release ]; then

            lsb_dist="$(. /etc/os-release && echo "$ID")"

        fi

        if [ $lsb_dist == "openwrt" ]; then

            echo "openwrt 环境请自行安装 docker"

            exit 1

        else

            echo "安装 docker 环境..."

            curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

            echo "安装 docker 环境...安装完成!"

            systemctl enable docker

            systemctl start docker

        fi

    fi

    get_char

}

docker-compose_install() {

    echo "检测 docker-compose......"

    if [ -x "$(command -v docker-compose)" ]; then

        echo "检测到 docker-compose 已安装!"

    else

        sudo curl -L "https://ghproxy.com/github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

         if [ -r /usr/local/bin/docker-compose ]; then 

        sudo chmod +x /usr/local/bin/docker-compose

        docker-compose --version

        fi

   fi

   get_char

}

git_install() {

    echo "检测 git......"

    if [ -x "$(command -v git)" ]; then

        echo "检测到 git 已安装!"

    else

        if [[ `cat /etc/*-release|grep -E 'ubuntu[^ ]*|debian[^ ]*'` ]];then

        apt install git

        elif [[ `cat /etc/*-release|grep -E 'centos[^ ]*|fedora[^ ]*'` ]];then

        yum install git

        fi

        fi

     get_char

}

go_install() {

   test_num=`ls -lh /usr/local/go1.16.7.linux-amd64.tar.gz |awk '{print $5}' |sed 's/M//g'`

    small_num=122

    big_num=125

        if [ -x "$(command -v go)" ]; then

        echo "检测到 go 已安装!"

        elif [ $test_num -gt $small_num -a $test_num -lt $big_num ];then

         echo "在范围内"

        cd /usr/local 

        ls /usr/local/go/api/*.txt || tar -xvzf go1.16.7.linux-amd64.tar.gz

        else

        rm -rf /usr/local/go1.16.7.linux-amd64.tar.gz

        cd /usr/local && wget http://91io.cn/s/R117Vfl/go1.16.7.linux-amd64.tar.gz

        #https://golang.google.cn/dl/go1.16.7.linux-amd64.tar.gz -O go1.16.7.linux-amd64.tar.gz

        tar -xvzf go1.16.7.linux-amd64.tar.gz

        fi

        

echo "代码写入文件/etc/profile"

#get_char

if [[ `grep GO111MODULE /etc/profile` ]];then

echo "代码已存在"

else

echo -e 'export GO111MODULE=on \nexport GOPROXY=https://goproxy.cn \nexport GOROOT=/usr/local/go \nexport GOPATH=/usr/local/go/path \nexport PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >>/etc/profile

fi

echo " 已写入，按任意键继续"

#get_char

        source /etc/profile

        go env      

        get_char  

}

jd-qinglong_install() {

   cd 

   echo "下载配置文件...."

   if [ -r /root/docker-compose.yml ]; then

   echo "文件已存在"

   else

   wget -O docker-compose.yml https://ghproxy.com/https://raw.githubusercontent.com/rubyangxg/jd-qinglong/master/docker-compose-allinone.yml

   fi

   if [ -r /root/env.properties ]; then

   echo "文件已存在"

   else

   wget -O env.properties https://ghproxy.com/https://raw.githubusercontent.com/rubyangxg/jd-qinglong/master/env.template.properties

   fi

   echo "配置文件下载完成\n安装并启动"

   docker-compose up -d

   #get_char

   echo "下面启动后按 CTRL+c "

   nohup docker-compose logs -f &

get_char

}

unzip_install() {

    echo "检测 unzip......"

    if [ -x "$(command -v unzip)" ]; then

        echo "检测到 unzip 已安装!"

    elif [[ `cat /etc/*-release|grep -E 'ubuntu[^ ]*|debian[^ ]*'` ]];then

        apt install unzip

        else

        if [[ `cat /etc/*-release|grep -E 'centos[^ ]*|fedora[^ ]*'` ]];then

        yum install unzip

        fi

        fi

     get_char

}

kjzq_sz() {

cd 

if [[ `grep docker /root/.zq.sh` ]];then

echo "自启文件已存在"

else

echo -e '../root/sillyGirl/sillyGirl -d \ncd /root/ \ndocker-compose up -d \ndocker-compose logs -f' >>.zq.sh

fi

if [[ `grep zq.sh /etc/rc.local` ]];then

echo "自启文件已存在"

else

echo 'bash /root/.zq.sh' >>/etc/rc.local

fi

get_char

}

sillygirl_install() {

   cd 

   if [ -r /root/sillyGirl/dev.go ];then

   echo "sillygirl已下载"

   else

   rm -rf *.zip

   wget http://91io.cn/s/y88mOsD/sillyGirl.zip

   unzip sillyGirl.zip

  fi

   cd /root/sillyGirl

   go build

   #get_char

   echo "QQ扫码登录,扫码成功后\n按 CTRL+c "

   echo '手动 cd /root/sillyGirl'

   echo -e '手动后台运行'\n'./sillyGirl -d'

   echo -e "复制上面需要用的内容后\n按任意键继续"

   #get_char

   echo "QQ扫码登录,扫码成功后\n按 CTRL+c "

   echo '手动 cd /root/sillyGirl'

   echo -e '手动后台运行'\n'./sillyGirl -d'

   echo -e "复制上面需要用的内容后\n按任意键继续"

   #get_char

   cd /root/sillyGirl

   ./sillyGirl

get_char   

}

htyxsn(){

../root/sillyGirl/sillyGirl -d

get_char

}

cl(){

if [ -x "$(command -v curl)" ];then  

echo "√"

fi

}

wt(){

if [ -x "$(command -v wget)" ]; then

        echo "√"

        fi

        }

dr(){

if [ -x "$(command -v docker)" ]; then

        echo "√"

        fi

        }

de(){

if [ -x "$(command -v docker-compose)" ]; then

        echo "√"

        fi

        }

gt(){

if [ -x "$(command -v git)" ]; then

        echo "√"

        fi

        }

golang(){

if [ -x "$(command -v go)" ]; then

        echo "√"

        fi

        }

ql_web(){

if [[ `docker ps|grep qinglong` && `docker ps|grep webapp` ]]; then

        echo "√"

        fi

        }

up(){

if [ -x "$(command -v unzip)" ]; then

        echo "√"

        fi

        }

kz(){

if [[ `grep docker /root/.zq.sh` && `grep zq.sh /etc/rc.local` ]];then

        echo "√"

        fi

        }

sl(){

if [ -r /root/sillyGirl/dev.go ];then

   echo "√"

   fi

   }

get_char() {

echo "出错可以退出重新执行"

a=(exit 1)

echo -e "0.更新 \n1.安装curl`cl` \n2.安装wget`wt` \n3.安装docker`dr` \n4.安装docker-compose`de` \n5.安装git`gt` \n6.安装go`golang` \n7.安装jd-qinglong`ql_web` \n8.安装unzip`up` \n9.设置开机自启`kz` \n10.安装傻妞`sl` \n11.后台运行傻妞 \n12.重启服务器"

echo && stty erase '^H' && echo -e "继续Y或y:\n退出N或n：" && read -p "" num

case "$num" in 

y)get_char;; Y)get_char;; n)$a;; N)$a;; 

0)update

;;

1)curl_install

;;

2)wget_install

;;

3)docker_install

;;

4)docker-compose_install

;;

5)git_install

;;

6)go_install

;;

7)jd-qinglong_install

;;

8)unzip_install

;;

9)kjzq_sz

;;

10)sillygirl_install

;;

11)htyxsn

;;

12)reboot

;;

*)

echo -e "${Error} 请输入正确"

get_char

esac

}

get_char
