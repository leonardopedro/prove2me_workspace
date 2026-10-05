-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.cembed_realCommutes
import Mathlib
import Definitions.Def_ChapterA2c
import Theorems.Thm_BookProof_ChapterA_cembed_apply
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) (c : ℂ) :
    RealCommutes M (cembed c) := by

  intro m hm x
  rw [cembed_apply, cembed_apply, map_smul]
