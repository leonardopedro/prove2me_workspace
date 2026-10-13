-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.hamPolyL_numPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_hamPolyL_numPoly
import Theorems.Thm_BookProof_HermiteGraphApprox_crePoly_annPoly_hermiteMv
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
theorem solution (a : Fin d →₀ ℕ) :
    hamPolyL Finset.univ (numPoly d) (hermiteMv a) = ((a.degree : ℂ) + 1) • hermiteMv a := by

  rw [hamPolyL_numPoly, Finset.sum_congr rfl fun i _ => crePoly_annPoly_hermiteMv i a,
    ← Finset.sum_smul, add_smul, one_smul, Finsupp.degree_eq_sum]
  push_cast
  rfl
