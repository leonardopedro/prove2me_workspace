-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.unitaryU_add
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_approxU_add
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_apply
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (s t : ℝ) :
    unitaryU hT hsv (s + t) = unitaryU hT hsv s * unitaryU hT hsv t := by

  ext x
  refine tendsto_nhds_unique (tendsto_unitaryU hT hsv (s + t) x) ?_
  have h : (fun n : ℕ => approxU hT n (s + t) x)
      = fun n : ℕ => approxU hT n s (approxU hT n t x) := by
    funext n
    rw [approxU_add]
    rfl
  rw [h]
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨N₁, hN₁⟩ := Metric.tendsto_atTop.mp (tendsto_unitaryU hT hsv t x) (ε / 2) (by linarith)
  obtain ⟨N₂, hN₂⟩ :=
    Metric.tendsto_atTop.mp (tendsto_unitaryU hT hsv s (unitaryU hT hsv t x)) (ε / 2)
      (by linarith)
  refine ⟨max N₁ N₂, fun n hn => ?_⟩
  have hn1 : N₁ ≤ n := le_trans (le_max_left _ _) hn
  have hn2 : N₂ ≤ n := le_trans (le_max_right _ _) hn
  have h1 : dist (approxU hT n s (approxU hT n t x)) (approxU hT n s (unitaryU hT hsv t x))
      < ε / 2 := by
    rw [dist_eq_norm, ← map_sub, norm_approxU_apply]
    have := hN₁ n hn1
    rwa [dist_eq_norm] at this
  have h2 : dist (approxU hT n s (unitaryU hT hsv t x))
      (unitaryU hT hsv s (unitaryU hT hsv t x)) < ε / 2 := hN₂ n hn2
  calc dist (approxU hT n s (approxU hT n t x)) (unitaryU hT hsv s (unitaryU hT hsv t x))
      ≤ dist (approxU hT n s (approxU hT n t x)) (approxU hT n s (unitaryU hT hsv t x))
        + dist (approxU hT n s (unitaryU hT hsv t x))
            (unitaryU hT hsv s (unitaryU hT hsv t x)) := dist_triangle _ _ _
    _ < ε := by linarith
