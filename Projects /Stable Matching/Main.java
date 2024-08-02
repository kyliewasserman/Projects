package FinalProject;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {

    // items for the parse file method
    public static ArrayList<Integer> allResidents = new ArrayList<Integer>();
    public static ArrayList<Integer> allHospitals = new ArrayList<Integer>();

    public static ArrayList<Integer> resPrefItems = new ArrayList<Integer>();
    public static ArrayList<Integer> hospPrefItems = new ArrayList<Integer>();
    public static ArrayList<ArrayList<Integer>> allResPrefItems = new ArrayList<ArrayList<Integer>>();
    public static ArrayList<ArrayList<Integer>> allHospPrefItems = new ArrayList<ArrayList<Integer>>();

    public static ArrayList<Integer> hospSpots = new ArrayList<Integer>();

    // method to get an integer arraylist from a string arraylist
    private static ArrayList<Integer> getIntegerArray(ArrayList<String> stringArray) {
        ArrayList<Integer> result = new ArrayList<Integer>();
        for(String stringValue : stringArray) {
            try {
                result.add(Integer.parseInt(stringValue));
            } catch(NumberFormatException nfe) {
               
            } 
        }       
        return result;
    }

    // method to parse through the given txt file
    public static void parseFile() throws IOException{
        // load data from file
        BufferedReader in2 = new BufferedReader(new FileReader("HopsRes.txt"));
        String str2;

        // create array list
        List<String> list2 = new ArrayList<String>();

        // add each line to a new item in the arraylist
        while((str2 = in2.readLine()) != null) 
        {
            // make each item lowercase
            str2 = str2.toLowerCase();
            list2.add(str2);
        }

        // close bufferedReader object
        in2.close();

        // storing the data in arraylist to an array
        String[] arrayLines =  list2.toArray(new String[0]);

        // for each line in the file
        for(String line : arrayLines){

            if(!line.equals("")){

                // line for declaring the total number of residents and hospitals
                if(line.charAt(0) == 'c') {

                    String resNumString = line.substring(7,10);
                    String hospNumString = line.substring(10,12);
                    
                    resNumString = resNumString.replaceAll("\\s", "");
                    hospNumString = hospNumString.replaceAll("\\s", "");

                    int resNumInt = Integer.valueOf(resNumString);
                    int hospNumInt = Integer.valueOf(hospNumString);

                }

                // line for a specific resident (with prefered hospital list)
                else if (line.charAt(0) == 'r') {

                    // some are single digit, others are double, remove : for that reason
                    String resIdString = line.substring(0, 3);
                    resIdString = resIdString.replaceAll(":", "");
                    resIdString = resIdString.replaceAll("\\s", "");
                    resIdString = resIdString.replaceAll("r", "");
                    int resIDInt = Integer.parseInt(resIdString);

                    // add the id to the list
                    // -1 bc we are using it for index, which starts at 0, not 1
                    allResidents.add(resIDInt-1);

                    // for preferred hospitals lists
                    int beginIndex = 3;
                    int endIndex = 7;

                    for(int i = 3; i < line.length(); i++){

                        if (line.length() > endIndex){
                            String resPrefItem = line.substring(beginIndex, endIndex);
                            resPrefItem = resPrefItem.replaceAll("\\s", "");
                            resPrefItem = resPrefItem.replaceAll(":", "");
                            resPrefItem = resPrefItem.replaceAll("h", "");

                            int resPrefItemInt = Integer.parseInt(resPrefItem);

                            beginIndex += 3;
                            endIndex += 3;

                            resPrefItems.add(resPrefItemInt-1);
                        }
                        else{
                            break;
                        }
                    }

                    // you know which list goes with which resident by index (they have the same index)
                    allResPrefItems.add(resPrefItems);
                }

                // line for a specific hospital (with prefered resident list and capacity)
                else if (line.charAt(0) == 'h') {

                    // some are single digit, others are double, remove : for that reason
                    String hospIdString = line.substring(0, 2);
                    hospIdString = hospIdString.replaceAll(":", "");
                    hospIdString = hospIdString.replaceAll("h", "");
                    int hospIDInt = Integer.parseInt(hospIdString);

                    // add the id to the list (-1 bc we are using it for the index)
                    allHospitals.add(hospIDInt-1);

                    String hospSpotsLeft = line.substring(4, 5);
                    hospSpotsLeft.replaceAll("\\s", "");
                    hospSpotsLeft.replaceAll(":", "");
                    hospSpotsLeft.replaceAll("-", "");
                    int hospSpotsLeftNum = Integer.parseInt(hospSpotsLeft);

                    hospSpots.add(hospSpotsLeftNum);

                    String hospPrefItemAll = line.substring(8);
                    String[] hospPrefItemArray = hospPrefItemAll.split("\\s+");
                    for(int i = 0; i < hospPrefItemArray.length; i++){
                        hospPrefItemArray[i].replaceAll(" ", "");
                        hospPrefItemArray[i].replaceAll(":", "");
                    }
                    ArrayList<String> hospPrefItemList = new ArrayList<String>();
                    hospPrefItemList.addAll(Arrays.asList(hospPrefItemArray));

                    ArrayList<Integer> hospPrefItemListInt = getIntegerArray(hospPrefItemList);

                    hospPrefItems.addAll(hospPrefItemListInt);

                    // you know which list goes with which hospital by index (they have the same index)
                    allHospPrefItems.add(hospPrefItems);
                }
            }
        }
    }

    // put in all of the hospitals and the preferred list
    public static Map<Hospital, List<Resident>> createMapHospitalsResidents(Hospital[] h, Resident[] r) throws IOException{
        Map<Hospital, List<Resident>> hospitalPref = new TreeMap<>();        

        hospitalPref.put(h[1-1], Arrays.asList(r[3-1], r[7-1], r[9-1], r[11-1], r[5-1], r[4-1], r[10-1], r[8-1], r[6-1], r[1-1], r[2-1]));
        hospitalPref.put(h[2-1], Arrays.asList(r[5-1], r[7-1], r[10-1], r[6-1], r[8-1], r[2-1], r[3-1], r[11-1]));
        hospitalPref.put(h[3-1], Arrays.asList(r[11-1], r[6-1], r[8-1], r[3-1], r[2-1], r[4-1], r[7-1], r[1-1], r[10-1]));
        hospitalPref.put(h[4-1], Arrays.asList(r[10-1], r[1-1], r[2-1], r[11-1], r[4-1], r[9-1], r[5-1], r[3-1], r[6-1], r[8-1]));
        hospitalPref.put(h[5-1], Arrays.asList(r[2-1], r[4-1], r[10-1], r[7-1], r[6-1], r[1-1], r[8-1], r[3-1], r[11-1], r[9-1]));
        return hospitalPref;
    }

    // put in all of the residents and the preferred list
    public static Map<Resident, List<Hospital>> createMapResidentsHospitals(Resident[] r, Hospital[] h) throws IOException{
        Map<Resident, List<Hospital>> residentPref = new HashMap<>();

        residentPref.put(r[1-1], Arrays.asList(h[3-1], h[1-1], h[5-1], h[4-1]));
        residentPref.put(r[2-1], Arrays.asList(h[1-1], h[3-1], h[4-1], h[2-1], h[5-1]));
        residentPref.put(r[3-1], Arrays.asList(h[4-1], h[5-1], h[3-1], h[1-1], h[2-1]));
        residentPref.put(r[4-1], Arrays.asList(h[3-1], h[4-1], h[1-1], h[5-1]));
        residentPref.put(r[5-1], Arrays.asList(h[1-1], h[4-1], h[2-1]));
        residentPref.put(r[6-1], Arrays.asList(h[4-1], h[3-1], h[2-1], h[1-1], h[5-1]));
        residentPref.put(r[7-1], Arrays.asList(h[2-1], h[5-1], h[1-1], h[3-1]));
        residentPref.put(r[8-1], Arrays.asList(h[1-1], h[3-1], h[2-1], h[5-1], h[4-1]));
        residentPref.put(r[9-1], Arrays.asList(h[4-1], h[1-1], h[5-1]));
        residentPref.put(r[10-1], Arrays.asList(h[3-1], h[1-1], h[5-1], h[2-1], h[4-1]));
        residentPref.put(r[11-1], Arrays.asList(h[5-1], h[4-1], h[1-1], h[3-1], h[2-1]));
        return residentPref;
    }

    // queries that display the residents who find acceptable some given hospitals
    public static List<Resident> getPrefResidents(List<Resident> residentList, List<Hospital> prefHospitals, Map<Resident, List<Hospital>> resPrefMap) {
        return residentList.stream().filter(resident -> resPrefMap.get(resident).containsAll(prefHospitals)).collect(Collectors.toList());
    }

    // queries that display the hospitals that have a given resident as their top preference
    public static List<Hospital> getPrefHospitals(Set<Hospital> hospitalList, Map<Hospital, List<Resident>> hospitalsPreferences, Resident preferredResident) {
        return hospitalList.stream().filter(hospital -> hospitalsPreferences.get(hospital).get(0).equals(preferredResident)).collect(Collectors.toList());
    }

    // main method
    public static void main(String[] args) throws IOException{

        // call the parse method
        parseFile();

        // set all the residents
        Resident[] residents = IntStream.rangeClosed(0, 10).mapToObj(i -> new Resident("R" + i)).toArray(Resident[]::new);

        // print the residents
        System.out.print("Residents (by index (so -1 to all)):");
        for (Resident resident : residents) {
            if (!resident.equals(residents[residents.length - 1])) {
                System.out.print(resident + ", ");
            } else {
                System.out.println(resident);
            }

        }

        // set all of the hospitals
        Hospital[] hospitals = IntStream.rangeClosed(0, 4).mapToObj(i -> new Hospital("H" + i)).toArray(Hospital[]::new);

        // set the capacity of the hospitals with parsing the file
        for(int i = 0; i < allHospitals.size(); i++){
            hospitals[i].setCapacity(hospSpots.get(i));
        }

        // print the hospitals
        System.out.print("Hospitals (by index (so -1 to all)): ");
        for (Hospital hospital : hospitals) {
            if (!hospital.equals(hospitals[hospitals.length - 1])) {
                System.out.print(hospital + ", ");
            } else {
                System.out.println(hospital);
            }

        }
        System.out.println();

        // create a list of residents
        List<Resident> residentsList = new ArrayList<>(Arrays.asList(residents));

        // sort the residents using a comparator
        residentsList.sort(Comparator.comparing(Resident::getName));

        // create a set of hospitals
        Set<Hospital> hospitalsList = new TreeSet<>(Arrays.asList(hospitals));

        // create a map of hospital prefereneces 
        Map<Hospital, List<Resident>> hospitalPreferences = createMapHospitalsResidents(hospitals, residents);

        // create a map of resident prefereneces 
        Map<Resident, List<Hospital>> residentPreferences = createMapResidentsHospitals(residents, hospitals);

        Solve problem = new Solve(new HashSet<>(residentsList), hospitalsList, residentPreferences, hospitalPreferences);
        Matching matching = problem.solve();
        System.out.println(matching);
    }
}
