# WHAT IS YAML ?

-A YAML file is used to represent data, in most cases, it is configuration data


### Key-Value pair
-How does key-value pair work?
They are simply keys with their own values, example:

fruit: apple
vegetable: carrot
liquid: water
meat: chicken

-Remember there needs to be a "space" afert the colon


### Array
-This will be use to create lists
-The Array is the key, and each element of the array uses a dash symbol

Fruits:
- orange
- apple
- banana

Vegetables:
- carrot
- cauliflower
- tomato


### Dictionary / Map
-It is a set of PROPERTIES grouped together, under an item (key)
-You ,ust have EQUAL number of blank spaces when representing identations
-The following examples are 2 dictionaries

Banana:
    Calories: 105
    Fat: 0.24 g
    Carbs: 27 g

Grapes:
    Calories: 62
    Fat: 0.3 g
    Carbs: 16 g

-IDENTATION is used to identify what values belong to what items


### List containing dictionaries, containing lists
-In the following example, we will turn a list of fruits, with the elements of banana and grape
-And each of these alements ("Array keys") also contain dictionaries, with data about nutrition information

Fruits:

    - Banana:
          -Calories: 105
          -Fat: 0.24 g
          -Carbs: 27 g

    - Grapes:
          -Calories: 62
          -Fat: 0.3 g
          -Carbs: 16 g

-The following example will be a dictionary within a dictionary

employee:
    name: john
    gender: male
    age: 24
    address:
        city: edison
        state: new jersey
        country: united states



# KEY NOTES

-Dictionary is a collection of values/items with NO ORDER
The properties inside can be defined in any order

-Lists or Arrays, in the other hand, are collections WITH order
In here, the order of items matter
This is something to keep in mind when working with data structures
