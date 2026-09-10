-- Generated from ChapterNavierStokesSecondQuant.lean — solution of BookProof.NavierStokesFlow.SecondQuant.mem_fockCore
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
theorem solution {f : lp S 2} :
    f ∈ fockCore D ↔
      (Function.support fun m => ‖(f : ∀ m, S m) m‖).Finite ∧ ∀ m, (f : ∀ m, S m) m ∈ D m := Iff.rfl
