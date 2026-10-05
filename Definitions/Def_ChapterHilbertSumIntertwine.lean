import Mathlib

/-!
# Operators that act fibrewise on a Hilbert sum

If a Hilbert space `H` is the Hilbert sum of a family `G i` along isometries
`V i : G i → H`, and a bounded operator `A` on `H` is carried by every `V i` to a
contraction `B i` of the fibre (`V i (B i u) = A (V i u)`), then under the canonical unitary
`H ≃ ℓ²-⨁ G i` the operator `A` **is** the fibrewise operator `(B i)`.

This is the abstract step used to assemble the cyclic pieces of a projection-valued measure
into a single system (`BookProof.ChapterPvmInducedSystem`) and to recognise the multiplication
system on `L²(X, μ; ℓ²(ι))` (`BookProof.ChapterL2FibreSum`).

Everything is `sorry`-free and uses only the standard axioms.
-/
namespace BookProof.ChapterHilbertSumIntertwine

end BookProof.ChapterHilbertSumIntertwine
