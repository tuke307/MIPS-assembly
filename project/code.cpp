#include <iostream>
#include <math.h>

using namespace std;

// Function for Selection sort
void selectionSort(float arr[], int size)
{
   // Move boundary of unsorted subarray one by one
   for (int i = 0; i < size - 1; i++)
   {
      printf("i = %d\n", i);

      // Find the minimum element in unsorted array
      int min_idx = i;
      for (int j = i + 1; j < size; j++)
      {
         printf("j = %d\n", j);
         if (arr[j] < arr[min_idx]){
            min_idx = j;
            printf("min_idx = %d\n", min_idx);
         }
      }
      // Swap the found minimum element
      if (min_idx != i)
      {
         float tmp = arr[min_idx];
         arr[min_idx] = arr[i];
         arr[i] = tmp;
         //print i
      }
   }
}

// Print an array
void printArray(float arr[], int size)
{
   cout << "Array: \n";
   int i;
   for (i = 0; i < size; i++)
   {
      cout << arr[i] << " ";
   }
   cout << endl;
}

// Fill the array
void fillArray(float arr[], int size)
{
   arr[0] = +0.0;
   arr[1] = -1.0;
   for (int i = 2; i < size; i++)
   {
      arr[i] = (arr[i - 1] + arr[i - 2]) * pow(-1, i) / 2.0;
   }
}

// Main
int main()
{
   int size;
   cout << "Enter the number of elements <size>." << endl;
   cin >> size;
   float arr[size];
   fillArray(arr, size);
   printArray(arr, size);
   selectionSort(arr, size);
   printArray(arr, size);
   return 0;
}