#!/bin/bash

COUNTER_SUCCESS=0
COUNTER_FAIL=0
DIFF_RES=""
TEST_FILE="main_test.txt"

for var in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
do
          TEST="$var $TEST_FILE"
          echo "$TEST"
          ./s21_cat $TEST > s21_cat.txt
          cat $TEST > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
          if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
            then
              echo "$TEST" >> log_success.txt
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST" >> log_fail.txt
              (( COUNTER_FAIL++ ))
          fi
          rm s21_cat.txt cat.txt
done

for var in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
  do
        if [ $var != $var2 ]
        then
          TEST="$var $var2 $TEST_FILE"
          echo "$TEST"
          ./s21_cat $TEST > s21_cat.txt
          cat $TEST > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
          if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
            then
              echo "$TEST" >> log_success.txt
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST" >> log_fail.txt
              (( COUNTER_FAIL++ ))
          fi
          rm s21_cat.txt cat.txt
        fi
  done
done

for var in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
  do
      for var3 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
        if [ $var != $var2 ] && [ $var2 != $var3 ] && [ $var != $var3 ]
        then
          TEST="$var $var2 $var3 $TEST_FILE"
          echo "$TEST"
          ./s21_cat $TEST > s21_cat.txt
          cat $TEST > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
          if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
            then
              echo "$TEST" >> log_success.txt
              (( COUNTER_SUCCESS++ ))
            else
              echo "$TEST" >> log_fail.txt
              (( COUNTER_FAIL++ ))
          fi
          rm s21_cat.txt cat.txt

        fi
      done
  done
done

for var in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
  do
      for var3 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
          for var4 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
          do
            if [ $var != $var2 ] && [ $var2 != $var3 ] && [ $var != $var3 ] && [ $var != $var4 ] && [ $var2 != $var4 ] && [ $var3 != $var4 ]
            then
              TEST="$var $var2 $var3 $var4 $TEST_FILE"
              echo "$TEST"
              ./s21_cat $TEST > s21_cat.txt
              cat $TEST > cat.txt
              DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
              if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
                then
                  echo "$TEST" >> log_success.txt
                  (( COUNTER_SUCCESS++ ))
                else
                  echo "$TEST" >> log_fail.txt
                  (( COUNTER_FAIL++ ))
              fi
              rm s21_cat.txt cat.txt

            fi
          done
      done
  done
done

echo "SUCCESS: $COUNTER_SUCCESS"
echo "FAIL: $COUNTER_FAIL"

if [[ $COUNTER_FAIL > $COUNTER_SUCCESS  ]]
then
	echo "test failed"
	exit 1
else
  [[ $COUNTER_FAIL < $COUNTER_SUCCESS ]]
	echo "test passed"
	exit 0
fi
