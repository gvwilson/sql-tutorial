import sys

with open(sys.argv[1], "r") as reader:
    text = reader.readlines()

num = 1
for i, line in enumerate(text):
    if not line.startswith("##"):
        continue
    line = line.lstrip("#").strip()
    if line.startswith("*"):
        text[i] = f"## {line}\n"
        continue
    front, back = line.split(":", 1)
    fill = "null"
    if front != "null":
        fill = f"{num:03d}"
        num += 1
    text[i] = f"## {fill}: {back.strip()}\n"

with open(sys.argv[1], "w") as writer:
    writer.writelines(text)
