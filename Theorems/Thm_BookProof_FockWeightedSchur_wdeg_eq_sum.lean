-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.wdeg_eq_sum
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

theorem BookProof.FockWeightedSchur.wdeg_eq_sum {α : Conf} {S : Finset ℕ} (h : α.support ⊆ S) :
    wdeg w α = ∑ k ∈ S, w k ^ 2 * α k := by sorry
