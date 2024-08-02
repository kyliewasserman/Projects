package FinalProject;

import java.util.*;

// class where they are actually matched
public class Solve {
    private Partition partition;
    private Map<Resident, List<Hospital>> residentsPreferences;
    private Map<Hospital, List<Resident>> hospitalsPreferences;

    public Solve() {

    }

    public Solve(Set<Resident> residents, Set<Hospital> hospitals, Map<Resident, List<Hospital>> residentsPreferences, Map<Hospital, List<Resident>> hospitalsPreferences) {
        partition = new Partition(residents, hospitals);
        this.residentsPreferences = residentsPreferences;
        this.hospitalsPreferences = hospitalsPreferences;
    }

    public Partition getPartition() {
        return partition;
    }

    public void setPartition(Partition partition) {
        this.partition = partition;
    }

    public Map<Resident, List<Hospital>> getResidentsPreferences() {
        return residentsPreferences;
    }

    public void setResidentsPreferences(Map<Resident, List<Hospital>> residentsPreferences) {
        this.residentsPreferences = residentsPreferences;
    }

    public Map<Hospital, List<Resident>> getHospitalsPreferences() {
        return hospitalsPreferences;
    }

    public void setHospitalsPreferences(Map<Hospital, List<Resident>> hospitalsPreferences) {
        this.hospitalsPreferences = hospitalsPreferences;
    }

    // method where they are actually matched
    public Matching solve() {

        // empty match that you will add to
        Matching finalMatching = new Matching();

        // get the sets
        Set<Hospital> hospitalSet = new HashSet<>(partition.getHospitalSet());
        Set<Resident> residentSet = new HashSet<>(partition.getResidentSet());

        //the max number of preferred residents from all hospitals sets
        int maxNumberOfResidentsPreferences = partition.getHospitalSet().stream().mapToInt(hospital -> hospitalsPreferences.get(hospital).size()).max().getAsInt();
        
        int indexInResidentSet = 0;
        int lengthOfResidentSet = residentSet.size();

        while (indexInResidentSet <= maxNumberOfResidentsPreferences && lengthOfResidentSet > 0) {

            // do this for every hospital
            for (Hospital hospital : hospitalSet) {
                if (hospital.getCapacity() > 0 && indexInResidentSet < hospitalsPreferences.get(hospital).size()) {

                    // the first preference
                    Resident hospitalPref = hospitalsPreferences.get(hospital).get(indexInResidentSet);

                    // if it is available
                    if (residentsPreferences.get(hospitalPref).contains(hospital) && residentSet.contains(hospitalPref)) {
                        finalMatching.addPair(hospitalPref, hospital);
                        residentSet.remove(hospitalPref);
                        hospital.setCapacity(hospital.getCapacity() - 1);
                        lengthOfResidentSet--;
                    }
                }
            }
            indexInResidentSet++;
        }
        return finalMatching;
    }
}
