-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.sum_wsq_normSq_annA
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

theorem BookProof.FockWeightedSchur.sum_wsq_normSq_annA {u : FockAlg} {L : Finset ℕ} (hL : modes u ⊆ L) :
    ∑ k ∈ L, w k ^ 2 * ‖toLp (annA k u)‖ ^ 2 = ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2 := by sorry
