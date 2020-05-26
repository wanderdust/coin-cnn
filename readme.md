# A CNN to identify the most common types of coins.

Check out the app I built using this dataset: [Coin Recognition App](http://54.174.164.119/)

or

Run the app in your pc: [Coin Recognition App's Code](https://github.com/wanderdust/coin-cnn-webapp)

___________________

For up to date implementations:

* Using MobilenetV2 with keras: [MobileNetV2](https://www.kaggle.com/wanderdust/coin-prediction-using-keras-cnn-mobilenet)
* Using ResNet50 with keras: [ResNet50](https://www.kaggle.com/wanderdust/coin-prediction-using-keras-cnn)
* Using ResNet50 with pytorch: [ResnNet50](https://www.kaggle.com/wanderdust/coin-classifier)

### List of currencies:
| Supported Currency Coins |  | |
| --- | --- | --- |
| Australian dollar      | Hungarian Forint         | Pakistan Rupee     |
| Brazilian Real         | Indian Rupee             | Philipine peso     |
| British pound          | Indonesian Rupiah        | Polish Zloty       |
| Canadian dollar        | Israeli New Shekel       | Russian Ruble      |
| Chilean peso           | Japanese Yen             | Singapore Dollar   |
| Chinese Yuan Renminbi  | Korean Won               | South African Rand |
| Czech Koruna           | Malaysian Ringgit        | Swedish Krona      |
| Danish Krone           | Mexican peso             | Swiss Franc        |
| Euro                   | New Zealand dollar       | Tawian Dollar      |
| Hong Kong dollar       | Norwegian Krone          | Thai Baht          |
| Turkish Lira           | US Dollar                |                    |


### How to classify the classes.

The first problem that raises is weather to classify each coin side as a different class or as the same coin. As both sides of the coin will belong to the same coin, it makes sense for both the observe and reverse of the coin to be fed to the network as one category.

I'll observe how the model performs and make any changes if necessary.

# Getting the data
The first step to start creating our classifier is to get enough images of coins for each currency. I'll use a web scrapper and I'll create three directories: train, validation, test.

### Mapper: cat_to_name.json.

The [cat_to_name.json](https://github.com/wanderdust/coin-cnn/blob/master/cat_to_name.json) will map each category number to a coin name. It cointains an id for each coin category.

### Creating a web scrapper to gather our data.

The web scrapper will extract images from a website. To acomplish this I have created a Coin class to store all the relevant data for each coin instance, such as the url to scrap for a specific coin, the name and the images urls we want to download. Later on all the images found will be saved in the appropiate folder, labeled accordingly with their id.

One of the websites being used to collect our images is [ucoin](https://en.ucoin.net/). To gather this data the scrapper first looks at a currency list. From here it finds the specific coin we want and through a url we go to a gallery where we can find several pictures of the target coin. All the image urls get saved in our coin instance ready for download. Later we iterate through every coin and download all its images to a folder. 

One of the problems with scrapping is getting blocked for making too many requests. One counter measure to try and avoid this from happening is to slow down the web crawler. I've done this by adding a 1 second delay to the for loop that makes the requests for each coin.

The other website I'll be getting data from is [Bing search api](https://api.cognitive.microsoft.com/bing/v7.0/images/search), for the sake of diversity. The code for this scrapper is relatively easy, as all it takes is a call the api which returns the image urls ready to download.

One concerning issue is the possible duplicity of some of the images. Also, most images are already cropped to fit the coin nicely. This can cause a problem when training the network, because if all the images we feed it are "too perfect" it won't be able to generalize too well.

### Creating a shell script

The shell script add_jpg_extension.sh simply adds the .jpg extension to all the images for every folder. The reason for creating this script is that I forgot to add the extension when saving the images downloaded from the bing images api. :expressionless:


### Explore and visualize the data

Before splitting and processing our data images, I'll do some visualization in [data_visualize](https://github.com/wanderdust/coin-cnn/blob/master/data_visualize.ipynb). We want to explore things like the amount of data we have or the average image sizes.

### Split the data

The final step before jumping into building our network is to separate the data into three different directories: train, test and validation. I've done this in [data_sampler.ipynb](https://github.com/wanderdust/coin-cnn/blob/master/data_sampler.ipynb), where I keep 80% of the data for training, 10% for validation and the remaining 10% for testing.

### Add transformations to the images

The main problem I can think about the dataset now is how pretty the images have been cropped to fit the image. This will be a problem for the model to generalise because it won't do too well when we feed it images of coins with other things in the background. One way I can think to fix this is to randomnly apply some transformations to some of the images, not only random rotations and random croppings but also stacking a few images on top of each other creating a new image. This way we can feed the network images of several coins (of the same value) at the same time, helping it to generalize a bit more.

# Create the Convolutional Neural Network

### Preprocessing the images and batching

I'll add some random transformations to the data like rotations. This will prevent the model from overfiitng since the data shown will always be different even though the images are the same.

### Building the network

The network I'll use is a pre trained Resnet152. I'll change the fully connected layer for my own to fit my needs. I will use a relu activation function, and an adam optimizer. 

