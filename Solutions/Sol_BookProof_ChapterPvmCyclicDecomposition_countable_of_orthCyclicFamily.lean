-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.countable_of_orthCyclicFamily
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
theorem solution [TopologicalSpace.SeparableSpace H] {P : Pvm X H}
    {S : Set H} (h : OrthCyclicFamily P S) : S.Countable := by

  have hdist : ∀ x ∈ S, ∀ y ∈ S, x ≠ y → 1 < dist x y := by
    intro x hx y hy hxy
    have hortho : (inner ℂ x y : ℂ) = 0 := inner_eq_zero_of_orthOrbit (h.orth x hx y hy hxy)
    have hnx : ‖x‖ = 1 := h.unit x hx
    have hny : ‖y‖ = 1 := h.unit y hy
    have hsq : ‖x - y‖ ^ 2 = 2 := by
      rw [@norm_sub_sq ℂ, hnx, hny, hortho]
      norm_num
    have hnn : 0 ≤ ‖x - y‖ := norm_nonneg _
    have : 1 < ‖x - y‖ := by nlinarith [hsq, hnn]
    simpa [dist_eq_norm] using this
  have hpd : S.PairwiseDisjoint (fun x => Metric.ball x (1 / 2)) := by
    intro x hx y hy hxy
    refine Set.disjoint_iff_inter_eq_empty.mpr ?_
    have hb : Disjoint (Metric.ball x (1 / 2)) (Metric.ball y (1 / 2)) := by
      refine Metric.ball_disjoint_ball ?_
      have := hdist x hx y hy hxy
      linarith
    simpa [Set.disjoint_iff_inter_eq_empty] using hb
  exact hpd.countable_of_isOpen (fun x _ => Metric.isOpen_ball)
    (fun x _ => ⟨x, Metric.mem_ball_self (by norm_num)⟩)
