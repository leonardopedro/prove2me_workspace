-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.annA_wgt
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

theorem BookProof.FockWeightedSchur.annA_wgt (j : ℕ) (u : FockAlg) :
    annA j (wgt w u) = wgt w (annA j u) + ((w j ^ 2 : ℝ) : ℂ) • annA j u := by sorry
