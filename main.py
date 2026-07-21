import os

from telegram import Update
from telegram.ext import Application, CommandHandler, ContextTypes


BOT_TOKEN = os.getenv("BOT_TOKEN")


async def start(
    update: Update,
    context: ContextTypes.DEFAULT_TYPE,
) -> None:
    await update.message.reply_text(
        "👋 Добро пожаловать в TeamCash Agent Bot!"
    )


def main() -> None:
    if not BOT_TOKEN:
        raise RuntimeError("Переменная BOT_TOKEN не установлена")

    application = Application.builder().token(BOT_TOKEN).build()
    application.add_handler(CommandHandler("start", start))

    print("Bot started")
    application.run_polling()


if __name__ == "__main__":
    main()
