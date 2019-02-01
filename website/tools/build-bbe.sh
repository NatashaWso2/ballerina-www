#!/bin/sh
echo ".....Building BBE Site....."
mkdir -p $2
export GOPATH=$3
go get github.com/russross/blackfriday
rm target/dependencies/ballerina-examples -rf
#git clone https://github.com/ballerina-platform/ballerina-examples target/dependencies/ballerina-examples
#git clone --branch v0.982.0 https://github.com/ballerina-platform/ballerina-examples target/dependencies/ballerina-examples

#get BBE from the language master branch
rm ballerina-lang -rf
git clone https://github.com/ballerina-platform/ballerina-lang
git --git-dir=ballerina-lang/.git --work-tree=ballerina-lang/ checkout v0.990.1
mkdir -p target/dependencies/ballerina-examples/
mv ballerina-lang/examples target/dependencies/ballerina-examples/examples/
rm ballerina-lang -r

#get BBE from BallerinaX
rm docker -rf
git clone https://github.com/ballerinax/docker
git --git-dir=docker/.git --work-tree=docker/ checkout v0.990.1
mkdir -p target/dependencies/ballerina-examples/examples
mv docker/docker-extension-examples/examples/* target/dependencies/ballerina-examples/examples/
rm docker -r

rm kubernetes -rf
git clone https://github.com/ballerinax/kubernetes
git --git-dir=kubernetes/.git --work-tree=kubernetes/ checkout v0.990.1
mkdir -p target/dependencies/ballerina-examples/examples
mv kubernetes/kubernetes-extension-examples/examples/* target/dependencies/ballerina-examples/examples/
rm kubernetes -r

rm jdbc -rf
git clone https://github.com/ballerinax/jdbc
git --git-dir=jdbc/.git --work-tree=jdbc/ checkout v0.990.1
mkdir -p target/dependencies/ballerina-examples/examples
mv jdbc/jdbc-extension-examples/examples/* target/dependencies/ballerina-examples/examples/
rm jdbc -r

go run tools/ballerinaByExample/tools/generate.go "target/dependencies/ballerina-examples" $2
echo "....Completed building BBE Site...."
