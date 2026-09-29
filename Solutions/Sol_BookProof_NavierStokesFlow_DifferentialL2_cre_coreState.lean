-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.cre_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_crd_coreState
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (b : Vel) :
    cre i (coreState b) = ((Real.sqrt ((b i : ℝ) + 1) : ℝ) : ℂ) • coreState (raise i b) := by

  refine crd_injective (funext fun g => ?_)
  rw [crd_cre, crd_smul]
  simp only [cFun, crd_coreState, Pi.smul_apply, smul_eq_mul]
  by_cases hg : g = raise i b
  · have hlow : lower i g = b := by rw [hg, lower_raise]
    have hgi : (g i : ℝ) = (b i : ℝ) + 1 := by rw [hg, raise_self]; push_cast; ring
    rw [hlow, if_pos rfl, if_pos hg, hgi]
  · rw [if_neg hg, mul_zero]
    by_cases hg2 : lower i g = b
    · have hgi : g i = 0 := by
        by_contra hne
        exact hg (by rw [← hg2, raise_lower i (Nat.one_le_iff_ne_zero.mpr hne)])
      rw [hgi]
      simp
    · rw [if_neg hg2, mul_zero]
