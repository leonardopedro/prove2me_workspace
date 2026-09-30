-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.dGammaOp_commForm_bound_w
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

theorem BookProof.FockWeightedSchur.dGammaOp_commForm_bound_w (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hBg : WCommBound w col B) (x : lpFiniteModes Conf) :
    |(-2 : ℝ) * (inner ℂ (dGammaOp col x)
        ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).im|
      ≤ B * (inner ℂ ((x : Fock)) ((diagMax (wSym w) (inclC (wSym w) x) : Fock)) : ℂ).re := by sorry
