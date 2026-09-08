-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.shiftOp_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow








open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite

theorem BookProof.NavierStokesFlow.shiftOp_mem_finiteModes (m : ℤ) {f : L2Z} (hf : f ∈ finiteModes) :
    shiftOp m f ∈ finiteModes := by sorry
