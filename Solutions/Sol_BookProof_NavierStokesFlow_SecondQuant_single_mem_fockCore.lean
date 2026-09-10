-- Generated from ChapterNavierStokesSecondQuant.lean — solution of BookProof.NavierStokesFlow.SecondQuant.single_mem_fockCore
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
theorem solution [DecidableEq ι] (m : ι) (x : S m) (hx : x ∈ D m) :
    lp.single 2 m x ∈ fockCore D := by

  have hne_zero : ∀ {j : ι}, j ≠ m → ((lp.single 2 m x : lp S 2) : ∀ j, S j) j = 0 := by
    intro j hj
    exact lp.single_apply_ne 2 m x hj
  constructor
  · refine (Set.finite_singleton m).subset ?_
    intro j hj
    simp only [Function.mem_support] at hj
    by_contra hcon
    have hjm : j ≠ m := by simpa using hcon
    exact hj (by rw [hne_zero hjm]; simp)
  · intro j
    rcases eq_or_ne j m with rfl | hjm
    · simpa [lp.single_apply_self] using hx
    · rw [hne_zero hjm]
      exact (D j).zero_mem
