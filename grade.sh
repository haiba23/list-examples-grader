CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
files=$(find student-submission -name "ListExamples.java")

for file in $files
do
    expected=$(cat $file) 

    if [[ -f $file ]]
    
    then
        echo "$file is a file!"
    else
        echo "$file failed -f"
    fi

    if [[ -e $file ]]
    
    then
        echo "$file exists!"
    else
        echo "$file failed -e"
    fi
done

cp -r $files grading-area #puts the stuff in student to grading
cp GradeServer.java grading-area
cp Server.java grading-area
cp TestListExamples.java grading-area


if [ $? -ne 0 ]; then
    echo "Tests compilation failed."

else
    echo "Good job"
fi



javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > test-output.txt

if grep -q "Failures" test-output.txt; 
then
  echo "Tests failed. Please review the output in test-output.txt."
else
  echo "All tests passed. Congratulations!"
fi