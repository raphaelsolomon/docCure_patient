// To parse this JSON data, do
//
//     final AgoraRegUser = AgoraRegUserFromJson(jsonString);

import 'dart:convert';

AgoraRegUser AgoraRegUserFromJson(String str) => AgoraRegUser.fromJson(json.decode(str));

String AgoraRegUserToJson(AgoraRegUser data) => json.encode(data.toJson());

class AgoraRegUser {
    String path;
    String uri;
    int timestamp;
    String organization;
    String application;
    List<Entity> entities;
    String action;
    List<dynamic> data;
    int duration;
    String applicationName;

    AgoraRegUser({
        required this.path,
        required this.uri,
        required this.timestamp,
        required this.organization,
        required this.application,
        required this.entities,
        required this.action,
        required this.data,
        required this.duration,
        required this.applicationName,
    });

    factory AgoraRegUser.fromJson(Map<String, dynamic> json) => AgoraRegUser(
        path: json["path"],
        uri: json["uri"],
        timestamp: json["timestamp"],
        organization: json["organization"],
        application: json["application"],
        entities: List<Entity>.from(json["entities"].map((x) => Entity.fromJson(x))),
        action: json["action"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        duration: json["duration"],
        applicationName: json["applicationName"],
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "uri": uri,
        "timestamp": timestamp,
        "organization": organization,
        "application": application,
        "entities": List<dynamic>.from(entities.map((x) => x.toJson())),
        "action": action,
        "data": List<dynamic>.from(data.map((x) => x)),
        "duration": duration,
        "applicationName": applicationName,
    };
}

class Entity {
    String uuid;
    String type;
    int created;
    int modified;
    String username;
    bool activated;
    String nickname;

    Entity({
        required this.uuid,
        required this.type,
        required this.created,
        required this.modified,
        required this.username,
        required this.activated,
        required this.nickname,
    });

    factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        uuid: json["uuid"],
        type: json["type"],
        created: json["created"],
        modified: json["modified"],
        username: json["username"],
        activated: json["activated"],
        nickname: json["nickname"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "type": type,
        "created": created,
        "modified": modified,
        "username": username,
        "activated": activated,
        "nickname": nickname,
    };
}
