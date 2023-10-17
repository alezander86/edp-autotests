package edp.core.service.openshift;

import edp.core.config.TestsConfig;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class RoutesProvider {
    @Autowired
    private OpenshiftClientFactory openshiftClientFactory;
    @Autowired
    private TestsConfig testsConfig;

    public String getRouteHostByName(String routName) {
        return openshiftClientFactory.getOpenshiftTargetClient()
                .routes()
                .inNamespace(testsConfig.getNamespace())
                .list().getItems()
                .stream().filter(r -> r.getMetadata().getName().equals(routName))
                .findFirst()
                .get().getSpec().getHost();
    }
}
