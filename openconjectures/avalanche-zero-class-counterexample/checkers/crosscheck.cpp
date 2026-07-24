#include <array>
#include <bit>
#include <bitset>
#include <cassert>
#include <iostream>
#include <set>
#include <vector>

int main() {
    constexpr unsigned n = 3;
    constexpr unsigned full = (1U << n) - 1U;
    constexpr unsigned initial = 0b101U;

    std::set<unsigned> seen;
    std::vector<unsigned> orbit;
    unsigned current = initial;
    while (!seen.contains(current)) {
        seen.insert(current);
        orbit.push_back(current);
        // Every occupied vertex of the directed cycle fires once and moves its
        // grain to the successor.  Bit zero represents v1.
        current = ((current << 1U) & full) | (current >> (n - 1U));
    }
    assert(current == initial);
    assert((orbit == std::vector<unsigned>{5U, 3U, 6U}));

    std::set<unsigned> simplices;
    for (const unsigned facet : orbit) {
        for (unsigned sub = facet; sub != 0U; sub = (sub - 1U) & facet) {
            simplices.insert(sub);
        }
    }

    unsigned vertices = 0;
    unsigned edges = 0;
    unsigned triangles = 0;
    std::array<std::set<unsigned>, n> adjacency;
    for (const unsigned simplex : simplices) {
        const unsigned size = std::popcount(simplex);
        if (size == 1U) {
            ++vertices;
        } else if (size == 2U) {
            ++edges;
            unsigned first = n;
            unsigned second = n;
            for (unsigned vertex = 0; vertex < n; ++vertex) {
                if ((simplex >> vertex) & 1U) {
                    if (first == n) first = vertex;
                    else second = vertex;
                }
            }
            adjacency[first].insert(second);
            adjacency[second].insert(first);
        } else if (size == 3U) {
            ++triangles;
        }
    }

    std::set<unsigned> reached{0U};
    std::vector<unsigned> stack{0U};
    while (!stack.empty()) {
        const unsigned vertex = stack.back();
        stack.pop_back();
        for (const unsigned neighbour : adjacency[vertex]) {
            if (reached.insert(neighbour).second) stack.push_back(neighbour);
        }
    }
    const unsigned components = reached.size() == vertices ? 1U : 0U;
    assert(vertices == 3U && edges == 3U && triangles == 0U);
    assert(components == 1U);
    const int beta0 = static_cast<int>(components);
    const int beta1 = static_cast<int>(edges) - static_cast<int>(vertices)
                      + static_cast<int>(components);
    assert(beta0 == 1 && beta1 == 1);

    std::cout << "orbit_masks=5,3,6\n";
    std::cout << "vertices=" << vertices << '\n';
    std::cout << "edges=" << edges << '\n';
    std::cout << "triangles=" << triangles << '\n';
    std::cout << "components=" << components << '\n';
    std::cout << "beta0=" << beta0 << '\n';
    std::cout << "beta1=" << beta1 << '\n';
    std::cout << "predicted_dimension=0\n";
    std::cout << "predicted_components=2\n";
    return 0;
}
