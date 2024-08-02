package FinalProject;

import java.util.*;

// class where they are actually matched
public class SolveV2 {
    private Partition partition;
    private Map<Resident, List<Hospital>> residentsPreferences;

    public SolveV2() {

    }

    public SolveV2(Set<Resident> residents, Set<Hospital> hospitals, Map<Resident, List<Hospital>> residentsPreferences) {
        partition = new Partition(residents, hospitals);
        this.residentsPreferences = residentsPreferences;
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

    // method where they are actually matched
    public Matching solve() {

        // empty match that you will add to
        Matching finalMatching = new Matching();

        // get the sets
        Set<Hospital> hospitalSet = new HashSet<>(partition.getHospitalSet());
        Set<Resident> residentSet = new HashSet<>(partition.getResidentSet());

        int indexInResidentSet = 0;

        // for each resident if the first hospital in thier list is available, make that match
        for( Resident res : residentSet){
            Hospital reChoice = residentsPreferences.get(res).get(indexInResidentSet);
            if (reChoice.getCapacity() != 0){
                finalMatching.addPair(res, reChoice);
                reChoice.setCapacity(reChoice.getCapacity() - 1);

            }
        }
        indexInResidentSet++;
        
        return finalMatching;
    }

}
