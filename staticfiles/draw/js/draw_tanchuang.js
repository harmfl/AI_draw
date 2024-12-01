// 获取 CSRF Token 的函数
function getCSRFToken() {
    const csrfTokenElement = document.querySelector('input[name="csrfmiddlewaretoken"]');
    if (csrfTokenElement) {
        return csrfTokenElement.value;
    } else {
        console.error("CSRF token element not found");
        return "";
    }
}
// 打开弹窗
document.getElementById("popup-button").addEventListener("click", () => {
    document.getElementById("popup").classList.toggle("show");
    showMenu(); // 打开弹窗时显示菜单
});

// 调试：打印 CSRF Token 确保正确获取
console.log("CSRF Token:", getCSRFToken());

// 获取弹窗和按钮元素
const popupButton = document.getElementById('popup-button');
const popup = document.getElementById('popup');

// 点击按钮显示弹窗
// popupButton.addEventListener('click', () => {
//     popup.classList.toggle('show');
//     showMenu();
// });

// 关闭弹窗的函数
function closePopup() {
    popup.classList.remove('show');
}

// 显示菜单，隐藏聊天
function showMenu() {
    document.getElementById("popup-title").textContent = "菜单";
    document.getElementById("menu-items").classList.remove("hidden");
    document.getElementById("chat-content").classList.add("hidden");
    document.getElementById("chat-input-area").classList.add("hidden");
    document.getElementById("more-options").classList.add("hidden");
}

// 进入AI对话模式
function startChat() {
    document.getElementById("popup-title").textContent = "AI对话";
    document.getElementById("menu-items").classList.add("hidden");
    document.getElementById("chat-content").classList.remove("hidden");
    document.getElementById("chat-input-area").classList.remove("hidden");
}

// 切换更多选项
function toggleMoreOptions() {
    document.getElementById("more-options").classList.toggle("hidden");
}

// 清空聊天内容
function clearChat() {
    document.getElementById("chat-content").innerHTML = "";
}

let aiMessages = []; // 保存AI消息的文本内容

function displayMessage(type, content) {
    const chatContent = document.getElementById("chat-content");
    const messageContainer = document.createElement("div");
    messageContainer.classList.add(type === "user" ? "user-container" : "ai-container");

    const avatar = document.createElement("img");
    avatar.classList.add("avatar");
    avatar.src = type === "user" ? "/static/draw/img/对话.png" : "/static/draw/img/AI.png";

    const messageElement = document.createElement("div");
    messageElement.classList.add("chat-message", type === "user" ? "user-message" : "ai-message");
    messageElement.textContent = content;

    if (type === "user") {
        messageContainer.appendChild(messageElement);
        messageContainer.appendChild(avatar);
    } else {
        messageContainer.appendChild(avatar);
        messageContainer.appendChild(messageElement);
        aiMessages.push(content); // 保存 AI 消息内容
    }

    chatContent.appendChild(messageContainer);
    chatContent.scrollTop = chatContent.scrollHeight;
}
// 获取 AI 最新的消息并朗读
async function readLatestAIText() {
    const aiText = aiMessages[aiMessages.length - 1];
    if (!aiText) return;

    try {
        await fetch("http://127.0.0.1:5000/stop_audio"); // 停止之前的音频

        const response = await fetch("http://127.0.0.1:5000/generate_audio", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ text: aiText })
        });

        if (response.ok) {
            const data = await response.json();
            const filePath = data.file_path;
            playAudio(filePath);
        } else {
            alert("音频生成失败，请稍后重试！");
        }
    } catch (error) {
        console.error("Error:", error);
        alert("请求失败！");
    }
}

function playAudio(filePath) {
    fetch("http://127.0.0.1:5000/play_audio", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ file_path: filePath })
    })
    .catch(error => console.error("音频播放失败:", error));
}



// 显示等待动画
function showLoading() {
    const loading = document.createElement("div");
    loading.classList.add("loading-spinner");
    loading.id = "loading-spinner";
    loading.innerHTML = "<div class='spinner'></div>";
    document.getElementById("chat-content").appendChild(loading);
    document.getElementById("chat-content").scrollTop = document.getElementById("chat-content").scrollHeight;
}

// 隐藏等待动画
function hideLoading() {
    const loading = document.getElementById("loading-spinner");
    if (loading) loading.remove();
}

// 发送文本消息到 AI
function sendMessage() {
    const message = document.getElementById("chat-input").value.trim();
    if (message) {
        displayMessage("user", message);
        document.getElementById("chat-input").value = "";
        fetch('/draw/ai_chat/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCSRFToken()
            },
            body: JSON.stringify({ message: message, message_type: 'text' })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "success") {
                displayMessage("ai", data.ai_response);
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            alert("发送消息失败，请稍后重试");
        });
    }
}

// 发送画板图片
function sendCanvasImage() {
    const canvas = document.getElementById("canvas");
    if (!canvas) {
        console.error("Canvas element not found");
        return;
    }

    const imageData = canvas.toDataURL("image/png");
    displayMessage("user", "已发送图片");
    showLoading();

    fetch('/draw/ai_chat/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCSRFToken()
        },
        body: JSON.stringify({ image: imageData, message_type: "image" })
    })
    .then(response => response.json())
    .then(data => {
        hideLoading();
        if (data.status === "success") {
            displayMessage("ai", data.ai_response);
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        hideLoading();
        alert("发送图片失败，请稍后重试");
    });
}

// 请求根据图片生成故事
function requestStory() {
    const canvas = document.getElementById("canvas");
    const imageData = canvas.toDataURL("image/png");

    displayMessage("user", "正在生成故事...");
    showLoading();

    fetch('/draw/generate_story/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCSRFToken()
        },
        body: JSON.stringify({ image_data: imageData })
    })
    .then(response => response.json())
    .then(data => {
        hideLoading();
        if (data.status === "success") {
            displayMessage("ai", data.story);
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        hideLoading();
        alert("生成故事失败，请稍后重试");
    });
}


function togglePopup() {
    const popup = document.getElementById('popup');
    const popupButton = document.getElementById('popup-button');

    if (popup.classList.contains('show')) {
        popup.classList.remove('show');
        popupButton.classList.remove('hide'); // 按钮重新显示
    } else {
        popup.classList.add('show');
        popupButton.classList.add('hide'); // 按钮隐藏
    }
    console.log("Popup class list:", popup.classList);
}




// 修改保存绘画作品的 AJAX 请求代码
function saveDrawing() {
    const canvas = document.getElementById("canvas");
    const name = prompt("请输入作品名称", "未命名");
    const feedback = prompt("请输入留言内容", "");
    const imageData = canvas.toDataURL("image/png");

    $.ajax({
        url: "/draw/save_drawing/",
        type: "POST",
        headers: {
            "X-CSRFToken": getCSRFToken(),  // 确保这里使用了获取 CSRF Token 的函数
        },
        data: {
            name: name,
            feedback: feedback,
            image_data: imageData,
        },
        success: function(response) {
            if (response.status === "success") {
                alert("绘画已成功保存！");
            } else {
                alert("保存失败，请重试！");
            }
        },
        error: function(error) {
            console.error("Error saving drawing:", error);
            alert("保存失败，请重试！");
        }
    });
}






