#!/usr/local/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Please, insert at least name of one country"
	exit 1
fi
for name in "$@";do
	url="https://restcountries.com/v3/name/$name"
	response=$(curl -s GET $url -H "content-type: application/json")

	name=$(echo "$response" | jq -r '.[].name.common')
	population=$(echo "$response" | jq -r '.[].population')
	languages=$(echo "$response" | jq -r '.[].languages')
	capital=$(echo "$response" | jq -r '.[].capital')

	echo "Name:" $name
	echo "Population:"$population
    echo "Capital:"$capital
	echo "Languages:"$languages
done


# if [[ $# -lt 1 ]]; then
# 	echo "Atleast One productId [ex.1,2,3] is required!"
# 	exit 1
# fi
# for id in "$@";do
# 	url="https://api.escuelajs.co/api/v1/products/$id"
# 	response=$(curl -s GET $url -H "content-type: application/json")

# 	title=$(echo "$response" | jq -r '.title')
# 	price=$(echo "$response" | jq -r '.price')
# 	description=$(echo "$response" | jq -r '.description')
# 	category=$(echo "$response" | jq -r '.category.name')

# 	echo "Title:" $title
# 	echo "Price:" $price
# 	echo "Description:" $description
# 	echo "Category:" $category
# 	echo 
# done