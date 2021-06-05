import pandas as pd
from scipy import sparse
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import io
import requests
import sys

### Ono sto je u mom csv-u "Proba - Copy.csv"
url="http://147.91.204.116:11094/inf.csv" 
s=requests.get(url).content
rating1=pd.read_csv(io.StringIO(s.decode('utf-8')))

### Ono sto je u mom csv-u "Prodavci i njihovi proizvodi.csv"
url="http://147.91.204.116:11094/proipro.csv"   
s=requests.get(url).content
sellers_and_products=pd.read_csv(io.StringIO(s.decode('utf-8')))

##################### how many products a seller has
def how_many_products_a_seller_has(seller):
    seller1 = sellers_and_products[sellers_and_products['idProdavca'] == seller].shape[0] #shape[0] gives number of rows
    return seller1

##################### sum of all the ratings one user has for all products of one seller
def sum_of_ratings_from_one_user_to_one_seller(user, seller):
    #first filter  dataframe by user and seller, result is a dataframe:
    sum_of_ratings = rating1[ (rating1['idKorisnika'] ==user) & (rating1['idProdavca'] == seller)] 
    #sum all ratings from the dataframe sum_of_ratings
    sum_of_ratings = sum_of_ratings['ocena'].sum() 
    return sum_of_ratings

##################### add sums
rating1['ZbirOcena'] = rating1.apply(lambda 
                      row: sum_of_ratings_from_one_user_to_one_seller(row.idKorisnika, row.idProdavca), axis = 1)

##################### add weights
rating1['tezina'] = rating1.apply(lambda 
                      row: (row.ZbirOcena / how_many_products_a_seller_has(row.idProdavca)), axis = 1)

##################### take all whose weight is appropriate and drop columns you don't need
rating = rating1[(rating1['tezina'] < 4.5) & (rating1['tezina'] > 1.5)].drop(['idProdavca','ZbirOcena', 'tezina'], axis=1)
rating = rating.drop(['id', 'idKategorije'], axis=1)
#rating

### Ono sto je u mom csv-u "Korisnik.csv"
#url="https://raw.githubusercontent.com/cs109/2014_data/master/countries.csv"
#s=requests.get(url).content
#myuser=pd.read_csv(io.StringIO(s.decode('utf-8')))
myuser=sys.argv[1]
#print(myuser)

##################### distinct product list
product_row = rating['idProizvoda'].tolist() #taking the column 'out'
product_row_distinct = list(dict.fromkeys(product_row)) #removing the duplicates

##################### make my user Cartesian
def for_user(user):
    df = rating[rating['idKorisnika'] == user]
    return df
def for_user_his_products_and_rates(user):
    tuple1 = list(zip(for_user(user)['idProizvoda'].tolist(), for_user(user)['ocena'].tolist()))
    return tuple1
def for_user_products_he_rated(user):
    list1 = for_user(user)['idProizvoda'].tolist()
    return list1

myperson = for_user_his_products_and_rates(myuser)

##################### making similarity matrix 
rating_list = rating.values.tolist()
ratings = pd.DataFrame()
for row in rating_list:
    ratings.at[row[0] - 1, row[1] - 1] = row[2]
ratings.fillna(0, inplace=True)

## similarity Matrix
item_similarity_df = ratings.corr(method='pearson')
item_similarity_df.columns = product_row_distinct
#item_similarity_df

##################### recommend when you have data about one product rating
def item_similarity_df_for_product  (product):
    product_df = pd.DataFrame([product_row_distinct, item_similarity_df[product].tolist()]).T
    #product_df[0] = product_df[0].apply(np.int64)
    return product_df

def item_similarity_df_for_product  (product):
    product_df = pd.DataFrame([product_row_distinct, item_similarity_df[product].tolist()]).T
    product_df[0] = product_df[0].apply(np.int64)
    return product_df
#item_similarity_df_for_product(2)

#this would be a recommendation if we have user rating for 1 product in a list, so we can sum them afterwards
def recommendation1 (product, user_rating):
    product_column_in_item_similarity_df_for_product = item_similarity_df_for_product(product)[1]
    similar_products = product_column_in_item_similarity_df_for_product * (user_rating - 2.5)
    similar_products = similar_products.tolist()
    return similar_products

##################### recommend when you have data about more product rating
def recommendationMore (person):
    similar_products_all = []
    for product, rating in person:
        recommendation1(product, rating)
        similar_products_all.extend([recommendation1(product, rating)])
        similar_products_all
    return similar_products_all

similar_product_whole_sum = [sum(i) for i in zip(*recommendationMore(myperson))]

##################### move products that were already rated
#remove all the products that the person rated
def what_remains_for_all(user):
    similar_products_whole_sum_df = pd.DataFrame([product_row_distinct, similar_product_whole_sum]).T
    similar_products_whole_sum_df[0] = similar_products_whole_sum_df[0].apply(np.int64)
    similar_products_whole_sum_df
    df_remove_those_he_rated = similar_products_whole_sum_df[~similar_products_whole_sum_df[0].isin(for_user_products_he_rated(user)) ]
    #df_remove_those_he_rated.columns = ['product_id', 'rates']
 
    a = df_remove_those_he_rated.sort_values(by=[1], ascending=False)[0].tolist()
    return a

##################### make a list to send it to them
rezultat = pd.DataFrame(what_remains_for_all(myuser))
print (rezultat)
#rezultat.to_json('rezultat.json')
