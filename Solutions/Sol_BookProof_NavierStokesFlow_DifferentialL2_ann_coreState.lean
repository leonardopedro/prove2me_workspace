-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.ann_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_ann
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_injective
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_smul
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_raise
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
### The ladder action on the basis states -/

theorem solution (b g : Vel) : crd (coreState b) g = if g = b then 1 else 0 := by
  simp [crd, coreState, lp.single_apply, Pi.singl :=
  e_apply]
  
  /-- `a_i e_β = √βᵢ e_{β−eᵢ}`. -/
  theorem ann_coreState (i : Fin 3) (b : Vel) :
      ann i (coreState b) = ((Real.sqrt ((b i : ℝ)) : ℝ) : ℂ) • coreState (lower i b) := by
    refine crd_injective (funext fun g => ?_)
    rw [crd_ann, crd_smul]
    simp only [aFun, crd_coreState, Pi.smul_apply, smul_eq_mul]
    by_cases hg : raise i g = b
    · have hbi : b i = g i + 1 := by rw [← hg, raise_self]
      have hlow : lower i b = g := by rw [← hg, lower_raise]
      rw [if_pos hg, hlow, if_pos rfl, hbi]
      push_cast
      ring
    · rw [if_neg hg, mul_zero]
      by_cases hg2 : g = lower i b
