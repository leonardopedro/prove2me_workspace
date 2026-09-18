-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.fine_range_of_coarse
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm ((adjoint Vm) v) = v := by

  set w : F := (adjoint Vn) v with hw
  have hvw : v = Vm (J w) := by rw [hJ] at hv; exact hv.symm
  have hmm : (adjoint Vm) (Vm (J w)) = J w :=
    congrArg (fun f : G →L[ℂ] G => f (J w)) hVm
  rw [hvw, hmm]
