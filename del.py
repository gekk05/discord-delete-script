#!/usr/bin/python3
# Usage: .del (number) or .del
import asyncio
import discord
import requests
import base64
import re


token = "INSERT_TOKEN_HERE";
c = discord.Client()

@c.event
async def on_ready():
    warning = "YOU MUST KEEP THIS WINDOW OPEN FOR THE DELETE SCRIPT TO WORK (can be minimized)"
    welcome = "Logged in as {0.name} - {0.id}".format(c.user)
    print(warning)
    print(welcome)

@c.event
async def on_message(message):
    if message.content.startswith('.del') and message.author == c.user:
        if re.search(r'\d+$', message.content) is not None:
            t = int(message.content[len('.del'):].strip())
        else:
            t = 9999999
        async for m in message.channel.history(limit=t):
            try:
                if m.author == c.user:
                    await m.delete()
                    # Possibly rate limited
            except: pass

c.run(token, bot=False)
