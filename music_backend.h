#ifndef MUSIC_BACKEND_H
#define MUSIC_BACKEND_H

#include <gst/gst.h>
#include <string>
#include <atomic>
#include <pthread.h>
#include <memory>

// Callback type for End of Stream (song finished)
typedef void (*EosCallback)(void* user_data);

// --- Decoder Class ---
class Decoder {
public:
    Decoder();
    ~Decoder();

    // Start decoding the specified file in a separate thread.
    // Returns true if thread started successfully.
    bool start(const char* filepath);

    // Stop the decoding thread.
    // This sets the stop flag and waits for the thread to join.
    void stop();

    // Check if the decoder thread is currently running.
    bool is_running() const;

private:
    std::atomic<bool> stop_flag;
    std::atomic<bool> running;
    pthread_t thread_id;
    std::string current_filepath;

    static void* thread_func(void* arg);
    void decode_loop();
};

// --- MusicBackend Class ---
class MusicBackend {
public:
    // Public state for GUI
    bool is_playing;
    bool is_paused;

    MusicBackend();
    ~MusicBackend();

    // --- Public API ---
    void play_file(const char* filepath);
    void pause();
    void stop();
    
    // Returns true if the backend is currently performing a stop operation
    // (used to prevent UI race conditions)
    bool is_shutting_down() const;

    gint64 get_duration();
    gint64 get_position();
    const char* get_current_filepath();

    void set_eos_callback(EosCallback callback, void* user_data);

private:
    std::unique_ptr<Decoder> decoder;
    
    GstElement *pipeline;
    GstBus *bus;
    guint bus_watch_id;

    std::string current_filepath_str;
    std::atomic<bool> stopping; // Flag to indicate stop in progress

    EosCallback on_eos_callback;
    void* eos_user_data;

    // Helper to cleanup GStreamer resources
    void cleanup_pipeline();

    // GStreamer bus callback
    static gboolean bus_callback_func(GstBus *bus, GstMessage *msg, gpointer data);
};

#endif // MUSIC_BACKEND_H
