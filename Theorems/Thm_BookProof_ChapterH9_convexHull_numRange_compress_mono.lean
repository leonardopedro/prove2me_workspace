-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.convexHull_numRange_compress_mono
import Definitions.Def_ChapterH1
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
import Mathlib
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterH4
open BookProof.ChapterH4
open BookProof.ChapterH9


noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


theorem BookProof.ChapterH9.convexHull_numRange_compress_mono (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E)
    (J : F →L[ℂ] G) (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖) :
    convexHull ℝ (numRange (compress Vn X)) ⊆ convexHull ℝ (numRange (compress Vm X)) := by sorry
