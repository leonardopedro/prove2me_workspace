-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.crePoly_annPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_apply
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMv
import Theorems.Thm_BookProof_HermiteProductBasis_pderiv_hermiteMv
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

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
