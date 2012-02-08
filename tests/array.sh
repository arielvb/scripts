############################
# Array in line declaration
############################
lista=("a" "b")

##############################
# Array individual declaration
##############################
lista[2]='b'
lista[3]='a'

##############################
# Push value
##############################
lista=(${lista[@]} 'c')
lista[${#lista[*]}]=4

###########################
# Print array
###########################
echo "#Printing an array: value1 valuen "
printf "> lista: "
for a in ${lista[@]}; do
	printf "${a} ";
done
printf "\n";

###########################
# Search
###########################
echo "#Searching value 4"
for a in ${lista[@]}; do
	if [[ $a == 4 ]]; then
		#statements
		echo "found"
	fi
done
echo '#Searching with indexes' 
for (( i = 0 ; i < ${#lista[@]} ; i++ )) do
	if [[ ${lista[$i]} == 4 ]]; then	
		echo "Element [$i]: ${lista[$i]}"	
	fi
done
