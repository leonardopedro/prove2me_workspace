-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.orthonormal_of_orthCyclicFamily
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_inner_eq_zero_of_orthOrbit
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {S : Set H}
    (h : OrthCyclicFamily P S) : Orthonormal ℂ ((↑) : S → H) := by

  constructor
  · intro i; exact h.unit i.1 i.2
  · intro i j hij
    exact inner_eq_zero_of_orthOrbit
      (h.orth i.1 i.2 j.1 j.2 (by simpa [Subtype.ext_iff] using hij))
