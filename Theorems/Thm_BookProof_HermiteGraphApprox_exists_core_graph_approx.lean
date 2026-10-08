-- Generated from ChapterHermiteGraphApprox.lean — theorem BookProof.HermiteGraphApprox.exists_core_graph_approx
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
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
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa
open BookProof.YangMillsHermite
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


theorem BookProof.HermiteGraphApprox.exists_core_graph_approx (q : MvPolynomial (Fin d) ℂ) (hq : RealCoeff q)
    (S : Finset (Fin d)) (ψ : ccDomain (Vd d)) {ε : ℝ} (hε : 0 < ε) :
    ∃ v : polyGaussCore (d := d),
      ‖(v : L2d d) - (ψ : L2d d)‖ < ε ∧
        ‖hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S v
          - ccHamS (polyW q) (contDiff_polyW q) S ψ‖ < ε := by sorry
