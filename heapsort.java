package tender;

import java.util.List;
import java.util.Collections;

public class heapsort {
    public static void sortByAmount(List<bids> bids) {
        bids.sort((b1, b2) -> b1.getBidAmount().compareTo(b2.getBidAmount()));
    }

    public static void sortByDate(List<bids> bids) {
        bids.sort((b1, b2) -> b1.getSubmissionDate().compareTo(b2.getSubmissionDate()));
    }
}