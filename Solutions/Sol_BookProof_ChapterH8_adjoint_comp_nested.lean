-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.adjoint_comp_nested
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
open ContinuousLinearMap in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G) :
    (adjoint Vn).comp Vm = adjoint J := by

  subst hJ
  ext x
  have hx : (adjoint Vm) (Vm x) = x :=
    congrArg (fun f : G →L[ℂ] G => f x) hVm
  simp [hx]
