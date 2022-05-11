json.messages @messages

json.conversation do
  json.id @conversation.id
  json.match do
    json.id @conversation.match.id
    json.origin_target do
      json.user do
        json.id @conversation.match.origin_target.user.id
        json.name @conversation.match.origin_target.user.name
      end
    end
    json.end_target do
      json.user do
        json.id @conversation.match.end_target.user.id
        json.name @conversation.match.end_target.user.name
      end
    end
    json.topic do
      json.id @conversation.match.end_target.topic.id
      json.name @conversation.match.end_target.topic.name
    end
  end
end
json.meta do
  json.total_messages_count @messages.count
  json.current_page @messages.current_page
  json.total_pages @messages.page.total_pages
  json.next_page @messages.next_page unless @messages.last_page?
  json.prev_page @messages.prev_page unless @messages.first_page?
end
