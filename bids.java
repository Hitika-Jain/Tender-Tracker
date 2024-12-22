package tender;
import java.math.BigDecimal;
import java.sql.Date;
public class bids {

    private int bidId, vendorId, tenderId;
    private BigDecimal bidAmount;
    private String bidProposal, bidStatus;
    private Date submissionDate;

    public bids(int bidId, int vendorId, int tenderId, BigDecimal bidAmount, String proposal, Date date, String status) {
        this.bidId = bidId;
        this.vendorId = vendorId;
        this.tenderId = tenderId;
        this.bidAmount = bidAmount;
        this.bidProposal = proposal;
        this.submissionDate = date;
        this.bidStatus = status;
    }
    // Getters and Setters
    public int getBidId() {
        return bidId;
    }

    public void setBidId(int bidId) {
        this.bidId = bidId;
    }

    public int getVendorId() {
        return vendorId;
    }

    public void setVendorId(int vendorId) {
        this.vendorId = vendorId;
    }

    public int getTenderId() {
        return tenderId;
    }

    public void setTenderId(int tenderId) {
        this.tenderId = tenderId;
    }

    public BigDecimal getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(BigDecimal bidAmount) {
        this.bidAmount = bidAmount;
    }

    public String getBidProposal() {
        return bidProposal;
    }

    public void setBidProposal(String bidProposal) {
        this.bidProposal = bidProposal;
    }

    public Date getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(Date submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getBidStatus() {
        return bidStatus;
    }

    public void setBidStatus(String bidStatus) {
        this.bidStatus = bidStatus;
    }
}
