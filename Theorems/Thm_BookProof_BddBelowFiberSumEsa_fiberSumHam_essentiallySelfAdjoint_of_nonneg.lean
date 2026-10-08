-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_essentiallySelfAdjoint_of_nonneg
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


theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_essentiallySelfAdjoint_of_nonneg (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (hnn : ∀ i x, 0 ≤ V i x) :
    EssentiallySelfAdjointOn (fiberCore ι) (fiberSumHam V hV) := by sorry
