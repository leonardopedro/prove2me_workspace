-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.ann_ann_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_ann_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes ℕ) (n : ℕ) :
    (((ann (ann x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (Real.sqrt ((n : ℝ) + 1) : ℂ) * (Real.sqrt ((n : ℝ) + 2) : ℂ)
        * ((x : L2I ℕ) : ℕ → ℂ) (n + 2) := by

  rw [ann_coe, ann_coe]
  push_cast
  ring_nf
