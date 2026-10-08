-- Generated from ChapterHermiteGraphApprox.lean — theorem BookProof.HermiteGraphApprox.coreD_coreD_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteProductBasis
open BookProof.QgHermiteFriedrichs
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


theorem BookProof.HermiteGraphApprox.coreD_coreD_eq (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    -coreD i (coreD i p) + C (((1 / 4 : ℝ)) : ℂ) * (X i * X i) * p - C (1 / 2 : ℂ) * p
      = crePoly i (annPoly i p) := by sorry
