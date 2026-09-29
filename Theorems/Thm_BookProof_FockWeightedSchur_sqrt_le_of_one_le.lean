-- Generated from ChapterFockWeightedSchurEsa.lean — theorem BookProof.FockWeightedSchur.sqrt_le_of_one_le
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur













open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

theorem BookProof.FockWeightedSchur.sqrt_le_of_one_le {a : ℝ} (h : 1 ≤ a) : Real.sqrt a ≤ a := by sorry
