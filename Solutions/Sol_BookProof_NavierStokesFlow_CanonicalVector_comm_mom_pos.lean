-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.comm_mom_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_comm_ann_cre
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_inv_sqrt_two_sq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) :
    (mom i).comp (pos i) - (pos i).comp (mom i) = (-Complex.I) • LinearMap.id := by

  have hcomm : (cre i - ann i).comp (cre i + ann i) - (cre i + ann i).comp (cre i - ann i)
      = (-2 : ℂ) • LinearMap.id := by
    have h := comm_ann_cre i
    have hexp : (cre i - ann i).comp (cre i + ann i) - (cre i + ann i).comp (cre i - ann i)
        = (-2 : ℂ) • ((ann i).comp (cre i) - (cre i).comp (ann i)) := by
      simp only [LinearMap.comp_add, LinearMap.add_comp, LinearMap.comp_sub, LinearMap.sub_comp]
      module
    rw [hexp, h]
  have hscal : Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ) * (-2)
      = -Complex.I := by
    have h := inv_sqrt_two_sq
    push_cast at h ⊢
    linear_combination (-2 * Complex.I) * h
  have hL : (mom i).comp (pos i) - (pos i).comp (mom i)
      = (Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ)) •
        ((cre i - ann i).comp (cre i + ann i) - (cre i + ann i).comp (cre i - ann i)) := by
    simp only [mom, pos, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    module
  rw [hL, hcomm, smul_smul, hscal]
