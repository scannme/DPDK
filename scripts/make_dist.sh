#!/bin/bash

workdir=$(pwd)

makedir()
{
	mkdir dist
	mkdir tmp
	cd tmp
	mkdir function
	mkdir template
}

lambdafunzip() {
	echo "zip lambda function start"
	
	cd $workdir/aws_lambda/function/
	zip $workdir/tmp/function/lambda.zip  index.py cfnresponse.py 
	zip $workdir/tmp/function/find_ami.zip find_ami.py
	
	echo "zip lambda function end"
}

copytemplate() {
	cp $workdir/aws/template $workdir/tmp/ -R
}

awsquickzip() {
	cd $workdir/tmp/
	zip -q -r fortiweb-ha-auto-deploy-aws.zip *
	cp fortiweb-ha-auto-deploy-aws.zip  $workdir/dist/
}

azurequickzip(){
	cd $workdir/azure_quickstart/template/ 
	zip -q -r fortweb-auto-ha-azure-quickstart.zip *
  	cp fortweb-auto-ha-azure-quickstart.zip $workdir/dist/ 	
}




echo "start make dist..."

makedir
lambdafunzip
copytemplate
awsquickzip


