-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.support_wgt_subset
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

theorem BookProof.FockWeightedSchur.support_wgt_subset (u : FockAlg) : (wgt w u).support ⊆ u.support := by sorry
