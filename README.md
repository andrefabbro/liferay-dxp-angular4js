# Liferay DXP + Angular 4

## Pre-requisites

* JDK 8 (http://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html)
* Blade Tools (https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/installing-blade-cli)
* NodeJS (https://nodejs.org/)
* NPM (https://www.npmjs.com/get-npm)
* Docker (https://www.docker.com/)

## Install

* Create a folder named .liferay into you home folder if it doesn't exists:

```bash
mkdir -p ~/.liferay
```

* Copy the file liferay-dxp-digital-enterprise-tomcat-7.0-sp7-20180307180151313.zip to ~/.liferay/bundles/

```bash
mkdir -p ~/.liferay/bundles/
cp liferay-dxp-digital-enterprise-tomcat-7.0-sp7-20180307180151313.zip ~/.liferay/bundles/
```

* Copy the file liferay-fix-pack-de-45-7010.zip to ~/.liferay/fix-packs/

```bash
mkdir -p ~/.liferay/fix-packs/
cp liferay-fix-pack-de-45-7010.zip ~/.liferay/fix-packs/
```

* Copy the file activation-key-development.xml (your license file) to ~/.liferay/activation/

```bash
mkdir -p ~/.liferay/activation/
cp activation-key-development.xml ~/.liferay/activation/
```

## Setup the Bundle

Execute:

```bash
./setup.sh init
```

It should create a docker container with mysql database, and setup your liferay bundle pointing to this database.

Then, start the server:

```bash
blade server start
```

After the server start, you can deploy the angular example portlet in modules folder:

```bash
cd modules/poc-angular-hello-world/
npm install
blade deploy
```

Then, access your http://localhost:8080, user: test@liferay.com, password: test

## Create a new Angular Portlet

You can create a new Angular portlet like following:

```bash
blade create -t npm-angular-portlet -p com.myportlet -c MyAngular my-angular-portlet
```

Then deploy:

```bash
cd modules/my-angular-portlet/
npm install
blade deploy
```

## Edit your portlet

Open the portal in http://localhost:8080 and drag your new portlet into any page, you'll see the Hello World message. Then edit the caption property from the Angular component in the file modules/my-angular-portlet/src/main/resources/META-INF/resources/js/app/app.component.ts

```bash
vi modules/my-angular-portlet/src/main/resources/META-INF/resources/js/app/app.component.ts
```

```javascript
import { Component } from '@angular/core';

@Component({
	template: `
		<div>{{caption}}</div>
	`
})
export class AppComponent {

    caption = 'My New Message from Angular!';
    
}
```

Save the file and deploy again:

```bash
blade deploy
```

Go to the page where contains your portlet, you'll see the new message.