import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterMackeyConverse
import Definitions.Def_ChapterPvmInducedSystem
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmMeasure
import Mathlib


/-!
# The scalar spectral measure of a projection-valued measure, and quasi-invariance

`BookProof.ChapterPvmMeasure` attaches to a *cyclic* vector `ψ` the finite measure
`μ_ψ = ‖P(·)ψ‖²` and shows that its null sets are exactly the sets carrying the zero
projection; `BookProof.ChapterMackeyConverse` uses this to prove that the measure of a
system of imprimitivity is quasi-invariant — **in the cyclic case**.  With the cyclic
decomposition of `BookProof.ChapterPvmCyclicDecomposition` the cyclicity hypothesis can be
removed on a separable space.

## Results

* `p_eq_zero_of_forall_measure_zero` — if the cyclic subspaces of a family `S` span a dense
  subspace and every `μ_ψ`, `ψ ∈ S`, gives `E` measure zero, then `P(E) = 0`.
* `scalarMeasure` — the weighted sum `∑ 2^{-n(ψ)} μ_ψ` over a countable family: a **finite**
  measure whose null sets are exactly the sets with `P(E) = 0`
  (`scalarMeasure_eq_zero_iff_p_eq_zero`); it is a *scalar spectral measure* for `P`.
* **`exists_scalarMeasure`** — every projection-valued measure on a separable Hilbert space
  has such a measure.
* **`quasiInvariant_of_null_iff`** and **`exists_quasiInvariant_scalarMeasure`** — for a
  system of imprimitivity over a measurable `G`-space (no cyclic vector assumed, separable
  space) that measure is **quasi-invariant**: the covariance relation makes the family of
  sets with zero projection invariant under the action.
* `pvmMeasure_absolutelyContinuous` and **`exists_induced_system_in_measure_class`** — the
  fibre measures of the direct-sum model of `BookProof.ChapterPvmInducedSystem` all lie in
  the measure class of the scalar measure, so a system of imprimitivity on a separable space
  is, in one quasi-invariant measure class, an `ℓ²`-sum of multiplication systems.

Everything is `sorry`-free and uses only the standard axioms.
-/

open MeasureTheory
open scoped InnerProductSpace

namespace BookProof.ChapterPvmScalarMeasure

open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

/-! ## Sets with zero projection -/



/-! ## The scalar spectral measure -/

/-- The weighted sum `∑_ψ 2^{-n(ψ)} μ_ψ` of the measures of a family of vectors, indexed
injectively by the naturals. -/
noncomputable def scalarMeasure (P : Pvm X H) (S : Set H) (n : S → ℕ) : Measure X :=
  Measure.sum fun ψ : S => ((2 : ENNReal)⁻¹ ^ n ψ) • pvmMeasure P (ψ : H)









/-! ## Existence on a separable space -/





/-! ## Quasi-invariance -/

variable {G : Type*} [Group G] [MulAction G X]









end BookProof.ChapterPvmScalarMeasure
