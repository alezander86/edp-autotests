package edp.stepdefs.cubernetes;

import edp.steps.CodebaseImageStreamSteps;
import io.cucumber.java.en.And;
import org.springframework.beans.factory.annotation.Autowired;

public class CodebaseImageStreamDefinitionSteps {

    @Autowired
    private CodebaseImageStreamSteps codebaseImageStream;

    @And("User checks {string} codebase image stream {string} tag")
    public void checkCodebaseImageStreamTag(final String imageStream, final String imageStreamTag) {
        codebaseImageStream.checkCodebaseImageStreamFirstTag(imageStream, imageStreamTag);
    }

    @And("User checks {string} codebase image stream {string} second tag")
    public void checkCodebaseImageStreamSecondTag(final String imageStream, final String imageStreamTag) {
        codebaseImageStream.checkCodebaseImageStreamSecondTag(imageStream, imageStreamTag);
    }

    @And("User checks promoted image for {word} application for {word} stage {word} pipeline")
    public void checkCodebaseImageStreamSecondTag(final String applicationName, final String stageName,
                                                  final String pipelineName) {
        codebaseImageStream.checkCodebaseImageStreamPromotedImage(applicationName, stageName, pipelineName);
    }

    @And("User deletes {string} image stream")
    public void deleteImageStream(final String inputDockerStream) {
        codebaseImageStream.deleteImageStream(inputDockerStream);
    }

}
