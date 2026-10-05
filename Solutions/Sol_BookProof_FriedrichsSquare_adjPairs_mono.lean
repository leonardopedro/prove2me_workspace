-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.adjPairs_mono
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {G H : Submodule ℂ (F × F)} (h : G ≤ H) : adjPairs H ≤ adjPairs G := fun _ hp q hq => hp q (h hq)
