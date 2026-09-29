-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.wSym_up
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

theorem BookProof.FockWeightedSchur.wSym_up (j : ℕ) (α : Conf) : wSym w (up j α) = wSym w α + w j ^ 2 := by sorry
