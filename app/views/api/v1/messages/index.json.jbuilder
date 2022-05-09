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
      json.topic do
        json.id @conversation.match.end_target.topic.id
        json.name @conversation.match.end_target.topic.name
      end
    end
  end
end
json.meta do
  json.total_messages_count @conversation.messages.count
  json.current_page @conversation.messages.page.current_page
  json.total_pages @conversation.messages.page.total_pages
  json.next_page @conversation.messages.page.next_page unless @conversation.messages.page.last_page?
  unless @conversation.messages.page.first_page?
    json.prev_page @conversation.messages.page.prev_page
  end
end
