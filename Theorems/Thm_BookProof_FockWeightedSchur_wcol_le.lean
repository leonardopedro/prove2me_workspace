-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.wcol_le
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

theorem BookProof.FockWeightedSchur.wcol_le (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col) (hK : WColBound w col K) (j : ℕ)
    (L : Finset ℕ) : ∑ k ∈ L, ‖(col k) j‖ / w k ≤ K := by sorry
