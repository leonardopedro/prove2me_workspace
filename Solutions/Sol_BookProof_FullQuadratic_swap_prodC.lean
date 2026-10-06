-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.swap_prodC
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_swap_prod
open BookProof.FullQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) (i j : Fin d) :
    ((a j : ℂ)) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ)
      = ((a i : ℂ)) * (((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℂ) := by

  have h := swap_prod a i j
  exact_mod_cast congrArg (fun n : ℕ => (n : ℂ)) h
