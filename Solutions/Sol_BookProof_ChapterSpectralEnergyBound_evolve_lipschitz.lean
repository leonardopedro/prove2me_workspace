-- Generated from ChapterSpectralEnergyBound.lean — solution of BookProof.ChapterSpectralEnergyBound.evolve_lipschitz
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Theorems.Thm_BookProof_ChapterSpectralEnergyBound_hasDerivAt_evolve
import Theorems.Thm_BookProof_ChapterSpectralEnergyBound_norm_deriv_evolve_le
open BookProof.ChapterSpectralEnergyBound




variable {n : Type*} [Fintype n]

variable {n : Type*} [Fintype n]

set_option maxHeartbeats 1000000 in
theorem solution (f : n → ℝ) (E : ℝ) (v : EuclideanSpace ℂ n)
    (h : ∀ i, v i ≠ 0 → |f i| ≤ E) (s t : ℝ) :
    ‖evolve f t v - evolve f s v‖ ≤ E * ‖v‖ * |t - s| := by
  have hderiv : ∀ x ∈ Set.uIcc s t,
      HasDerivWithinAt (fun r : ℝ => evolve f r v)
        (-Complex.I • diagOp f (evolve f x v)) (Set.uIcc s t) x := by

  have hderiv : ∀ x ∈ Set.uIcc s t,
      HasDerivWithinAt (fun r : ℝ => evolve f r v)
        (-Complex.I • diagOp f (evolve f x v)) (Set.uIcc s t) x :=
    fun x _ => (hasDerivAt_evolve f v x).hasDerivWithinAt
  have hbound : ∀ x ∈ Set.uIcc s t, ‖-Complex.I • diagOp f (evolve f x v)‖ ≤ E * ‖v‖ :=
    fun x _ => norm_deriv_evolve_le f E v h x
  have hmain := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le
    hderiv hbound (convex_uIcc s t) Set.left_mem_uIcc Set.right_mem_uIcc
  simpa [Real.norm_eq_abs, abs_sub_comm] using hmain
