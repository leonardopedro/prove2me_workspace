-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.adjoint_comp_nested
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

open ContinuousLinearMap in
theorem BookProof.ChapterH8.adjoint_comp_nested (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G) :
    (adjoint Vn).comp Vm = adjoint J := by sorry
