-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.crePoly_annPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_apply
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMv
import Theorems.Thm_BookProof_HermiteProductBasis_pderiv_hermiteMv
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    crePoly i (annPoly i (hermiteMv a)) = ((a i : ℕ) : ℂ) • hermiteMv a := by

  rw [annPoly_apply, pderiv_hermiteMv, map_smul, crePoly_hermiteMv]
  by_cases hai : a i = 0
  · simp [hai]
  · congr 2
    ext j
    by_cases hj : j = i
    · subst hj; simp; omega
    · simp [hj]
