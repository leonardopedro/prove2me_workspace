-- Generated from ChapterNavierStokesFockFarisLavine.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant








open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}



















open FarisLavineLift LpNat DiagonalEsa

theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_hasZeroDeficiencyOn (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    HasZeroDeficiencyOn (fockCore fiberCore) (fockComparison d p q) := by sorry
