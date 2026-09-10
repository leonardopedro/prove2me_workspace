-- Generated from ChapterNavierStokesSecondQuant.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockCore_ne_top
import Mathlib
import Definitions.Def_ChapterNavierStokesSecondQuant
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]





variable (D : ∀ m, Submodule ℂ (S m))


variable {D}

theorem BookProof.NavierStokesFlow.SecondQuant.fockCore_ne_top {S : ℕ → Type*} [∀ m, NormedAddCommGroup (S m)]
    [∀ m, InnerProductSpace ℂ (S m)] (D : ∀ m, Submodule ℂ (S m))
    (v : ∀ m, S m) (hv : ∀ m, ‖v m‖ = 1) :
    (fockCore D : Submodule ℂ (lp S 2)) ≠ ⊤ := by sorry
