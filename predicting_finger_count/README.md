# Puzzle Statement
A little girl counts from 1 to 1000 using the fingers on her left hand as follows. She starts by calling her thumb 1, index finger 2, and so until she gets to her
little finger, which is 5. She then reverses direction and calls her ring finger 6 until she gets to her thumb which is now 9. She repeats this process until she
reaches 1000. The question is on which finger will she stop?

# Solution Strategy
We are going to use modular arithmetic to solve this one. Lets just shift everyting over by negative 1 so that the girl starts counting at 0 and finishes at 999.
Now we just need to give the fingers on her left hand numbers from 0 to 7. Some of the fingers will be repeated but that's expected because of the reversing scheme
that she uses. So the mapping is `0 -> thumb, 1 -> index finger, 2 -> middle finger, 3 -> ring finger, 4 -> little finger, 5 -> ring finger, 6 -> middle finger, 7 -> index finger,
8 -> thumb`. Now we just perform arithmetic mod 9 to see which finger she will stop on, i.e. the answer is `999 mod 8 = 7` so she stops on her index finger.
