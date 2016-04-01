#include <iostream>

class Vector {
private:
	double x,y,z;

public:
	Vector(double x, double y, double z) {

	}

	friend Vector operator +(const Vector& left, const Vector& right) {

	}
	// put more of your methods here!
	friend std::ostream& operator <<(std::ostream& s, const Vector& v) {
		return s << v.x << ',' << v.y << ',' << v.z;
	}
};
using namespace std;
int main() {
	Vector v1(1.0, 2.5, 0.5);
	Vector v2(1.5, 2.0, 1.0);
	Vector v3 = v1 + v2;
	Vector v4 = v1 * 2;
	Vector v5 = 2 * v1;
	Vector v6 = v1 - v2;
	double length = v1.abs();
	cout << v1 << "\n";
	cout << v2 << "\n";
	cout << v3 << "\n";
	cout << v4 << "\n";
	cout << v5 << "\n";
	cout << v6 << "\n";
	cout << length << "\n";
}

	
