
# SHELL-SCRIPTING 
#
## Topics

- **Print command**
- **Redirectors**
- **Exit Status**
- **Pipes**
- **Communication**
- **Quotes**
- **Text Filters**
- **Variables**
- **Functions**
- **Conditions**
    - **Expressions**
- **Loops**
#
##### SHE-BANG : First and foremost line
```!# /bin/bash```

##### COMMAND-NAME {options} I/P - May have options, may not have options
## Print Command- ECHO
**echo {options}**
```
-e : Enable ESC sequences

\n - New line
Syntax: echo -e "Hello,\nHi"

\t - Tab space vertically
Syntax: echo "Hello\tHi"

\e - New color
Syntax: echo -e "\e[COL-CODEmInut"
Example: echo -e "\e[31mHelloSatish"

-n : To disable new lines
```
To reset the color : ```echo -e "\e[0m"```

**To get a FG & BG in one syntax :** 
```echo -e "\e[31;43mHelloSatish"```

**To get the letters in Bold with FG & BG in one syntax :**
```example: echo -e "\e[1;31;43mHelloSatish"```

**To enable the color and disable it :**
```echo -e "\e[1;31;43mHelloSatish[0m"```

m: This character signifies that the sequence is setting text attributes, such as color, boldness, or underlining. The parameters before m (like numbers) define the specific attributes to apply.

**Note** : Whenever we are using ```"-e" ``` option in echo command always provide the input in double quotes.
##### Color : man console_codes
                           FG      BG          FG-Foreground & BG-Background
              Black        30      40
              Red          31      41
              Green        32      42
              Yellow       33      43
              Blue         34      44
              Magenta      35      45
              Cyan         36      46
              White        37      47

## Redirectors
##### Keyboard Input <--- File
##### Terminal Output <--- File
##### Input Redirector  **STADIN**  ```<```
##### Output Redirector **STDOUT**  ```>```
##### STDOUT ```1>``` OR STDERR ```2>```
##### Output and error : ```&>``` or ```2>&1``` append the output or ```1>&2 ```
**Redirects multiple lines of input to a command until a specified delimiter is reached.**
```
cat << EOF
This is line 1
This is line 2
EOF
```
**Usage: Redirects a string as input to a command.**
```grep "hello" <<< "hello world"```

**This command redirects both standard output and standard error to output.txt**
```command > output.txt 2>&1 ```
**Sometimes we need the output to be printed on screen and save it in a file.**
```
tee 
ls | tee out
ls | tee -a out : append
```
```>/dev/null``` OR ```>/dev/null 2>&1``` : **trash, it takes the input and it nullifies, character special file.**
`
**NOTE:** Main disadvantage of a shell is if it fails one command it will never stop. It will execute the next command.

## Exit status

Ranges from **0-255**
**0**  - successful 
**1-255** : partial/not successful 
**1** - input errors
**2** - command error
**126** - permission denied error
**127** - command not found
**128** + n kill signals
**n** : kill signal number
? Is a variable
We access variables in the shell with dollar $?

## Pipes
Allows us to combine 2 commands
```com1 | com2```
Com1 standard output is converted to standard input to com2
```com1 > out && com2 < out``` same as ```com1 | com1```
```Cat /etc/passwd | grep root``` same as  ```cat /etc/passwd >out, grep root < out```

## Communication 
```
mail -s hell username@localhost
mail :  command to check mail
```
```wall :``` command is used to send a msg to all users not to a single user.
```wall ‘good morning to everyone’```
```mutt``` command is used to send a mail along with an attachment.

## Quotes
We have to disable the speciality of
**special characters**

Backslash
Single quotes
Double quotes

```example: echo * and echo /*```

**Note:** in single quotes all characters treated as normal characters

```echo ‘* * *’```

##### command quotes ``
**Double quotes allow us to use**
``$``` : access variables (\$)
```
echo hello \$USER
```
``` ` ```: Execute commands (\`)
``` echo `date` ```

This above 2 characters treated as special in double quotes remaining all are treated as normal.

we can combine double and single quotes any way we can use.

Text filters 
Line based
head
tail & tail -f (-f whatever the updates happening in that file)
Row
syntax: grep word file
Example: grep root /etc/passwd
Multiple words from single file
grep -e root -e adm /etc/passwd
grep -E ‘root|adm’ /etc/passwd
if more than 256 characters grep will not work. So we have another option -f
syntax: grep -f filename /etc/passwd
grep root /etc/group /etc/passwd
grep goes with case sensitivity 
Case insensitivity we use ‘-i’
sort command
to order the things
-r : reverse 
-n : number 
sort -n | unique : unique things we will get
sort -n | uniq -d : duplicates
wc command 
Denoting 
^ - usually a line starts with cap symbol
$ - a line ends with dollar
^$ is a empty line
grep -v root /etc/passwd
Cat passed | grep -v ‘^$’

Column
Cut -f
cut -f1,2
cut -f1-4
cut -f 1 -d : here we are overriding the default tab space delimiter with :
echo helloworld | cut -c 1-5
There is a limitation for cut command we can only use this for tab space
xrags : helps us in converting coloums to rows and rows to coloums
echo “1\t2\t3\t4”| xargs 
echo “1\t2\t3\t4”| xargs | xargs -n1
xargs it takes the input from one command and provide it as a normal input to another command

Awk command
syntax : awk ‘{print $1} filename
in AWS
default delimiter 
single space
Multispace
tab space 
awk ‘/root/ { print }’ passwd
We a can search a word with awk in /wordname/
awk - F : ‘{print $1,$NF}’ FILENAME
SED 
sed options { sed-commnds} input file
sed options -f sed-cmd-file input-file
sed -e ‘commd1’ -e ‘comand2’ … file : we will get output
sed -i -e ‘com1’ file : we will not get output
p - print
d - delete
s - substitute 
a - append
i - insert
c - change
sed ‘p’ /etc/passwd : it prints sed workspace and print in 2 times so we don't need 2 times so we have to use - n option
sed -n ‘p’ /etc/passwd
sed -n ‘/root/ p’ /etc/passwd
sed -n ‘2 p’ /etc/passd : prints 2nd line
‘2,$’ second line to end of the file
‘1~2’ : alternate lines 
‘1,3’ : first and 
sed -n ‘/root/,/satish/ p’ /etc/passwd 
sed -n ‘/root/,+2 p’ /etc/passwd 
sed ‘/root/,4 d’ /etc/passwd
sed ‘/^$/, d’ /etc/passwd 
substitute 
sed ‘s/Manager/director’ /etc/password 
sed ‘/root/s/admin/’ /etc/passwd
sed - e ‘9 s/admin//’ filename
echo apple ant animal | sed -e ‘s/a/A/g’ 
Change 1st possibility replace g with 1 second possiblity 2 etc
by default sed enables case-sensitive
sed ‘/s/Root/ROOT/I' /etc/passwd
Append
Add new lines to file
sed ‘/root/a content’ filename
sed ‘2 a content' filename
sed ‘/$ i content’ filename
change
sed ‘2 c content’ filename
Above command change the 2nd line with custom content
Variables
If we assign a name to a set of data then it is called as a variable
syntax: Name=Data
Ex: NoOfOranges=10
NoOfApples=5
Data
Single character 
Single word
Single line
Multiple lines
No data types
Input is considered as string 
Special characters “” or ‘’
No data limitation
Name=data
Access a variable $varname
unset variablename

Properties of a variable
Readwrite : variable has a over writable property 
Readonly
readonly var-name
readonly var-name=data
Local 
export var-name
export var-name=data
. is a command to import from parent to child
. is shell build in command and shell built in command will not have any process
To check shell built in commands use enable to see
Scalar
How to store multiple values in a variables
Arrays
To store multiple values in a single variable arrays
Happens through index number
Student [0] = ramu
echo ${student[0]}
echo ${student[*]} or @ in *
echo ${#student[@]}
#! /bin/bash

Student = (Ramu Raju Krishna hari)

echo ‘${student[0]} =’ ${student[1]}

echo ‘${student[*]:2:3} =’ ${student[*]:2:3}
Cal

To get range of values then the syntax is
${student[*]:x:y}
X - Starting index from where you need the values
Y - Number of values from X index
echo name or echo ${name[0]}
Define the variable in 2 ways
Command substitution
Var = $(commands)
Var = `command`
Arithmetic substitution 
Var=$(( arth eq))
ADD=$((1+2))
echo $ADD
Special variables for inputs
$0 to $n, $* and $#
$0 means script name 
1,2, 3 … n means first, second, third till n arguments 
$* all arguments 
$# : Number of arguments


Functions
Name to set of commands 
syntax: FName ()
{
Commands
Commands
}
To access a function: FName
Binary file (bin, sbin)
Shell built in commands
Functions
Alias
Function is also a type of semi-command
We will not get any process I'd for functions alias or shell built in commands
Properties 
RW 
readonly -f functionname
export -f funcname
Local 
export -f funcname
.script
unset -f funcname
function is also have an exit status command
return
Similar to exit status in linux 
We have special variables for functions as well 
example:
print_fun () {
echo $1
echo $2
echo $*
echo $#
}

print_fun abc xyz

Conditions
Simple if 
Syntax: 

if [exp] ; then 
Commands 
fi

if-else

if [exp] ; then
Commands
else 
Commands
fi
elseif

if [exp1] ; then
commands 
elif [exp2]; then 
Commands
elif [exp3] ; then
Commands
else 
Commands
fi

Expressions

Number ( -eq, -nr, -le, -lt, -gt, -get)
String (==, !=, -z)
file -e or -f

Loops 
Same thing again and again we use loops
while
While loop works on expression 
example
a=10
while [ $a -gt 1] ; do
echo a is greater than 1
a=$(($a-1))
done
for 
works on inputs
Example 

for number in 1 2 3 4 5 ; do
echo number 
done
