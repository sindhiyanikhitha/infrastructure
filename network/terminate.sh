echo "Enter the account you want to delete stack: "

read account

echo "Enter the stack name: "

read stack_name

echo "Preapring the script..."

echo "Checking if the stack already exists..."

if  aws cloudformation describe-stacks --stack-name $stack_name --profile $account ; then


	echo -e "Stack already exists, terminating a stack..."

	aws cloudformation delete-stack --stack-name $stack_name --profile $account


	echo "Waiting termination ..."

	aws cloudformation wait stack-delete-complete --stack-name $stack_name --profile $account

	 echo "Stack terminated "

else
		echo -e "Stack does not exist"
fi