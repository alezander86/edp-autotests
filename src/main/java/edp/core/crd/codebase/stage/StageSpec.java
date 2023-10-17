package edp.core.crd.codebase.stage;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class StageSpec {

    private String cdPipeline;

    private String description;

    private String jobProvisioning;

    private String name;

    private Integer order;

    private QualityGates[] qualityGates;

    private Source source;

    private String triggerType;

    public void setQualityGateManual(String autotestName, String branchName,String qualityGateType, String stepName) {
        QualityGates qualitygate = new QualityGates();
        qualitygate.setQualityGateType(qualityGateType);
        qualitygate.setStepName(stepName);
        qualitygate.setAutotestName(autotestName);
        qualitygate.setBranchName(branchName);
        this.qualityGates = new QualityGates[]{qualitygate};

    }

    public void setQualityGateAuto(String autotestName, String branchName, String qualityGateType, String stepName) {
        QualityGates qualitygate = new QualityGates();
        qualitygate.setAutotestName(autotestName);
        qualitygate.setBranchName(branchName);
        qualitygate.setQualityGateType(qualityGateType);
        qualitygate.setStepName(stepName);
        this.qualityGates = new QualityGates[]{qualitygate};
    }

    public void setSourceType(String type) {
        this.source = new Source();
        this.source.setType(type);
    }

}

@Data
class QualityGates {
    String autotestName;
    String branchName;
    String qualityGateType;
    String stepName;
}

@Data
class Source {
    Object library;
    String type;
}