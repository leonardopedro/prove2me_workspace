-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}


open scoped Matrix




).Finite := Iff.rfl

theorem BookProof.NavierStokesFlow.mem_finiteModes (k : ℤ) (c : ℂ) : lp.single 2 k c ∈ finiteModes :=
  lpSingle_mem_lpFi := by sorry
