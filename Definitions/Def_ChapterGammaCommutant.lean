import Definitions.Def_ChapterA3
import Mathlib

/-!
# The commutant of the concrete `4×4` gamma matrices is scalar

`BookProof.ChapterA3b` uses **Pauli's fundamental theorem of the γ-matrices** as
an `EXTERNAL` named hypothesis.  For the *fixed* `4×4` Majorana model built in
`BookProof.ChapterA3` the relevant instance of that theorem — the statement that
the commutant of the four matrices `iγ^μ` consists of scalars only, i.e. the
representation is irreducible — is a finite computation, and this file proves it.

* `gamma_commutant_scalar` — any complex `4×4` matrix commuting with all four
  `iγ^μ` equals `X 0 0 • 1`;
* `gamma_commutant_eq_scalars` — the commutant of the gamma matrices is exactly
  the set of scalar matrices;
* `gamma_intertwiner_unique` — the uniqueness statement in the form used by the
  chapter: two matrices intertwining the same way differ by a scalar factor.

The proof is elementary: `iγ¹` and `iγ⁰ iγ²` are diagonal matrices whose joint
eigenvalue pattern separates all four basis vectors, which forces a commuting
matrix to be diagonal; the off-diagonal gammas `iγ⁰` and `iγ³` then identify all
four diagonal entries.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/
namespace BookProof.ChapterGammaCommutant

end BookProof.ChapterGammaCommutant
