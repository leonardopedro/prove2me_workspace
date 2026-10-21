-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.p_image_eq_zero
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
open BookProof.ChapterPvmScalarMeasure



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {G : Type*} [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (T : ContinuousImprimitivitySystem G X H) (g : G) {E : Set X}
    (hE : MeasurableSet E) (h : T.P.p E = 0) : T.P.p ((fun x => g • x) '' E) = 0 := by

  ext v
  have hsurj : ∃ w, T.U g w = v := ⟨(T.U g).symm v, by simp⟩
  obtain ⟨w, rfl⟩ := hsurj
  rw [← T.covariant g hE w, h]
  simp
