-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow








open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite

theorem BookProof.NavierStokesFlow.mem_finiteModes {f : L2Z} :
    f ∈ finiteModes ↔ (Function.support ((f : ℤ → ℂ))).Finite := by sorry
