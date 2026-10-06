-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genY_shifts_velocity
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (p : NSAlg) :
    genY j (X (NSVar.u i) * p) - X (NSVar.u i) * genY j p = -(X (NSVar.uD i j) * p) := by

  have expand : ∀ m : Fin 3, X (NSVar.uD m j) * pderiv (NSVar.u m) (X (NSVar.u i) * p)
      = (if m = i then X (NSVar.uD m j) * p else 0)
        + X (NSVar.u i) * (X (NSVar.uD m j) * pderiv (NSVar.u m) p) := by
    intro m
    rw [pderiv_mul, pderiv_X, Pi.single_apply]
    simp only [NSVar.u.injEq]
    by_cases h : m = i
    · subst h; simp; ring
    · rw [if_neg (fun hh : i = m => h hh.symm), if_neg h]; ring
  have hsum : ∑ m : Fin 3, X (NSVar.uD m j) * pderiv (NSVar.u m) (X (NSVar.u i) * p)
      = X (NSVar.uD i j) * p
        + X (NSVar.u i) * ∑ m : Fin 3, X (NSVar.uD m j) * pderiv (NSVar.u m) p := by
    rw [Finset.sum_congr rfl fun m _ => expand m, Finset.sum_add_distrib,
      Finset.sum_ite_eq' Finset.univ i (fun m => X (NSVar.uD m j) * p),
      if_pos (Finset.mem_univ i), Finset.mul_sum]
  rw [genY_apply, genY_apply, hsum, pderiv_mul, pderiv_X_of_ne (by simp)]
  ring
