---
name: drawing-vision
description: Read engineering drawings with vision models — the reliable workflow. PDF to PNG, vision read, verify critical dims, feed to precision tools. Use when text extraction fails (scanned PDFs) or dimensions need visual confirmation.
---

# Drawing Vision

You extract dimensions and features from engineering drawings using vision models. The golden rule: **vision understands, deterministic tools measure.**

## The workflow

### 1. CONVERT — PDF to PNG
Scanned PDFs have no text layer. Convert first:
```powershell
pip install pymupdf
python pdf_to_png.py drawing.pdf 200
```
- **200 DPI** for dimension reading (text must be crisp)
- **150 DPI** for overview / layout understanding
- Output: `drawing_p200_pg1.png`, `pg2.png` — one PNG per page

### 2. PASTE — Give the image to the model
In OpenCode: **drag-drop** the PNG into the terminal, or copy image + **Ctrl+V**.
Requirements: the model MUST be vision-capable —
- `z-ai/glm-5.3-flash` (free, NIM) — best all-round
- `nvidia/nemotron-3-super-120b-a12b` (free, NIM) — strong vision
- Qwen3-VL family — document/OCR specialist
Text-only models will fail here. If the agent claims it "can't see images", paste one and ask it to describe it — the 30-second vision test settles it.

### 3. READ — Structured extraction
Ask for dimensions in a fixed format, one page at a time:
```
List ALL dimensions visible: diameters (Ø), lengths, tolerances (±),
angles (°), radii (R), surface finish, GD&T symbols, and title-block data
(material, scale, projection, revision). Mark anything UNCLEAR as [?].
```
One page per message. Never dump 5 pages of PNGs in one go (context hygiene).

### 4. VERIFY — Critical dims are never "approximate"
Vision models sometimes report values as approximate. For engineering work:
- **Critical dimensions** (toleranced, mating features) → send a **zoomed crop** of just that area and re-ask
- **Cross-check** against OCR text or the vector PDF text layer when available
- A dimension marked [?] or "approximate" is NOT final — it is a flag for human review
- When in doubt: STOP and ask the user, never invent a dimension

### 5. USE — Feed precision tools
Verified dims go to deterministic tools:
- **Ballooning** → `balloon_drawing.py` places balloons from vector/OCR text
- **STEP modeling** → dimension list feeds the CadQuery script
- Vision output is the INPUT to these tools, never a replacement for them

## Rules

- **Vision understands, tools measure.** Never place geometry from a vision guess.
- **200 DPI minimum** for reading dimensions. Blurry input = wrong output.
- **Never invent a dimension.** [?] means ask, not guess.
- **One page at a time.** Context hygiene always applies.
- **Scanned PDF?** Convert first, don't fight pdftotext on a scanned page.
