use std::{
    fs::File,
    io::{BufReader, Read},
};

pub struct FileStorage {
    path: &'static str,
}

impl FileStorage {
    pub fn new() -> FileStorage {
        FileStorage { path: "" }
    }

    pub fn set_path(&mut self, _path: &'static str) {
        self.path = _path;
    }

    pub fn read_file(&self) -> Box<Vec<u8>> {
        let file = File::open(self.path);
        let mut buf_reader = BufReader::new(file.unwrap());
        let mut buf: Vec<u8> = vec![];
        let _ = buf_reader.read_to_end(&mut buf);
        let file_ref = Box::new(buf);
        file_ref
    }
}
