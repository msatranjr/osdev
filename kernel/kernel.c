void some_function()
{
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'y';
}

void main()
{
    some_function();
    //char* video_memory = (char*) 0xb8000;
    //*video_memory = 'X';
    some_function();
}