-- Generated from ChapterQgOneParticleCcEsa.lean — theorem BookProof.QgOneParticleCc.ccHam_essentiallySelfAdjoint_of_core
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteFriedrichs
open BookProof.ScalaronEsa
open BookProof.QgOneParticleCc

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}



open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

theorem BookProof.QgOneParticleCc.ccHam_essentiallySelfAdjoint_of_core (W : Vd d → ℝ)
    (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (hWc : Continuous W) (hWb : ExpBounded W)
    (hcore : EssentiallySelfAdjointOn (polyGaussCore (d := d)) (hamCore W hWc hWb)) :
    EssentiallySelfAdjointOn (ccDomain (Vd d)) (ccHam W hWs) := by sorry
