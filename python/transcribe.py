import whisper
import ffmpeg

model = whisper.load_model("base")

audio = "20230301_Vikings Quiz TC Preview for text.mp3"
transcribe = model.transcribe(audio)

file1 = open("transcript1.txt", "w")

file1.write(transcribe["text"])

file1.close()