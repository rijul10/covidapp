# Covid-app 2020

This application is made as a submission in the DSC HACKATHON SURAT - HackCovid 19.

## Objective

1. Use of deep learning in the app to predict whether the user is prone to coronavirus.
2. Real time location updates of coronavirus infections all around the globe with current news on covid-19 of that location.

## Architecture

The deep learning model uses VGG-16 architecture which is a deep convolutional network for object recognition developed and trained by **Oxford's renowned Visual Geometry Group (VGG)**, which achieved very good performance on the ImageNet dataset.
It is used as a base model while a top model is used to refine the model based on the requirements of this application. The weights used are pre-trained of the imagenet dataset and the architecture of the entire model is shown as below: -

![pictureaalt](https://github.com/rijul10/covidapp/blob/master/Screenshot%20from%202020-03-26%2011-21-12.png)

## Deployment

The API accepting our image is deployed on [Python Anywhere](https://www.pythonanywhere.com/)
The link of our REST API is as such: [API](http://rishabh3699.pythonanywhere.com/)

## Libraries Used

1. Python 3.7.6
2. Tensorflow 2.1.0
3. Keras 2.3.1
4. Flask 1.1.1

## Accuracy and loss plot

![picturealt](https://github.com/rijul10/covidapp/blob/master/plot.png)

## Application

The application is developed in flutter. It can be run simply by downloading app-release.apk and installing in your mobile phone. It accesses the API(link above) to use the trained model to predict COVID-19. A live tracker is also included in the application to keep track of status of COVID-19 cases around the world.

## Flutter Dependencies

 1. cupertino_icons: ^0.1.3
 2. image_picker: ^0.6.3+4
 3. webview_flutter: ^0.3.14+1
 4. dio: ^2.1.16
 5. http: ^0.12.0+4
 6. flutter_spinkit: ^4.1.2








.
