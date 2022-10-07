import pandas as pd
import googlemaps

gmaps = googlemaps.Client(key='')

df = pd.read_csv('data/resale-flat-prices-2017-training.csv')

# hard code singapore address
def create_address(row):
    address = '{}, {}, SINGAPORE'.format(row.street_name, row.town)
    return address

# pull lat and lng from google
def geocode(address):
    result = gmaps.geocode(address)
    return result[0]['geometry']['location']

# get unique street and town combinations
streets = df[['street_name', 'town']].drop_duplicates()
locations = streets.apply(
    lambda x: geocode(create_address(x)),
    axis=1, result_type='expand'
)

streets.join(locations).to_csv('data/geocoded_streets.csv', index=False)
