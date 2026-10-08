-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.qgFiberSum_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.BddBelowFiberSumEsa



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}


theorem BookProof.BddBelowFiberSumEsa.qgFiberSum_esa {M alpha : ℝ} (halpha : 0 < alpha) {d : ℕ} (omega : Fin d → ℝ) :
    EssentiallySelfAdjointOn (fiberCore (Option (Fin d)))
      (fiberSumHam (qgFiberV M alpha omega) (contDiff_qgFiberV M alpha omega)) := by sorry
