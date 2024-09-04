// Java Program to implement
// One-Dimensional Array

// Driver Class
public class ArrayExample {
      // Main Function
    public static void main(String[] args)
    {
        // Declare and initialize an array of integers
        int[] numbers = { 10, 20, 30, 40, 50 };

        // Print the elements of the array
        System.out.println("Original Array:");
        printArray(numbers);

        // Accessing elements of the array
        System.out.println("\nElement at index 2: " + numbers[2]); 
          // Output: 30

        // Modifying an element of the array
        numbers[3] = 45;

        // Print the modified array
        System.out.println("\nModified Array:");
        printArray(numbers);

        // Calculating the sum of elements in the array
        int sum = calculateSum(numbers);
        System.out.println("\nSum of elements in the array: " + sum);
          // Output: 145
    }

    // Method to print the elements of an array
    public static void printArray(int[] arr)
    {
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    // Method to calculate the sum of elements in an array
    public static int calculateSum(int[] arr)
    {
        int sum = 0;
        for (int num : arr) {
            sum += num;
        }
        return sum;
    }
}
