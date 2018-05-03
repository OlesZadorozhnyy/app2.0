import socket from "./socket";
import Mustache from 'mustache';

const sendMessageForm = $('#sendMessage');
const messageTemplate = $('#message_template').html();
const messages = $('.messages');

let channel = socket.channel("room", {});

channel.join()
	.receive("ok", resp => console.log("Joined successfully", resp))
	.receive("error", resp => console.log("Unable to join", resp));

// events
sendMessageForm.on('submit', onSendMessage);
channel.on('message:new', onNewMessageReceived);

function onSendMessage(e) {
	e.preventDefault();

	const form = $(e.target);
	const data = convertData($(this).serializeArray());

	channel.push('message:new', data);
	form[0].reset();
}

function onNewMessageReceived(payload) {
	if (payload.roomId == messages.attr('data-room-id')) {
		const message = Mustache.render(messageTemplate, { messageInfo: payload });
		messages.append(message);
	}
}

function convertData(items) {
	let list = {};

	items.map((item) => {
		list[item.name] = item.value;
	});

	return list;
}