import os

folder_path = r"C:\Users\bowli\Music\Ogg Music\Colts Playlist"

for filename in os.listdir(folder_path):
    old_file = os.path.join(folder_path, filename)
    
    if os.path.isfile(old_file):
        base_name, _ = os.path.splitext(old_file)
        new_file = base_name + ".ogg"

        os.rename(old_file, new_file)

print("All file extensions changed to .ogg")