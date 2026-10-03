-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.dsOp_semibounded
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.DirectSumEsa
open BookProof.WallEsaSemibounded
open BookProof.BddBelowFiberSumEsa

variable {ι : Type*}



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa

noncomputable section


theorem BookProof.BddBelowFiberSumEsa.dsOp_semibounded {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
    [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}
    (H : ∀ i, D i →ₗ[ℂ] G i) {c : ℝ} (h : ∀ i, SemiboundedBelowOn (D i) (H i) c) :
    SemiboundedBelowOn (dsCore D) (dsOp H) c := by sorry
