-- Generated from ChapterNavierStokesSecondQuant.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockOp_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesSecondQuant
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]





variable (D : ∀ m, Submodule ℂ (S m))


variable {D}

theorem BookProof.NavierStokesFlow.SecondQuant.fockOp_hasZeroDeficiencyOn (A : ∀ m, D m →ₗ[ℂ] D m)
    (hA : ∀ m, HasZeroDeficiencyOn (D m) (A m)) :
    HasZeroDeficiencyOn (fockCore D) (fockOp A) := by sorry
