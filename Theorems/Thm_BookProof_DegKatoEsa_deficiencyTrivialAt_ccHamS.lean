-- Generated from ChapterDegKatoEsa.lean — theorem BookProof.DegKatoEsa.deficiencyTrivialAt_ccHamS
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterMollifierL2
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa
open BookProof.DegKatoEsa

variable {d : ℕ}



open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section


theorem BookProof.DegKatoEsa.deficiencyTrivialAt_ccHamS (W : Vd d → ℝ)
    (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (hW1 : ∀ x, 1 ≤ W x) (S : Finset (Fin d))
    {z : ℂ} (hz : z.re = 0) :
    DeficiencyTrivialAt (ccDomain (Vd d)) (ccHamS W hWs S) z := by sorry
