-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.ann_cre_coe
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
    (((ann (cre x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = ((n : ℂ) + 1) * ((x : L2I ℕ) : ℕ → ℂ) n := by

  rw [ann_coe, cre_coe]
  have h1 : (n + 1 - 1) = n := by omega
  rw [h1]
  push_cast
  rw [← mul_assoc, sqrt_mul_sqrt _ (by positivity)]
  push_cast
  ring
