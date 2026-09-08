-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_completeUnitaryFlow
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_eq_zero_of_deficiency_of_completeUnitaryFlow
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (D : Submodule ℂ F) (H : D →ₗ[ℂ] D)
    (U : ℝ → F → F) (hdense : Dense (D : Set F)) (hnorm : ∀ (t : ℝ) (v : F), ‖U t v‖ = ‖v‖)
    (hU0 : ∀ v : F, U 0 v = v) (hUD : ∀ (t : ℝ) (v : D), U t (v : F) ∈ D)
    (hderiv : ∀ (v : D) (t : ℝ),
      HasDerivAt (fun s => U s (v : F)) (Complex.I • (H ⟨U t (v : F), hUD t v⟩ : F)) t) :
    HasZeroDeficiencyOn D H := by

  constructor
  · intro w hw
    refine eq_zero_of_deficiency_of_completeUnitaryFlow D H U hdense hnorm hU0 hUD hderiv 1
      (by norm_num) w fun v => ?_
    simpa using hw v
  · intro w hw
    refine eq_zero_of_deficiency_of_completeUnitaryFlow D H U hdense hnorm hU0 hUD hderiv (-1)
      (by norm_num) w fun v => ?_
    simpa using hw v
