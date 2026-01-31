import discord
from discord.ext import commands
from discord import app_commands



class Client(commands.Bot):
    async def on_ready(self):
        print(f'Logged on as {self.user}!')

        try: 
            guild = discord.Object(id=1336492602652102686)
            synced = await self.tree.sync(guild=guild)
            print(f'Synced {len(synced)} commands to guild {guild.id}')
        except Exception as e:
            print(f'Error syncing commands: {e}')
    async def on_message(self, message):
        print(f'Message from {message.author}: {message.content}')
        
        if message.author == self.user:
            return
        
        TARGET_USER_ID = 1322983575762763963
        ##TARGET_USER_ID2 = 1001489146084327454
        if message.author.id == TARGET_USER_ID:
            await message.channel.send(f'STFU asian{message.author.mention}')

        #if message.author.id == TARGET_USER_ID2:
            #await message.channel.send(f'KYS twink {message.author.mention}')
            
        if "bum" in message.content.lower():
            await message.channel.send(f'It takes one to know one, {message.author.mention}.')
        #for user in message.mentions:
            #if user.id == TARGET_USER_ID2:
                #await message.channel.send(f"THAT NAME IS FORBIDDEN TWINK. (This was triggered by {message.author.mention} mentioning {user.mention})")
                #break

    async def on_member_join(member):
        await member.channel.send(f'Welcome, {member.name}')
    

intents = discord.Intents.default()
intents.message_content = True
client = Client(command_prefix="!", intents=intents)


GUILD_ID = discord.Object(id=1336492602652102686)


client.run('MTQ0OTAzNzQyOTM5NzkxNzcxOQ.GsUPAz.gDhr1H0QLMOGQYCdDWoP_c29vKvS01CB0_cvXY')