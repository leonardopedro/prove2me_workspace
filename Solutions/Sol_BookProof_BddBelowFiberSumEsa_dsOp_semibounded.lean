-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.dsOp_semibounded
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
open BookProof.BddBelowFiberSumEsa












open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
    [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}
    (H : ∀ i, D i →ₗ[ℂ] G i) {c : ℝ} (h : ∀ i, SemiboundedBelowOn (D i) (H i) c) :
    SemiboundedBelowOn (dsCore D) (dsOp H) c := by

  classical
  intro v
  set x : lp G 2 := (v : lp G 2) with hx
  set S : Finset ι := v.2.1.toFinset with hS
  have hzero : ∀ i ∉ S, (x : ∀ i, G i) i = 0 := by
    intro i hi
    by_contra hne
    exact hi (by simpa [hS] using hne)
  have hpair : (inner ℂ (dsOp H v) x : ℂ)
      = ∑ i ∈ S, (inner ℂ (H i ⟨(x : ∀ i, G i) i, v.2.2 i⟩) ((x : ∀ i, G i) i) : ℂ) := by
    rw [lp.inner_eq_tsum]
    refine tsum_eq_sum fun i hi => ?_
    have h0 : (⟨(x : ∀ i, G i) i, v.2.2 i⟩ : D i) = 0 := Subtype.ext (hzero i hi)
    simp [dsOp_coe, hzero i hi]
  have hnorm : (‖x‖ : ℝ) ^ 2 = ∑ i ∈ S, ‖(x : ∀ i, G i) i‖ ^ 2 := by
    have h1 : (inner ℂ x x : ℂ) = ∑ i ∈ S, (inner ℂ ((x : ∀ i, G i) i) ((x : ∀ i, G i) i) : ℂ) := by
      rw [lp.inner_eq_tsum]
      refine tsum_eq_sum fun i hi => ?_
      simp [hzero i hi]
    have h2 := congrArg Complex.re h1
    have h3 : (inner ℂ x x : ℂ).re = ‖x‖ ^ 2 := inner_self_eq_norm_sq (𝕜 := ℂ) x
    rw [h3, Complex.re_sum] at h2
    rw [h2]
    exact Finset.sum_congr rfl fun i _ => inner_self_eq_norm_sq (𝕜 := ℂ) _
  have hfib : ∀ i ∈ S, -c * ‖(x : ∀ i, G i) i‖ ^ 2
      ≤ (inner ℂ (H i ⟨(x : ∀ i, G i) i, v.2.2 i⟩) ((x : ∀ i, G i) i) : ℂ).re := by
    intro i _
    exact h i ⟨(x : ∀ i, G i) i, v.2.2 i⟩
  have hsum := Finset.sum_le_sum hfib
  rw [hpair, Complex.re_sum, hnorm, Finset.mul_sum]
  exact hsum
