-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.velocityOp_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.velocityOp_mem_finiteModes (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
    velocityOp v f ∈ finiteModes := by sorry
