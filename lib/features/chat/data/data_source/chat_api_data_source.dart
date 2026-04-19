import 'package:raw_chem/common/http/api_consumer.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';
import 'package:raw_chem/features/chat/domain/model/chat_model.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
import 'package:raw_chem/common/model/pagination_model.dart';

abstract class ChatApiDataSource {
  Future<Either<Failure, CreateChatResponse>> createChat(int supplierId);
  Future<Either<Failure, PaginatedResponse<MessageModel>>> getChatMessages(int chatId, {int page = 1});
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
      (json) => Right(CreateChatResponse.fromJson(json)),
    );
  }

  @override
  Future<Either<Failure, PaginatedResponse<MessageModel>>> getChatMessages(int chatId, {int page = 1}) async {
    final response = await _apiConsumer.get(
      EndPoints.chatMessages(chatId),
      queryParameters: {'page': page, 'limit': 15},
    );
    return response.fold(
      (failure) => Left(failure),
      (json) {
        final List data = json['data'] ?? [];
        final messages = data.map((e) => MessageModel.fromJson(e)).toList();
        
        // Return a PaginatedResponse with metadata if available, or fake it
        final pagination = PaginationModel(
          currentPage: json['meta']?['current_page'] ?? page,
          lastPage: json['meta']?['last_page'] ?? page,
          total: json['meta']?['total'] ?? messages.length,
          perPage: json['meta']?['per_page'] ?? 15,
        );

        return Right(PaginatedResponse(data: messages, pagination: pagination));
      },
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
