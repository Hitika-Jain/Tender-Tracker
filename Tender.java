package tender;

import java.math.BigDecimal;

public class Tender {
    private int tenderId;
    private String tenderName;
    private String tenderType;
    private BigDecimal tenderPrice;
    private String tenderDescription;
    private String tenderDeadline;
    private String tenderLocation;

    // Getters and Setters
    public int getTenderId() {
        return tenderId;
    }

    public void setTenderId(int tenderId) {
        this.tenderId = tenderId;
    }

    public String getTenderName() {
        return tenderName;
    }

    public void setTenderName(String tenderName) {
        this.tenderName = tenderName;
    }

    public String getTenderType() {
        return tenderType;
    }

    public void setTenderType(String tenderType) {
        this.tenderType = tenderType;
    }

    public BigDecimal getTenderPrice() {
        return tenderPrice;
    }

    public void setTenderPrice(BigDecimal tenderPrice) {
        this.tenderPrice = tenderPrice;
    }

    public String getTenderDescription() {
        return tenderDescription;
    }

    public void setTenderDescription(String tenderDescription) {
        this.tenderDescription = tenderDescription;
    }

    public String getTenderDeadline() {
        return tenderDeadline;
    }

    public void setTenderDeadline(String tenderDeadline) {
        this.tenderDeadline = tenderDeadline;
    }

    public String getTenderLocation() {
        return tenderLocation;
    }

    public void setTenderLocation(String tenderLocation) {
        this.tenderLocation = tenderLocation;
    }
}
