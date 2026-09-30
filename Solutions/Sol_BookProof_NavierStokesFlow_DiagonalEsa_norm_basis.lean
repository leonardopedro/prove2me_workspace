-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.norm_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa










open scoped ENNReal











open LpNat





























open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : ‖basis n‖ = 1 := by

  have : ‖(basis n : L2N)‖ = ‖(1 : ℂ)‖ := lp.norm_single (by norm_num) n 1
  simpa using this
