-- Generated from ChapterNavierStokesSecondQuant.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesSecondQuant
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_single_mem_fockCore
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_fockOp_single
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant










open scoped ENNReal



variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]





variable (D : ∀ m, Submodule ℂ (S m))


variable {D}

set_option maxHeartbeats 1000000 in
theorem solution (A : ∀ m, D m →ₗ[ℂ] D m)
    (hA : ∀ m, HasZeroDeficiencyOn (D m) (A m)) :
    HasZeroDeficiencyOn (fockCore D) (fockOp A) := by

  classical
  have key : ∀ (z : ℂ) (w : lp S 2),
      (∀ v : fockCore D, (inner ℂ ((fockOp A v : lp S 2)) w : ℂ) = inner ℂ ((v : lp S 2)) (z • w)) →
      ∀ m : ι, ∀ x : D m,
        (inner ℂ ((A m x : D m) : S m) ((w : ∀ m, S m) m) : ℂ)
          = inner ℂ ((x : S m)) (z • (w : ∀ m, S m) m) := by
    intro z w hw m x
    have hv := hw ⟨lp.single 2 m (x : S m), single_mem_fockCore m (x : S m) x.2⟩
    rw [fockOp_single A m x] at hv
    rw [lp.inner_single_left] at hv
    have hz : ((z • w : lp S 2) : ∀ m, S m) m = z • (w : ∀ m, S m) m := by
      simp [lp.coeFn_smul]
    rw [show ((⟨lp.single 2 m (x : S m), single_mem_fockCore m (x : S m) x.2⟩ :
        fockCore D) : lp S 2) = lp.single 2 m (x : S m) from rfl, lp.inner_single_left,
      hz] at hv
    exact hv
  constructor
  · intro w hw
    apply lp.ext
    funext m
    have hm := (hA m).1 ((w : ∀ m, S m) m) (fun x => key Complex.I w hw m x)
    simpa using hm
  · intro w hw
    apply lp.ext
    funext m
    have hw' : ∀ v : fockCore D,
        (inner ℂ ((fockOp A v : lp S 2)) w : ℂ)
          = inner ℂ ((v : lp S 2)) ((-Complex.I) • w) := by
      intro v
      simpa using hw v
    have hm := (hA m).2 ((w : ∀ m, S m) m) (fun x => by
      simpa using key (-Complex.I) w hw' m x)
    simpa using hm
