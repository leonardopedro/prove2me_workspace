-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.adjoint_comp_nested
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.adjoint_comp_nested (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G) :
    (adjoint Vn).comp Vm = adjoint J := by sorry
