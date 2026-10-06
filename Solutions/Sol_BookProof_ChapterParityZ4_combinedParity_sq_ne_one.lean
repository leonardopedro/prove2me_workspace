-- Generated from ChapterParityZ4.lean — solution of BookProof.ChapterParityZ4.combinedParity_sq_ne_one
import Mathlib
import Definitions.Def_ChapterParityZ4
import Theorems.Thm_BookProof_ChapterParityZ4_combinedParity_sq
open BookProof.ChapterParityZ4



open Matrix


open BookProof.ChapterParity
open BookProof.ChapterParityQL
open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : combinedParity ^ 2 ≠ 1 := by

  intro h;    have := congrArg ( fun m => m.1 0 0 ) h; norm_num [ combinedParity_sq,
      Matrix.one_apply ] at this;
