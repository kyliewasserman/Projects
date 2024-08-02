package FinalProject;

import java.util.*;

// matching class
public class Matching {
    private Map<Resident, Hospital> matchingList = new HashMap<>();

    public Matching() {
    }

    // once a pair is made, use this function to add it to a list to eventually print
    public void addPair(Resident firstElement, Hospital secondElement) {
        matchingList.put(firstElement, secondElement);
    }

    @Override
    public String toString() {
        return "Matching: " + matchingList ;
    }
}
