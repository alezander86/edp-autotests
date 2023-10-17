package edp.utils;

import edp.core.crd.EDPComponent;
import io.fabric8.kubernetes.api.model.networking.v1.Ingress;
import io.fabric8.kubernetes.client.CustomResource;

import java.util.List;

public class CustomResourceUtils {
    public static <T extends CustomResource> T getCustomResourceByName(List<T> list, String name) {
        return list.stream().filter(cr -> cr.getMetadata().getName().equals(name)).findAny().get();
    }

    public static Boolean isCurrentEnvShared(List<EDPComponent> list, String name) {
        return list.stream().noneMatch(cr -> cr.getMetadata().getName().equals(name));
    }

    public static Ingress getIngressByName(List<Ingress> list, String name) {
        return list.stream().filter(i -> name.equals(i.getMetadata().getName())).findAny().get();
    }
}
