import 'package:dio/dio.dart';
import 'package:raw_chem/common/http/api_consumer.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/features/chat/domain/model/chat_model.dart';
import 'package:raw_chem/features/chat/domain/model/firebase_chat_config.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
import 'package:raw_chem/common/model/pagination_model.dart';

abstract class ChatApiDataSource {
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId);
  Future<Either<Failure, FirebaseChatConfig>> getFirebaseToken(int purchaseOrderId);
  Future<Either<Failure, PaginatedResponse<MessageModel>>> getChatMessages(int chatId, {int page = 1});
  Future<Either<Failure, MessageModel>> sendMessage(int chatId, {String? body, String? imagePath});
  Future<Either<Failure, List<ChatModel>>> getChats();
}

class ChatApiDataSourceImpl implements ChatApiDataSource {
  final ApiConsumer _apiConsumer;

  ChatApiDataSourceImpl(this._apiConsumer);

  @override
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId) async {
    final response = await _apiConsumer.post(
      EndPoints.chats,
      data: {'supplier_id': supplierId},
    );
    return response.fold(
      (failure) => Left(failure),
      (json) => Right(CreateChatResponse.fromJson(json['data'])),
    );
  }

  @override
  Future<Either<Failure, FirebaseChatConfig>> getFirebaseToken(int purchaseOrderId) async {
    final response = await _apiConsumer.get(EndPoints.firebaseToken(purchaseOrderId));
    return response.fold(
      (failure) => Left(failure),
      (json) => Right(FirebaseChatConfig.fromJson(json['data'])),
    );
  }

  @override
  Future<Either<Failure, PaginatedResponse<MessageModel>>> getChatMessages(int chatId, {int page = 1}) async {
    final response = await _apiConsumer.get(
      EndPoints.chatMessages(chatId),
      queryParameters: {'page': page, 'limit': 30},
    );
    return response.fold(
      (failure) => Left(failure),
      (json) {
        final List data = json['data']?['messages'] ?? [];
        final messages = data.map((e) => MessageModel.fromJson(e)).toList();
        
        final pagination = PaginationModel(
          currentPage: json['pagination']?['current_page'] ?? page,
          lastPage: json['pagination']?['last_page'] ?? page,
          total: json['pagination']?['total'] ?? messages.length,
          perPage: json['pagination']?['per_page'] ?? 30,
        );

        return Right(PaginatedResponse(data: messages, pagination: pagination));
      },
    );
  }

  @override
  Future<Either<Failure, MessageModel>> sendMessage(int chatId, {String? body, String? imagePath}) async {
    final Map<String, dynamic> data = {};
    if (body != null) data['body'] = body;
    if (imagePath != null) {
      data['image'] = await MultipartFile.fromFile(imagePath);
    }

    final response = await _apiConsumer.post(
      EndPoints.chatMessages(chatId),
      formData: FormData.fromMap(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (json) => Right(MessageModel.fromJson(json['data'])),
    );
  }

  @override
  Future<Either<Failure, List<ChatModel>>> getChats() async {
    final response = await _apiConsumer.get(EndPoints.chats);
    return response.fold(
      (failure) => Left(failure),
      (json) {
        final List data = json['data'] ?? [];
        return Right(data.map((e) => ChatModel.fromJson(e)).toList());
      },
    );
  }
}
