-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.sqrt_le_of_one_le
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {a : ℝ} (h : 1 ≤ a) : Real.sqrt a ≤ a := by

  have h0 : (0:ℝ) ≤ a := le_trans zero_le_one h
  nlinarith [Real.sq_sqrt h0, Real.sqrt_nonneg a, sq_nonneg (Real.sqrt a - 1)]
