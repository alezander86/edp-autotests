package edp.pageobject.pages;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import edp.core.annotations.Page;
import lombok.extern.log4j.Log4j;
import org.openqa.selenium.Keys;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class HeadlampMarketplacePage {

    private static final String TABLE_VIEW_BUTTON = "//button[@aria-label='Show filter']/../following-sibling::div/div/div[1]";
    private static final String CUBE_VIEW_BUTTON = "//button[@aria-label='Show filter']/../following-sibling::div/div/div[2]";
    private static final String OPEN_SEARCH_FIELD_BUTTON = "//button[@aria-label='Show filter']";
    private static final String SEARCH_FILTER_FIELD = "//input[@id='standard-search']";
    private static final String FIRST_TABLE_ROW = "//table[contains(@class,'MuiTable-root')]/tbody/tr[1]";
    private static final String TEMPLATE_NAME_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[2]");
    private static final String TEMPLATE_NAME_CUBE = "//h6[text()='%s']";
    private static final String CREATE_FROM_TEMPLATE_BUTTON = "//span[text()='create from template']";

    public void clickOnTableViewModeButton() {
        $x(TABLE_VIEW_BUTTON).shouldBe(Condition.visible).click();
    }
    public void clickOnCubeViewModeButton() {
        $x(CUBE_VIEW_BUTTON).shouldBe(Condition.visible).click();
    }
    public void searchTemplateByName(String templateName) {
        $x(OPEN_SEARCH_FIELD_BUTTON).shouldBe(Condition.visible).click();
        $x(SEARCH_FILTER_FIELD).shouldBe(Condition.visible).sendKeys(Keys.CONTROL + "A");
        $x(SEARCH_FILTER_FIELD).shouldBe(Condition.visible).sendKeys(Keys.BACK_SPACE);
        $x(SEARCH_FILTER_FIELD).shouldBe(Condition.visible).sendKeys(templateName);
    }

    public void clickOnTemplateNameInTheFirstRow() {
        $x(TEMPLATE_NAME_FIRST_ROW).shouldBe(Condition.visible).click();
    }

    public void clickOnTemplateByNameOnTheFirstCube(String templateName) {
        $x(String.format(TEMPLATE_NAME_CUBE, templateName)).shouldBe(Condition.visible).click();
    }

    public void clickOnCreateFromTemplateButton() {
        $x(CREATE_FROM_TEMPLATE_BUTTON).shouldBe(Condition.visible).click();
    }

}
