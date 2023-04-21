## [Bash CI/CD](/README.md)

### bash to print out a list of contributor’s name along with number of commits on Code repos,  If names of author are provided as arguments, it return only commits for those.

```sh
    results=$(git log --pretty="tformat:%an" | uniq -c | sed -E)

    if [[ $# -lt 1 ]]; then
        echo "Insert valid git repostory !!"
        exit 1
    fi

    OLDIFS=$IFS
    IFS='\'
    for line in ${results}; do
        echo "$line"
    done
    IFS=$OLDIFS
```

### bash to count number of times a component with a given name is used (the component name should be given as argument of the script & multiple names can be given)

 + For example: ./component-count.sh Button Header Footer
    ```s
    Button - 10
    Header - 2
    Footer - 1
    ```

```sh
   if [ $# -lt 1 ]; then
    echo "Enter the directory as first argument followed by Component name"
    exit 1
    fi

    while [ $# -gt 0 ]; do
        sum=0
        component=$1
        files=$(find . -name "$component")
    for name in $files; do
        sum=$((sum + 1))
    done
    echo "$component = $sum"
        shift
    done
```

### Bash script that
- Print out information about fetch data. The name should be argument of the script
- For example: sh Fetch.sh Sweden Finland
- The output would be like:

Check the script [here](/Fetch.sh)

```bash
    Name: Finland
    Population:5530719
    Capital:[ "Helsinki" ]
    Languages:{ "fin": "Finnish", "swe": "Swedish" }

    Name: Sweden
    Population:10353442
    Capital:[ "Stockholm" ]
    Languages:{ "swe": "Swedish" }
```


