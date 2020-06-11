#!/bin/bash

workdir=$(pwd)

maketmpdir()
{
	mkdir tmp
	cd tmp
	mkdir function
	mkdir template
}
lambdafunzip() {
	echo "zip lambda function start"
	
	cd $workdir/aws_lambda
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




echo "start make aws dist..."

maketmpdir
lambdafunzip
copytemplate
awsquickzip

rm $workdir/tmp/ -rf 
