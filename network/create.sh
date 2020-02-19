echo "Enter the account"

read account

echo "Enter a Stack Name: "

read stack_name

echo "Enter a  VPC Name: "

read vpcName

echo " Enter a region: "

read vpcRegion

echo " Enter a CIDR BLOCK: "

read vpcCidr

echo "Enter a Subnet1: "

read subNetCidrBlock1

echo "Enter a Subnet2: "

read subNetCidrBlock2

echo "Enter a Subnet3: "

read subNetCidrBlock3

echo "Enter subnet name 1: "

read subnetName1

echo "Enter subnet name 2: "

read subnetName2

echo "Enter subnet name 3: "

read subnetName3

echo "script is initializing....."

stackId=$(aws cloudformation create-stack --stack-name $stack_name --template-body \
 file://networking.json --profile $account --region $vpcRegion --parameters \
ParameterKey=vpcName,ParameterValue=$vpcName \
ParameterKey=vpcCidr,ParameterValue=$vpcCidr \
ParameterKey=subNetCidrBlock1,ParameterValue=$subNetCidrBlock1 \
ParameterKey=subNetCidrBlock2,ParameterValue=$subNetCidrBlock2 \
ParameterKey=subNetCidrBlock3,ParameterValue=$subNetCidrBlock3 \
ParameterKey=subnetName1,ParameterValue=$stack_name$subnetName1 \
ParameterKey=subnetName2,ParameterValue=$stack_name$subnetName2 \
ParameterKey=subnetName3,ParameterValue=$stack_name$subnetName3 \
ParameterKey=vpcIdUn,ParameterValue=vpcId$stack_name \
--query [StackId] --output text)

echo "Stack Id"
echo $stackId

if [ -z $stackId ]; then
    echo 'Error occurred TERMINATED'
else
    aws cloudformation wait stack-create-complete --stack-name $stackId --profile $account
    echo "Stack Created"
fi