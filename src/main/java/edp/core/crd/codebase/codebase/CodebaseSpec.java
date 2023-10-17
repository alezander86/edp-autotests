package edp.core.crd.codebase.codebase;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import edp.core.enums.testdata.CodeLanguage;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CodebaseSpec {

    private String lang;
    private String framework;
    private String buildTool;
    private String strategy;
    private Repository repository;
    private String testReportFramework;
    private String type;
    private String gitServer;
    private String gitUrlPath;
    private String jenkinsSlave;
    private String jobProvisioning;
    private String deploymentScript;
    private Versioning versioning;
    private String jiraServer;
    private String commitMessagePattern;
    private String ticketNamePattern;
    private String ciTool;
    private String defaultBranch;
    private String jiraIssueMetadataPayload;
    private boolean emptyProject;

    public void setVersioningType(String type, String startFrom) {
        this.versioning = new Versioning();
        this.versioning.setType(type);
        this.versioning.setStartFrom(startFrom);
    }

    public void setRepositoryUrl(String url) {
        this.repository = new Repository();
        this.repository.setUrl(url);
    }

    public String getStartFrom() {
        return this.versioning.startFrom;
    }

    public void setCodeLanguage(CodeLanguage codeLanguage) {
        setLang(codeLanguage.getLanguage());
        setFramework(codeLanguage.getVersion());
        setBuildTool(codeLanguage.getBuildTool());
        if (this.ciTool.equalsIgnoreCase("jenkins")) {
            setJenkinsSlave(codeLanguage.getJenkinsSlave());
        }
    }
}

@Data
class Repository {
    String url;
}

@Data
class Versioning {
    String type;
    String startFrom;
}
