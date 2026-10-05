-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.eq_cfc_psiFun
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_continuous_gFun
import Theorems.Thm_BookProof_PositiveSquareRoot_continuous_psiFun
import Theorems.Thm_BookProof_PositiveSquareRoot_psi_gFun
import Theorems.Thm_BookProof_PositiveSquareRoot_eq_cfc_gFun
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (C R : H →L[ℂ] H) (hC : 0 ≤ C) (hC1 : C ≤ 1)
    (hid : R * (1 - C - C + C * C + C * C) = C * C) : C = cfc psiFun R := by

  have hsa : IsSelfAdjoint C := hC.isSelfAdjoint
  have hg := eq_cfc_gFun C R hC hid
  have hcomp : cfc (psiFun ∘ gFun) C = cfc psiFun (cfc gFun C) :=
    cfc_comp psiFun gFun C hsa continuous_psiFun.continuousOn continuous_gFun.continuousOn
  have hspec := UnboundedPolar.spectrum_subset_Icc hC hC1
  have hcongr : cfc (psiFun ∘ gFun) C = cfc (id : ℝ → ℝ) C :=
    cfc_congr fun t ht => psi_gFun (hspec ht)
  rw [cfc_id ℝ C] at hcongr
  rw [hg, ← hcomp, hcongr]
