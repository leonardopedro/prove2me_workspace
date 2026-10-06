-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.fqExch_hermitian
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
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
theorem solution (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) :
    (starRingEnd ℂ) (fqExch P Q S i j) = fqExch P Q S j i := by

  rw [fqExch, fqExch, map_add, Complex.conj_conj]
  ring
