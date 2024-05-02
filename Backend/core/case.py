from core.heuristic import calculate_heuristic , city_coordinates


graph_dict = {
        "EL Kseur centre": [("Amizour", 14), ("Ilmaten", 16), ("Adekkar", 27) , ("Toudja", 21),("Tifra", 26),("Oued Ghir", 21),("Sidi Aich", 24)],
        "Amizour": [("Barbacha", 17), ("EL Kseur centre", 16)],
        "Ilmaten": [("Tifra", 14), ("Amizour", 24), ("EL Kseur centre", 16) , ("Adekkar", 20)],
        "Tifra": [("Ilmaten", 19),("Adekkar", 12),("Sidi Aich", 14),("EL Kseur centre", 26) ],
        "Adekkar": [("Tifra", 11), ("EL Kseur centre", 27),("Ilmaten", 20)],
        "Barbacha": [("Amizour", 17)],
        "Toudja": [("Oued Ghir", 16) , ("EL Kseur centre", 21)],
        "Oued Ghir": [("Toudja", 14),("EL Kseur centre", 18)],
        "Seddouk": [("Sidi Aich", 13)],
        "Sidi Aich": [("Seddouk", 13),("Tifra", 14),("Ilmaten", 13) , ("EL Kseur centre", 24)]
        }
