import java.util.ArrayList;

class AccessElementsFromArrayList {
  public static void main(String[] args) {
    ArrayList<String> animals = new ArrayList<>();

    // add elements in the arraylist
    animals.add("Cat");
    animals.add("Dog");
    animals.add("Cow");
    System.out.println("ArrayList: " + animals);

    // get the element from the arraylist
    int index=2;
    String str = animals.get(index);

    System.out.print("Element at index " + index+": "+str);
  }
}