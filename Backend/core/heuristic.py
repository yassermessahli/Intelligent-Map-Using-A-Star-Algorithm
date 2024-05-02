import math



city_coordinates = {
    'EL Kseur centre': [36.70701093389901, 4.838150095511627],
    'Amizour': [36.64395418014552, 4.903987122431135],
    'Ilmaten': [36.66813118824581, 4.768482859239159],
    'Tifra': [36.666400844419, 4.697174785132521],
    'Adekkar': [36.69175879902285, 4.669115025826935],
    'Barbacha': [36.572139466452185, 4.972872433941499],
    'Toudja': [36.75376512917291, 4.893119368422495],
    'Oued Ghir': [36.709294791133246, 4.989026063037125],
    'Seddouk': [36.54706087199331, 4.687499870021105],
    'Sidi Aich': [36.609625302606226, 4.691273224293743]
}


def calculate_heuristic(city1_lat, city1_lng, city2_lat, city2_lng):
    lat1 = math.radians(city1_lat)
    lng1 = math.radians(city1_lng)
    lat2 = math.radians(city2_lat)
    lng2 = math.radians(city2_lng)
    
    
    delta_lat = lat2 - lat1
    delta_lng = lng2 - lng1
    
    # FORMULA OF HAVERSINE
    a = math.sin(delta_lat / 2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(delta_lng / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    distance = 6371 * c  
    
    return distance

