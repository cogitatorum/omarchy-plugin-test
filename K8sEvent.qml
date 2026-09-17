import QtQml

QtObject {
    id: root

    property string kind: ""
    property string apiVersion: ""
    property string reason: ""
    property string message: ""
    property string firstTimestamp: ""
    property string lastTimestamp: ""
    property int count: 0
    property string type: ""
    property var eventTime: null
    property string reportingComponent: ""
    property string reportingInstance: ""
    property QtObject metadata
    property QtObject involvedObject
    property QtObject source

    signal loaded()

    function fromJson(obj) {
        if (!obj)
            return ;

        kind = obj.kind ?? "";
        apiVersion = obj.apiVersion ?? "";
        reason = obj.reason ?? "";
        message = obj.message ?? "";
        firstTimestamp = obj.firstTimestamp ?? "";
        lastTimestamp = obj.lastTimestamp ?? "";
        count = obj.count ?? 0;
        type = obj.type ?? "";
        eventTime = obj.eventTime ?? null;
        reportingComponent = obj.reportingComponent ?? "";
        reportingInstance = obj.reportingInstance ?? "";
        metadata.fromJson(obj.metadata);
        involvedObject.fromJson(obj.involvedObject);
        source.fromJson(obj.source);
        loaded();
    }

    metadata: QtObject {
        property string name: ""
        property string namespace: ""
        property string uid: ""
        property string resourceVersion: ""
        property string creationTimestamp: ""

        function fromJson(obj) {
            if (!obj)
                return ;

            name = obj.name ?? "";
            namespace = obj.namespace ?? "";
            uid = obj.uid ?? "";
            resourceVersion = obj.resourceVersion ?? "";
            creationTimestamp = obj.creationTimestamp ?? "";
        }

    }

    involvedObject: QtObject {
        property string kind: ""
        property string namespace: ""
        property string name: ""
        property string uid: ""
        property string apiVersion: ""
        property string resourceVersion: ""

        function fromJson(obj) {
            if (!obj)
                return ;

            kind = obj.kind ?? "";
            namespace = obj.namespace ?? "";
            name = obj.name ?? "";
            uid = obj.uid ?? "";
            apiVersion = obj.apiVersion ?? "";
            resourceVersion = obj.resourceVersion ?? "";
        }

    }

    source: QtObject {
        property string component: ""
        property string host: ""

        function fromJson(obj) {
            if (!obj)
                return ;

            component = obj.component ?? "";
            host = obj.host ?? "";
        }

    }

}
