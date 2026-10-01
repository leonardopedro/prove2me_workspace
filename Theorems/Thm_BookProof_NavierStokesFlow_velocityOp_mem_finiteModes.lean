-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.velocityOp_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}


open scoped Matrix




ite.subset (hf.image fun k => k - m) ?_
  intro k hk
  simp only [Function.mem_support, shiftOp_apply] at hk
  exact ⟨k + m, hk, by ring⟩

/-- Multiplication by a bounded velocity field preserves the := by sorry
