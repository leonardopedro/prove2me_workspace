-- Generated from ChapterGaugeCasimirAverage.lean — solution of BookProof.ChapterGaugeCasimirAverage.finiteGaugeAverage_of_isPhysicalObservable
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
open BookProof.ChapterGaugeCasimirAverage




open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]
variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [Fintype G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution {f : X → ℝ}
    (hf : IsPhysicalObservable G f) :
    finiteGaugeAverage (X := X) G f = f := by

  funext x
  have hcard : (Fintype.card G : ℝ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero (α := G))
  have hsum : ∑ g : G, f (g • x) = (Fintype.card G : ℝ) * f x := by
    simp [hf _ x, Finset.card_univ, mul_comm]
  rw [finiteGaugeAverage, hsum, mul_comm, mul_div_assoc, div_self hcard, mul_one]
