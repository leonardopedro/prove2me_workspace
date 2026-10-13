-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.kinCc_symmetricOn
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_ScalaronEsa_symmetricOn_inclusion
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa
open BookProof.StrichartzWave

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (ccDomain (Vd d)) (kinCc d) := symmetricOn_inclusion _ _ (constCoeffOp_symmetric _ _ _)
