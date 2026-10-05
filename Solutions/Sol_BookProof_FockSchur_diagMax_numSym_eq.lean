-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.diagMax_numSym_eq
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSecondQuantization_coe_fockEquiv_symm
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_coe
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes Conf) :
    (diagMax numSym (inclC numSym x) : Fock) = toLp (numWeight (fockEquiv.symm x)) := by

  refine lp.ext (funext fun α => ?_)
  rw [diagMax_coe]
  have hx : ((x : Fock) : Conf → ℂ) α = (fockEquiv.symm x) α := by
    rw [coe_fockEquiv_symm x]
    rfl
  rw [inclC_coe, hx]
  rfl
