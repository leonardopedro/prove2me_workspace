-- Generated from ChapterQgOneParticleCcEsa.lean — theorem BookProof.QgOneParticleCc.norm_cutErr_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
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

theorem BookProof.QgOneParticleCc.norm_cutErr_le (W : Vd d → ℝ) {C K R : ℝ} (hC0 : 0 ≤ C) (hCK : C ≤ K) (hR1 : 1 ≤ R)
    (p : MvPolynomial (Fin d) ℂ) (z : Vd d)
    (hd1 : ∀ j : Fin d, ‖dcoord j (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z‖ ≤ C / R)
    (hd2 : ‖lapC (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z‖ ≤ C / R ^ 2) :
    ‖cutErr W R p z‖ ≤ majorant W K p z := by sorry
