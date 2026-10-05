-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.minkowskiCoeff_ne_zero
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
open BookProof.ShiftedQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (i : Fin (1 + n)) : minkowskiCoeff n i ≠ 0 := by

  by_cases h : i = 0 <;> simp [minkowskiCoeff, h]
