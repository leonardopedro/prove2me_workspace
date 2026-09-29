-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.diagMax_wSym_eq
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes Conf) :
    (diagMax (wSym w) (inclC (wSym w) x) : Fock) = toLp (wgt w (fockEquiv.symm x)) := by

  refine lp.ext (funext fun α => ?_)
  rw [diagMax_coe]
  have hx : ((x : Fock) : Conf → ℂ) α = (fockEquiv.symm x) α := by
    rw [coe_fockEquiv_symm x]
    rfl
  rw [inclC_coe, hx]
  rfl
