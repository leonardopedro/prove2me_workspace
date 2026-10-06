-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.smul_shiftm_diag
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_shiftm_self_eq
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
theorem solution (c : ℂ) (a : Fin d →₀ ℕ) (i : Fin d) :
    (c * (a i : ℂ)) • hermiteMv (shiftm a i i) = (c * (a i : ℂ)) • hermiteMv a := by

  rcases Nat.eq_zero_or_pos (a i) with h | h
  · rw [h]
    simp
  · rw [shiftm_self_eq h]
