#ifndef PROBLEM_H
#define PROBLEM_H

#include <QObject>
#include <QString>

class MathProblem : public QObject
{
    Q_OBJECT
public:
    MathProblem(QObject *parent = 0);
    ~MathProblem();

    Q_INVOKABLE QString next();
    Q_INVOKABLE bool test(bool right);
    Q_INVOKABLE void reset();

private:
    int m_index;
    int m_currentAnswer;
    bool m_currentRight;
};

#endif // PROBLEM_H
