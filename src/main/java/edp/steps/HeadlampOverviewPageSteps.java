package edp.steps;

import static edp.utils.consts.Constants.ICON_RED_SQUARE_BASE64;
import static org.assertj.core.api.Assertions.assertThat;

import edp.core.cache.TestCache;
import edp.core.crd.EDPComponent;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.pageobject.IBrowserTabProcessing;
import edp.pageobject.pages.HeadlampOverviewPage;
import lombok.extern.log4j.Log4j;
import org.assertj.core.api.SoftAssertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class HeadlampOverviewPageSteps {
    @Autowired
    private HeadlampOverviewPage headlampOverviewPage;
    @Autowired
    private KubernetesClientFactory factory;

    public void checkAddedLinkOnOverviewScreen() {
        String linkName = TestCache.get(TestCacheKey.LINK_NAME, String.class);
        String linkUrl = TestCache.get(TestCacheKey.LINK_URL, String.class);
        headlampOverviewPage.isIconContainsEnteredSVGInBase64(linkUrl, ICON_RED_SQUARE_BASE64);
        headlampOverviewPage.clickOnTheLinkWithURL(linkUrl);
        IBrowserTabProcessing.switchToNewTab();
        assertThat(IBrowserTabProcessing.getPageUrl()).contains(linkUrl);
        EDPComponent edpComponent = factory.getCustomResource(EDPComponent.class, linkName).get();
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(edpComponent.getSpec().getIcon()).isEqualTo(ICON_RED_SQUARE_BASE64);
        softAssertions.assertThat(edpComponent.getSpec().getType()).isEqualTo(linkName);
        softAssertions.assertThat(edpComponent.getSpec().getUrl()).isEqualTo(linkUrl);
        softAssertions.assertAll();
    }
}
