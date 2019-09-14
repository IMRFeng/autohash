### 智能合约实现

####  1.环境搭建
##### 1.1 Nodejs
##### (1) 先在系统上安装好nodejs和npm
```
sudo  apt-get  install  nodejs-legacy
sudo  apt-get  install  npm
```
##### (2)安装用于安装nodejs的模块n
```
sudo   npm  install  -g  n
```
##### (3)通过n模块安装指定的nodejs
```
sudo   n   latest
sudo   n   stable
sudo   n   lts
```
##### (4)升级npm为最新版本
```
sudo   npm  install  npm@latest -g
```
##### (5)查看版本
```
sudo    node    -v
```

##### 1.2 geth
```
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum
```

##### 1.3 solc
```
sudo npm install -g solc
sudo npm install -g solc-cli
```

##### 1.4 truffle

也可以使用Remix去测试
```
在命令行中执行命令
npm install -g truffle  进行安装，安装好后使用命令
truffle version         检查。
```
##### 1.5 Ganache-cli 
```
sudo npm install -g ganache-cli
```
本地测试
```
ganache-cli 需要开启,在工作目录:
truffle compile
truffle migrate  
```
####  2.工作流程

```
    UBI4智能合约实现
    ├── app 
       ...
    ├── contracts
    │   ├── Claim.sol             //理赔相关
    │   ├── helpers               //全局定义
    │   │   ├── Managed.sol
    │   │   └── Owned.sol
    │   ├── InsuranceFund.sol      
    │   ├── Migrations.sol
    │   ├── persistance           //状态维护
    │   │   ├── AccountingPersistance.sol
    │   │   └── InsurancePersistance.sol
    │   ├── Provident.sol          //投保相关接口定义
    │   ├── services              //投保查询等服务
    │   │   ├── InsuranceService.sol
    │   │   └── Insurance.sol
    │   └── tokens              //Token相关         
    │       └── Token.sol    
    ├── migrations  
       ...
    ├── testchain.sh    //测试帐号信息
    └── truffle.js     //配置文件
```
 ![data](https://github.com/IMRFeng/autohash/blob/master/UBI4%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6%E5%AE%9E%E7%8E%B0/images/1.png)
 ![工作流程](https://github.com/IMRFeng/autohash/blob/master/UBI4%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6%E5%AE%9E%E7%8E%B0/images/2.png)
