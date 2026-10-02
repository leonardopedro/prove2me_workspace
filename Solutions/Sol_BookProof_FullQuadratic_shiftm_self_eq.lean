-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.shiftm_self_eq
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_CarlemanSimplex_tsub_add_cancel_of_le'
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
theorem solution {a : Fin d →₀ ℕ} {i : Fin d} (h : 1 ≤ a i) : shiftm a i i = a := by

  have hle : Finsupp.single i 1 ≤ a := by
    rw [Finsupp.le_def]
    intro k
    by_cases hk : k = i
    · subst hk; simpa using h
    · simp [Ne.symm hk]
  rw [shiftm, tsub_add_cancel_of_le' hle]
