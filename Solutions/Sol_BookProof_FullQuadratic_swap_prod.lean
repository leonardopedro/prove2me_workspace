-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.swap_prod
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_sub_single_apply_ne
open BookProof.FullQuadratic




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
theorem solution (a : Fin d →₀ ℕ) (i j : Fin d) :
    (a j) * ((a - Finsupp.single j 1 : Fin d →₀ ℕ) i)
      = (a i) * ((a - Finsupp.single i 1 : Fin d →₀ ℕ) j) := by

  by_cases hij : i = j
  · subst hij; ring
  · rw [sub_single_apply_ne hij, sub_single_apply_ne (Ne.symm hij)]
    ring
