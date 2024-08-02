package FinalProject;

import java.util.Objects;

// class for all of the residents
// keeps track of the names of each resident

public class Resident implements Comparable<Resident>, Element {
    private String name;

    public Resident() {
    }

    public Resident(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    @Override
    public int compareTo(Resident resident) {
        return this.getName().compareTo(resident.getName());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Resident resident = (Resident) o;
        return Objects.equals(name, resident.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }
}
