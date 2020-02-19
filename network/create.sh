echo " Enter account name  "

read account

echo "Enter the name of the stack: "

read stack_name

echo "Enter the vpc name: "

read vpcName

echo "Enter the region name "

read vpcRegion

echo "Enter the VPC CIDR BLOCK: "

read vpcCidr

echo "Subnet1: "

read subNetCidrBlock1

echo "Subnet2: "

read subNetCidrBlock2

echo " Subnet3: "

read subNetCidrBlock3

echo "Preparing the stack..."

stackId=$(aws cloudformation create-stack --stack-name $stack_name --template-body \
 file://networking.json --profile $account --region $vpcRegion --parameters \
ParameterKey=vpcName,ParameterValue=$vpcName \
ParameterKey=vpcCidr,ParameterValue=$vpcCidr \
ParameterKey=subNetCidrBlock1,ParameterValue=$subNetCidrBlock1 \
ParameterKey=subNetCidrBlock2,ParameterValue=$subNetCidrBlock2 \
ParameterKey=subNetCidrBlock3,ParameterValue=$subNetCidrBlock3 \
--query [StackId] --output text)

echo "Creating the stack..."
echo $stackId


if [ -z $stackId ]; then
    echo 'Error occurred.Dont proceed. TERMINATED'
else
    aws cloudformation wait stack-create-complete --stack-name $stackId --profile $account
    echo "Stack created successfully."
fi