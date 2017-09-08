---

    /*
     * File:   int_strlen.c
     * Author: Adam K Dean
     * Description: get length of an int as if it was a string
     *
     * Created on 11 January 2011, 13:01
     */
     
    int int_strlen(int val)
    {
        int v = val / 10;
        int i = 1, count = 1;
         
        while(v > i - 1)
        {
            i *= 10;
            count ++;
        }
         
        return count;
    }