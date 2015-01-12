#include "problem.h"
#include <QDateTime>

const char * g_problems[80] = {
    "1 + 2 = ", "2 + 3 = ", "2 + 2 = ",
    "1 + 4 = ", "2 + 5 = ", "4 + 2 = ",
    "2 + 6 = ", "3 + 3 = ", "3 + 4 = ",
    "7 + 2 = ", "2 + 7 = ", "4 + 6 = ",
    "3 + 8 = ", "2 + 5 = ", "2 + 9 = ",
    "4 + 6 = ", "5 + 9 = ", "6 + 7 = ",
    "5 + 3 = ", "2 + 6 = ", "7 + 8 = ",
    "7 + 5 = ", "4 + 9 = ", "8 + 8 = ",
    "5 + 8 = ", "6 + 6 = ", "7 + 9 = ",
    "7 + 7 = ", "8 + 9 = ", "9 + 9 = ",

    "1 + 2 + 3 = ", "2 + 3 + 2 = ", "2 + 2 + 4 = ",
    "1 + 4 + 1 = ", "5 + 5 + 3 = ", "4 + 2 + 3 = ",
    "3 + 6 + 2 = ", "3 + 3 + 9 = ", "3 + 4 + 5 = ",
    "6 + 2 + 8 = ", "2 + 7 + 9 = ", "7 + 4 + 6 = ",
    "3 + 3 + 8 = ", "9 + 2 + 5 = ", "2 + 9 + 8 = ",
    "4 + 6 + 4 = ", "5 + 7 + 9 = ", "6 + 9 + 7 = ",
    "5 + 3 + 2 = ", "2 + 3 + 6 = ", "7 + 8 + 6 = ",
    "7 + 7 + 9 = ", "4 + 9 + 9 = ", "8 + 8 + 9 = ",
    "9 + 5 + 8 = ", "6 + 9 + 6 = ", "7 + 9 + 9 = ",
    "7 + 7 + 8 = ", "8 + 9 + 6 = ", "9 + 9 + 8 = ",

    "3 + 6 + 2 + 8 = ", "1 + 2 + 7 + 9 = ",
    "4 + 7 + 4 + 6 = ", "5 + 3 + 3 + 8 = ",
    "7 + 9 + 2 + 5 = ", "8 + 2 + 9 + 8 = ",
    "9 + 4 + 6 + 4 = ", "6 + 5 + 7 + 9 = ",
    "6 + 9 + 7 + 9 = ", "5 + 3 + 5 + 8 = ",
    "2 + 7 + 3 + 6 = ", "5 + 7 + 8 + 6 = ",
    "8 + 7 + 7 + 9 = ", "8 + 4 + 9 + 9 = ",
    "6 + 8 + 8 + 9 = ", "4 + 9 + 5 + 8 = ",
    "4 + 9 + 6 + 3 = ", "7 + 9 + 6 + 9 = ",
    "7 + 7 + 7 + 6 = ", "8 + 9 + 6 + 5 = "
};

const int g_answers[80] = {
    3,  5,  4,
    5,  7,  6,
    8,  6,  7,
    9,  9,  10,
    11, 7,  11,
    10, 14, 13,
    8,  8,  15,
    12, 13, 16,
    13, 12, 16,
    14, 17, 18,

    6,  7,  8,
    6,  13,  9,
    11,  15,  12,
    16,  18,  17,
    14, 16,  19,
    14, 21, 22,
    10,  11,  21,
    23, 22, 25,
    22, 21, 25,
    22, 23, 26,

    19,  19,
    21,  19,
    23,  27,
    23,  27,
    31,  21,
    18,  26,
    31,  30,
    29,  26,
    22,  31,
    27,  28
};

MathProblem::MathProblem(QObject *parent)
    : QObject(parent), m_index(-1)
    , m_currentAnswer(-1) , m_currentRight(false)
{
    qsrand(QDateTime::currentDateTime().toTime_t());
}

MathProblem::~MathProblem()
{}

QString MathProblem::next()
{
    ++m_index;
    if(m_index == sizeof(g_answers)/sizeof(g_answers[0]))
    {
        m_index = 0;
    }

    int var = qrand() % 2;
    if(var && (qrand() % 2)) var = -var;
    m_currentAnswer = g_answers[m_index] + qrand() % 2;
    m_currentRight = (g_answers[m_index] == m_currentAnswer);

    return QString("%1%2").arg(g_problems[m_index]).arg(m_currentAnswer);
}

bool MathProblem::test(bool right)
{
    return right == m_currentRight;
}

void MathProblem::reset()
{
    m_index = -1;
    m_currentRight = false;
    m_currentAnswer = 0;
}
