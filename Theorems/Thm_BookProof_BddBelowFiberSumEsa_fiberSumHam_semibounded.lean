-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_semibounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded
open BookProof.BddBelowFiberSumEsa

variable {ι : Type*}



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa

noncomputable section


theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_semibounded (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) {c : ℝ} (hc : ∀ i x, -c ≤ V i x) :
    SemiboundedBelowOn (fiberCore ι) (fiberSumHam V hV) c := by sorry
