-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.ndeg_le_wdeg
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

theorem BookProof.FockWeightedSchur.ndeg_le_wdeg (hw : ∀ k, 1 ≤ w k) (α : Conf) : (ndeg α : ℝ) ≤ wdeg w α := by sorry
