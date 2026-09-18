import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_oscPoly_hermiteMv
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    quadPoly c (hermiteMv a) = ((quadSymbol c a : ℝ) : ℂ) • hermiteMv a := by

  rw [quadPoly, LinearMap.sum_apply]
  have hterm : ∀ i : Fin d, (((c i : ℝ) : ℂ) • oscPoly i) (hermiteMv a)
      = (((c i * ((a i : ℝ) + 1/2) : ℝ)) : ℂ) • hermiteMv a := by
    intro i
    rw [LinearMap.smul_apply, oscPoly_hermiteMv, smul_smul]
    push_cast
    ring_nf
  rw [Finset.sum_congr rfl fun i _ => hterm i, ← Finset.sum_smul]
  congr 1
  rw [quadSymbol]
  push_cast
  ring
