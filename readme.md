## A CNN to identify the most common types of coins.

### List of currencies:

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


## How to classify the classes.

The first problem that appears is weather to classify each coin side as a different class or as the same coin.

## Mapper: cat_to_name.json.

This json will map each category number to a coin name.

## Creating a web scrapper to gather our data.

Our web scrapper will extract images from a website. To acomplish this I have created a Coin class to store all the relevant data for each coin instance, such as the url to scrap for a specific coin, the name and the images urls we want to download. Later on all the images found are saved in the appropiate folder, labeled accordingly with their id.