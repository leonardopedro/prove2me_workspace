-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.dGammaOp_commForm_bound_w
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_im_inner_dGamma_wgt_bound
import Theorems.Thm_BookProof_FockWeightedSchur_diagMax_wSym_eq
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hBg : WCommBound w col B) (x : lpFiniteModes Conf) :
    |(-2 : ℝ) * (inner ℂ (dGammaOp col x)
        ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).im|
      ≤ B * (inner ℂ ((x : Fock)) ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).re := by

  rw [coe_dGammaOp col x, diagMax_wSym_eq x, coe_fockEquiv_symm x]
  exact im_inner_dGamma_wgt_bound hw hherm hBg _
