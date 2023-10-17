package edp.pageobject.pages;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Selenide;
import edp.core.annotations.Page;
import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class HeadlampOverviewPage {

    private static final String CREATED_LINK_ICON_BUTTON = "//a[@href='%s']";
    private static final String CREATED_LINK_ICON_IMG = CREATED_LINK_ICON_BUTTON + "//img";

    public void isIconContainsEnteredSVGInBase64(String linkUrl, String iconInBase64) {
        $x(String.format(CREATED_LINK_ICON_IMG, linkUrl)).shouldBe(Condition.visible)
                .shouldHave(Condition.attributeMatching("src", ".*" + iconInBase64 + ".*"));
    }

    public void clickOnTheLinkWithURL(String linkUrl) {
        $x(String.format(CREATED_LINK_ICON_BUTTON, linkUrl)).hover();
        Selenide.sleep(500);
        $x(String.format(CREATED_LINK_ICON_BUTTON, "https://" + linkUrl)).shouldBe(Condition.visible).click();
    }
}
