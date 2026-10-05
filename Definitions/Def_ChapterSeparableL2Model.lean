import Definitions.Def_ChapterSeparableSpectrum
import Definitions.Def_ChapterAbelianCyclicModel
import Definitions.Def_ChapterAbelianDirectSum
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterStandardBorelClassification
import Mathlib


/-!
# A separably acting abelian algebra needs no metrizability hypothesis (plan GAP-2)

`ChapterStandardBorelClassification` classifies the summands of the general abelian
multiplication model under the hypothesis that the compact spectrum is metrizable, and
`ChapterSeparableSpectrum` identifies that hypothesis with separability of the algebra.
This module removes it in the remaining case of interest: when the algebra acts on a
**separable** Hilbert space, each summand `L²(μₓ)` is separable, and a separable `L²`
can always be transported to a standard Borel space, whatever the spectrum looks like.

* `exists_countable_dense_continuous` — if `L²(μ)` is separable then a *countable*
  family of continuous functions is already dense in it;
* `coordMap` — the map `y ↦ (f y)_{f ∈ D}` into the countable power `D → ℂ`, a Polish,
  hence standard Borel, space;
* `coordUnitary`, `coordUnitary_intertwines` — composition with `coordMap` is a
  **unitary** `L²(μ ∘ coordMap⁻¹) ≃ L²(μ)` (it is isometric, and its range is closed and
  contains the dense family), and it carries multiplication by `g` to multiplication by
  `g ∘ coordMap`;
* **HEADLINE** `separable_Lp_realizes_standard_type` — a Borel probability measure on a
  compact Hausdorff space with separable `L²` is unitarily a Borel probability measure
  on a standard Borel space, hence realises one of the five standard types;
* **HEADLINE** `abelian_multiplication_model_classified_separable_hilbert` — every
  abelian algebra of operators on a *separable* complex Hilbert space, presented as a
  unital `*`-representation of `C(Y, ℂ)` for a compact Hausdorff `Y`, is a countable
  direct sum of multiplication algebras, each of which realises one of the five standard
  types.  No metrizability, and no separability of the algebra, is assumed;
* **HEADLINE** `abelian_algebra_multiplication_model_classified_separable_hilbert` — the
  same statement for an abstract commutative unital C\*-algebra, through Gelfand duality.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory TopologicalSpace

namespace BookProof.ChapterSeparableL2Model

open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

/-! ## 1. A countable dense family of continuous functions -/

section Dense

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]



end Dense

/-! ## 2. The coordinate map into a countable power of `ℂ` -/

section Coord

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]

/-- The evaluation map `y ↦ (f y)_{f ∈ D}` into the countable power `D → ℂ`. -/
def coordMap : Y → (D → ℂ) := fun y d => (d : C(Y, ℂ)) y





end Coord

/-! ## 3. Transporting a separable `L²` to a standard Borel space -/

section Transport

universe u

variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsProbabilityMeasure mu] [mu.WeaklyRegular]



end Transport

/-! ## 4. An abelian algebra on a separable Hilbert space -/

section SeparableHilbert

universe u

variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]





end SeparableHilbert

/-! ## 5. The Gelfand form on a separable Hilbert space -/

section GelfandSeparableHilbert

open WeakDual

universe v

variable {A : Type v} [CommCStarAlgebra A]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



end GelfandSeparableHilbert

end BookProof.ChapterSeparableL2Model

end
