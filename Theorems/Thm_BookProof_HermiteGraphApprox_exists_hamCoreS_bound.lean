-- Generated from ChapterHermiteGraphApprox.lean — theorem BookProof.HermiteGraphApprox.exists_hamCoreS_bound
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
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


theorem BookProof.HermiteGraphApprox.exists_hamCoreS_bound {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (S : Finset (Fin d)) {n : ℕ} (hT : LadderOrd (hamPolyL S q) n) :
    ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ y : polyGaussCore (d := d),
      ENNReal.ofReal (‖hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S y‖ ^ 2)
        ≤ C * hn n (y : L2d d) := by sorry
