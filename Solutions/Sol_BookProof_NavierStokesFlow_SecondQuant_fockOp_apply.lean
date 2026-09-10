-- Generated from ChapterNavierStokesSecondQuant.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesSecondQuant
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant










open scoped ENNReal



variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]





variable (D : ∀ m, Submodule ℂ (S m))


variable {D}

set_option maxHeartbeats 1000000 in
theorem solution (A : ∀ m, D m →ₗ[ℂ] D m) (f : fockCore D) (m : ι) :
    ((fockOp A f : lp S 2) : ∀ m, S m) m = ((A m ⟨(f : lp S 2) m, (f.2).2 m⟩ : D m) : S m) := rfl
