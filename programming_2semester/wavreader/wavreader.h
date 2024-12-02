//
// Created on 25.03.2022.
//

#ifndef WAVMETRIC_WAVREADER_H
#define WAVMETRIC_WAVREADER_H
#include "filesystem"
using namespace std;

class wavreader {
    public:
        struct frequencies
        {
            uint32_t counters[9]{};
            double results[9]{};
            uint32_t total{};
        };
    private:
        struct  WAV_HEADER
        {
            // RIFF Chunk
            uint8_t         Chunk_ID[4];        // RIFF
            uint32_t        Chunk_data_Size{};      // RIFF Chunk data Size
            uint8_t         RIFF_TYPE_ID[4];        // WAVE
            // "fmt" sub-chunk
            uint8_t         Chunk1_ID[4];         // fmt
            uint32_t        chunk1_data_Size{};  // Size of the format chunk
            uint16_t        Format_Tag{};    //  format_Tag 1=PCM
            uint16_t        Num_Channels{};      //  1=Mono 2=Stereo
            uint32_t        Sample_rate{};  // Sampling Frequency in (44100)Hz
            uint32_t        byte_rate{};    // Byte rate
            uint16_t        block_Align{};     // 4
            uint16_t        bits_Per_Sample{};  // 16
            /* "data" sub-chunk */
            uint8_t         chunk2_ID[4]; // data
            uint32_t        chunk2_data_Size{};  // Size of the audio data
        };

        WAV_HEADER header{};
        FILE* fp{};
        const char* filePath{};
        string wave_path{};
        bool opened = false;
        uint32_t seconds = 0;

    private:
        bool correct_extension() {
            if (wave_path.substr(wave_path.find_last_of('.') + 1) == "wav") {
                return true;
            } else {
                return false;
            }
        }

        bool read_header() {
            if (!opened) { return false; }
            fread(&header, 1, sizeof(header), fp);
            seconds = header.chunk2_data_Size/header.byte_rate;
            return true;
        }

        bool is_wav() {
            if (header.RIFF_TYPE_ID[0] == 'W' && header.RIFF_TYPE_ID[1] == 'A'
                && header.RIFF_TYPE_ID[2] == 'V' && header.RIFF_TYPE_ID[3] == 'E') {
                return true;
            } else {
                return false;
            }
        }

        frequencies analyze(unsigned short* current) {
            frequencies freq = {};
            for (int i = 0; i < header.Sample_rate*header.Num_Channels; ++i) {
                if (current[i] <= 50) {
                    freq.counters[0]++;
                } else if (current[i] <= 100) {
                    freq.counters[1]++;
                } else if (current[i] <= 200) {
                    freq.counters[2]++;
                } else if (current[i] <= 500) {
                    freq.counters[3]++;
                } else if (current[i] <= 1000) {
                    freq.counters[4]++;
                } else if (current[i] <= 2000) {
                    freq.counters[5]++;
                } else if (current[i] <= 5000) {
                    freq.counters[6]++;
                } else if (current[i] <= 10000) {
                    freq.counters[7]++;
                } else if (current[i] <= 20000) {
                    freq.counters[8]++;
                }
            }
            freq.total = freq.counters[0] + freq.counters[1] + freq.counters[2] + freq.counters[3] + freq.counters[4] +
                         freq.counters[5] + freq.counters[6] + freq.counters[7] + freq.counters[8];
            for (int i = 0; i < 9; ++i) {
                freq.results[i] = (double)freq.counters[i]/(double)freq.total;
            }
            return freq;
        }

        void reset_state() {
            if (opened) {
                fclose(fp);
            }
            seconds = 0;
            header = {};
            wave_path = {};
            delete fp;
            filePath = "";
            opened = false;
        }

    public:
        bool is_open() {
            return opened;
        }
        bool open_file(string path) {
            filePath = path.c_str();
            fopen_s(&fp, filePath, "rb");
            wave_path = path;
            if (fp == nullptr || !correct_extension()) {
                reset_state();
                return false;
            } else {
                opened = true;
                if (read_header() && is_wav()) {
                    return true;
                } else {
                    reset_state();
                    return false;
                }
            }
        }

        void close_file() {
            reset_state();
        }

        uint32_t get_length() {
            if (!opened) { return 0; }
            return seconds;
        }

         frequencies read_one_second(int second = 0) {
            if (second < 0 || second > seconds-1) {
                return {};
            }
            unsigned short* current{};
            current = new unsigned short[header.Sample_rate*header.Num_Channels];
            fseek(fp, ((long)header.Sample_rate*(long)header.Num_Channels*(long)second*(long)sizeof(unsigned short))+44, SEEK_SET);
            fread_s(current, header.byte_rate, sizeof(unsigned short), header.Sample_rate*header.Num_Channels, fp);
            frequencies freq = analyze(current);
            delete []current;
            return freq;
        }

        void print_header() {
            if (!opened) { return; }
            cout << "Chunk ID             :" << header.Chunk_ID[0] << header.Chunk_ID[1] << header.Chunk_ID[2] << header.Chunk_ID[3] << endl;
            cout << "Chunk data Size      :" << header.Chunk_data_Size << endl;
            cout << "RIFF TYPE ID         :" << header.RIFF_TYPE_ID[0] << header.RIFF_TYPE_ID[1] << header.RIFF_TYPE_ID[2] << header.RIFF_TYPE_ID[3] << endl;
            // format subchunk
            cout<<"--------------------------------------------------"<<endl;
            cout << "Chunk1_ID            :" << header.Chunk1_ID[0] << header.Chunk1_ID[1] << header.Chunk1_ID[2] << header.Chunk1_ID[3] << endl;
            cout << "Chunk1 data Size     :" << header.chunk1_data_Size << endl;
            cout << "Format Tag           :" << header.Format_Tag << endl;
            cout << "Num_Channels         :" << header.Num_Channels << endl;
            cout << "Sample_rate          :" << header.Sample_rate << endl;
            cout << "byte_rate            :" << header.byte_rate << endl;
            cout << "block_Align          :" << header.block_Align << endl;
            cout << "bits per sample      :" << header.bits_Per_Sample << endl;
            cout<<"--------------------------------------------------"<<endl;
            cout << "Chunk2_ID            :" << header.chunk2_ID[0] << header.chunk2_ID[1] << header.chunk2_ID[2] << header.chunk2_ID[3] << endl;
            cout << "Chunk2 data Size     :" << header.chunk2_data_Size << endl;
        }
};


#endif //WAVMETRIC_WAVREADER_H
