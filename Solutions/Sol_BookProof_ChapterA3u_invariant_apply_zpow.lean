-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.invariant_apply_zpow
import Mathlib
import Definitions.Def_ChapterA3u
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} {σ : Equiv.Perm (Fin N)} {a : Idx N}
    (ha : a ∘ σ = a) (k : ℤ) (x : Fin N) : a ((σ ^ k) x) = a x := by

  rcases k with ( _ | k ) <;> simp_all only [funext_iff, Function.comp_apply, Int.ofNat_eq_natCast,
      zpow_natCast, zpow_negSucc, Equiv.Perm.coe_inv];
  · induction ‹ℕ› <;> simp_all [ pow_succ', Equiv.Perm.mul_apply ];
  · induction k generalizing x with
    | zero => ?_
    | succ k ih => ?_
    all_goals simp_all only [zero_add, pow_succ', pow_zero, mul_one]
    · grind;
    · convert ih ( σ⁻¹ x ) using 1
      · rfl
      · rw [← ha (σ⁻¹ x)]
        simp [Equiv.apply_symm_apply]
