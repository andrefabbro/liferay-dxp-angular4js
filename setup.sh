#!/bin/bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately

COMMAND="$1"

## Clean and create a new DB instance
init_db() {
	echo "=============================="
	echo "Clean and create a new DB instance"
	echo "=============================="
	docker stop dxpangular || true
	docker rm dxpangular || true
	docker run --name dxpangular -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=intranet --publish 3306:3306 -d mysql:5.6 --character-set-server=utf8 --collation-server=utf8_general_ci
}

##
## Setup a new Liferay EE Bundle and apply the patch
## Make sure that you have the last patch in your user home directory 
## 
init_bundle() {
	echo "=============================="
	echo "Setup a new Liferay EE Bundle and apply the patch"
	echo "=============================="
	
	# Clean the bundle directory
	rm -rf bundles/*
	
	# Init the bundle from the base package
	blade gw initBundle -x downloadBundle
	
	# create the deploy folder
	mkdir -p bundles/deploy
	
	# Copy a valid license
	cp ~/.liferay/activation/*.xml bundles/deploy
	
	# Deploy and Install Fixpack
	cp ~/.liferay/fix-packs/liferay-fix-pack-de-45-7010.zip bundles/patching-tool/patches
	./bundles/patching-tool/patching-tool.sh install
}

deploy() {
  echo "=============================="
  echo "Build the modules"
  echo "=============================="
  
  blade deploy
}

## Init Bundle Environment
init() {
  init_db
  init_bundle
}

build_package() {
  init_bundle
}

setup_intranet_demo() {
  echo "=============================="
  echo "Install plugins"
  echo "=============================="
  
  ## Restore the Document Library
  cp -R ~/.liferay/intranet-sales-demo/document_library bundles/data/

  ## Install plugins
  cp ~/.liferay/intranet-sales-demo/marketplace/*.lpkg bundles/deploy/

  ## Install modules
  cp ~/.liferay/intranet-sales-demo/modules/*.jar bundles/deploy/

  ## Install Themes and Layout Templates
  cp ~/.liferay/intranet-sales-demo/war/*.war bundles/deploy/
}

case "${COMMAND}" in
  init ) init
        exit 0
        ;;
  package ) build_package
	    exit 0
	    ;;
  deploy ) deploy
	    exit 0
	    ;;
  demo ) setup_intranet_demo
	    exit 0
	    ;;
  *)
    echo $"Usage: $0 {init, package, deploy, demo}"
      exit 1
esac
exit 0