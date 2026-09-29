import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.hermiteMv_number
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_apply
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMv
import Theorems.Thm_BookProof_HermiteProductBasis_pderiv_hermiteMv
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    X i * pderiv i (hermiteMv a) - pderiv i (pderiv i (hermiteMv a))
      = ((a i : ℂ)) • hermiteMv a := by

  classical
  set b : Fin d →₀ ℕ := a - Finsupp.single i 1 with hb
  have hd : pderiv i (hermiteMv a) = ((a i : ℂ)) • hermiteMv b := pderiv_hermiteMv i a
  rw [hd, mul_smul_comm, Derivation.map_smul_of_tower, ← smul_sub]
  have hcre : X i * hermiteMv b - pderiv i (hermiteMv b)
      = hermiteMv (b + Finsupp.single i 1) := by
    have h := crePoly_hermiteMv i b
    rwa [crePoly_apply] at h
  rw [hcre]
  rcases Nat.eq_zero_or_pos (a i) with h0 | hpos
  · rw [h0]; simp
  · have hba : b + Finsupp.single i 1 = a := by
      ext j
      by_cases hj : j = i
      · subst hj; simp [hb]; omega
      · simp [hb, hj]
    rw [hba]
