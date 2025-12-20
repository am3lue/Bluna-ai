# Changelog

All notable changes to Bluna AI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned for v2.2
- Multi-engine search (Google, Bing backup)
- Enhanced error handling and timeout management
- Improved search result filtering
- Better source attribution

---

## [v2.1.0] - 2025-12-20

### Added
- **Enhanced AI Integration**: Upgraded to Qwen2.5-coder:0.5b model for better coding assistance
- **Intelligent Web Search**: DuckDuckGo integration with automatic fallback for current information
- **Memory System**: Persistent user preferences and conversation history storage
- **Learning Scheduler**: Personalized study plan generation and management
- **Improved UI**: Carbon-Blue themed terminal interface with emojis and better formatting
- **Source Attribution**: Web search results include proper citations and sources
- **Cross-Platform Support**: Works seamlessly on Windows, macOS, and Linux
- **Auto-Setup**: First-run configuration wizard for personalized experience

### Changed
- **Documentation**: Comprehensive rewrite of all .md files for consistency and accuracy
- **Error Handling**: Improved graceful degradation and user-friendly error messages
- **Installation Process**: Simplified setup with modern project structure
- **Performance**: Optimized response times and resource usage

### Fixed
- **Web Search Reliability**: Fixed DuckDuckGo integration issues and timeout handling
- **Memory Persistence**: Resolved conversation history storage problems
- **UI Stability**: Eliminated interface freezing and improved visual feedback
- **Model Integration**: Better Ollama API communication and error recovery

### Technical Improvements
- Modular architecture with clear separation of concerns
- Type-safe result structures and comprehensive error handling
- Enhanced HTTP.jl integration with proper timeout management
- Improved HTML parsing with Gumbo.jl and Cascadia.jl
- Better JSON handling and data persistence

### Developer Experience
- Clean, maintainable code structure
- Comprehensive testing and validation
- Better debugging and logging capabilities
- Improved development setup and documentation

---

## [v2.0.0] - 2025-12-18

### Added
- Initial v2 architecture with agent-based design
- Ollama integration for local AI models
- Basic web search capabilities
- User preference storage
- Terminal-based user interface

### Changed
- Complete rewrite from v1 to v2 architecture
- Moved from simple script to modular application
- Enhanced error handling and user feedback

---

## [v1.0.0] - 2025-12-15

### Added
- Initial release with basic coding assistance
- Simple terminal interface
- Phi-3-mini model integration
- Basic programming language support
- GitHub repository setup

---

## Future Releases

### v2.2.0 - Enhanced Reliability (Planned)
- Multi-engine search support
- Advanced error handling
- Improved timeout management
- Better source filtering

### v2.3.0 - Learning Experience (Planned)
- Interactive quiz modes
- Visual learning aids
- Extended language support
- Progress tracking enhancements

### v3.0.0 - Major Evolution (Planned)
- Web interface option
- Live code execution
- Advanced analytics
- Community features

---

## Support

For issues, questions, or contributions, please visit our [GitHub repository](https://github.com/am3lue/bluna-ai).

## Contributing

Contributions are welcome! Please read our contributing guidelines and code of conduct before submitting pull requests.
