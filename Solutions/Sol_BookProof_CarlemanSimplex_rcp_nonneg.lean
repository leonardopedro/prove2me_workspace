-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.rcp_nonneg
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) (i j : Fin d) : 0 ≤ rcp a i j := mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)
