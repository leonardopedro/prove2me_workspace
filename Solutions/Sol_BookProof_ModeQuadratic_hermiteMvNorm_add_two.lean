-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.hermiteMvNorm_add_two
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_add_single_one_one
import Theorems.Thm_BookProof_ModeQuadratic_add_single_apply_self
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvNorm_add_single




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMvNorm (a + Finsupp.single i 2)
      = hermiteMvNorm a * Real.sqrt ((a i : ℝ) + 1) * Real.sqrt ((a i : ℝ) + 2) := by

  rw [← add_single_one_one i a, hermiteMvNorm_add_single i (a + Finsupp.single i 1),
    hermiteMvNorm_add_single i a, add_single_apply_self]
  push_cast
  ring_nf
