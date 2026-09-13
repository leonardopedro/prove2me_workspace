-- Generated from ChapterNavierStokesFockFarisLavine.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant
open scoped ENNReal
open BookProof.NavierStokesFlow.FarisLavineLift
variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}



















open BookProof.NavierStokesFlow.FarisLavineLift BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.DiagonalEsa
theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_dense :
    Dense ((fockCore fiberCore : Submodule ℂ (lp fiberSector 2)) : Set (lp fiberSector 2)) := by sorry
