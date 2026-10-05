-- Generated from ChapterStoneSeparable.lean — solution of BookProof.ChapterStoneSeparable.stoneU_mulSA
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Theorems.Thm_BookProof_ChapterStoneSeparable_eq_stoneU_of_hasDerivAt
import Theorems.Thm_BookProof_ChapterStoneSeparable_hasDerivAt_phaseGroup
open BookProof.ChapterStoneSeparable



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    (mulSA f).stoneU t psi = phaseUnitary f (-t) psi := by

  have h := eq_stoneU_of_hasDerivAt (mulSA f) (phaseGroup f) (hasDerivAt_phaseGroup f) t
  exact congrArg (fun L : L2Z →L[ℂ] L2Z => L psi) h.symm
