sudo yum update
sudo yum install -y yum-utils
# adding repo
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
# install terraform
sudo yum -y install terraform
terraform
sudo hostnamectl set-hostname Terraform-Server
sudo init 6


# ___________________________________________Terraform________________________________________________________


mkdir jenkins && cd jenkin
ls
vi provider.tf
vi main.tf
vi data.tf
vi variables.tf
vi security.tf
terraform init
terraform fmt
terraform validate

# if validate doen't work 
terraform apply -target=aws_dynamodb_table.tf_lock -lock=false

terraform plan
terraform apply


# ____________________________________________Jenkins_________________________________________________________


# open page in mobaXtern for jenkins
sudo su -
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
amazon-linux-extras install epel
sudo amazon-linux-extras install java-openjdk11 -y
yum install java-11-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
java -version
javac -version
systemctl status jenkins
sudo hostnamectl set-hostname jenkins-server
init 6


# __________________________________________Install and Configure Maven_______________________________________


sudo su -
systemctl status jenkins
systemctl start jenkins
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
tar -xzvf apache-maven-3.9.5-bin.tar.gz
mv apache-maven-3.9.5 maven
ls
cd maven
cd bin/
./mvn -v  
cd ~
ls -a      #It will show the hidden files also
find / -name java-11*
vim .bash_profile
# enter below lines below the 2nd fi

M2_HOME=/opt/maven
M2=/opt/maven/bin
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.23.0.9-2.amzn2.0.1.x86_64

# User specific environment and startup programs

PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2

echo $PATH
source .bash_profile
echo $PATH
mvn -v


# _________________________________Configure Jenkins User Interface and Maven Integration______________________


# open : http://16.171.32.221:8080/
# get the password url
cat /var/lib/jenkins/secrets/initialAdminPassword
# add plugin maven
# edit tools add java and maven
# edit github installed plugin turn off the source plugin
yum install git -y


# ______________________________________Create a Test Job______________________________________________________


# in jenkins craete an item : test job for application

cp -r jenkins ansible
cd ansible
ls
vi data.tf
# now change the name of jenkins with ansible in all tf files and in provider comment the table to not be created again
# if error
ls -a
# if you find .terraform .terraform.lock.hcl 
rm -rf .terraform .terraform.lock.hcl
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply


# ______________________________________Install and Config Ansible____________________________________________


# open page in mobaXtern for Ansible
sudo hostnamectl set-hostname ansible-server
sudo su -
useradd ansadmin
passwd ansadmin
visudo
# under same with no password
ansadmin ALL=(ALL)       NOPASSWD: ALL
cd /etc/ssh
ls
vi sshd_config
password auth .... yes
service sshd reload
su ansadmin
cd ~
ssh-keygen
ls .ssh/
sudo su
amazon-linux-extras install ansible2
ansible --version


# ___________________________________Integrate Ansible With Jenkins____________________________________________


# in jenkins add ssh plugin and go to setting to ssh down and add ansible server, ip, ansadmine and password

# ________________________________Install Docker in Ansible Server____________________________________________

sudo ansadmin
cd ~
cd /opt
sudo mkdir docker
sudo chown ansadmin:ansadmin docker
# in jenkins configure test1 add post-build action : send build artifact iver ssh
# trabsfer set
webapp/target/*.war
webapp/target
//opt//docker

ls docker
ll docker
cd /opt/docker
sudo yum install docker
sudo usermod -aG docker ansadmin
id ansadmin
sudo service docker start
sudo systemctl start docker
#Reboot
init 6
Start docker
sudo su – ansadmin
cd /opt/docker/