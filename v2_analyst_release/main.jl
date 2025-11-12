using PDFIO, DataFrames, CSV, Dates, Statistics, Random, Printf

#comenting the code for testing purpose

function extract_text_from_pdf(file_path::String)
    doc = pdDocOpen(file_path)
    text = ""
    for page_num in 1:npages(doc)
        page = PDFPage(doc, page_num)
        text *= getpagecontent(page)
    end
    return text
end

function analyze_text(text::String)
    sentences = split(text, r"\.|\!|\?")
    num_sentences = length(sentences)
    words = split(text)
    num_words = length(words)
    avg_sentence_length = num_words / num_sentences
    return Dict(
        "num_sentences" => num_sentences,
        "num_words" => num_words,
        "avg_sentence_length" => avg_sentence_length
    )
end

function main()
    pdf_file = "sample.pdf"  # Replace with your PDF file path
    text = extract_text_from_pdf(pdf_file)
    analysis = analyze_text(text)
    
    println("PDF Analysis Results:")
    for (key, value) in analysis
        @printf("%s: %0.2f\n", key, value)
    end
end

main()
# --- IGNORE ---
# End of file: tasks/Hackerthon/Bluna-ai/v2_analyst_release/main.jl
# End of recent edits
# End of file: tasks/Hackerthon/Bluna-ai/v2_analyst_release/setup.jl
# --- IGNORE ---
# End of file: tasks/Hackerthon/Bluna-ai/v2_analyst_release
