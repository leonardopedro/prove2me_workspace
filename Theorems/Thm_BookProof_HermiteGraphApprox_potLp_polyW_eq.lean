-- Generated from ChapterHermiteGraphApprox.lean — theorem BookProof.HermiteGraphApprox.potLp_polyW_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.YangMillsHermite
open BookProof.HermiteGraphApprox

variable {d : ℕ}



open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteGraphApprox.potLp_polyW_eq {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (p : MvPolynomial (Fin d) ℂ) :
    potLp (polyW q) (continuous_polyW q) (expBounded_polyW q) p = pgLp (q * p) := by sorry
