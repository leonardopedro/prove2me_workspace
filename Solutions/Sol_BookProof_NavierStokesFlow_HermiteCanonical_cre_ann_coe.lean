-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.cre_ann_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_ann_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_cre_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_sqrt_mul_sqrt
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes ℕ) (n : ℕ) :
    (((cre (ann x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (n : ℂ) * ((x : L2I ℕ) : ℕ → ℂ) n := by

  rw [cre_coe]
  cases n with
  | zero => simp
  | succ k =>
      rw [ann_coe]
      have h1 : (k + 1 - 1) = k := by omega
      rw [h1]
      push_cast
      rw [← mul_assoc, sqrt_mul_sqrt _ (by positivity)]
      push_cast
      ring
