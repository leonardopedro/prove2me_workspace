-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadSymbol_single
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) (i : Fin d) (n : ℕ) :
    quadSymbol c (Finsupp.single i n) = c i * (n : ℝ) + ∑ j, c j * (1/2) := by

  classical
  have hsplit : ∀ j : Fin d, c j * (((Finsupp.single i n : Fin d →₀ ℕ) j : ℝ) + 1/2)
      = (if j = i then c i * (n : ℝ) else 0) + c j * (1/2) := by
    intro j
    by_cases hj : j = i
    · subst hj; simp; ring
    · simp [hj]
  rw [quadSymbol, Finset.sum_congr rfl fun j _ => hsplit j, Finset.sum_add_distrib]
  simp
