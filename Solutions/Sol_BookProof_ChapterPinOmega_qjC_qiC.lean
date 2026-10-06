-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.qjC_qiC
import Mathlib
import Definitions.Def_ChapterPinOmega
import Theorems.Thm_BookProof_ChapterPinOmega_qj_qi
import Theorems.Thm_BookProof_ChapterPinOmega_qiC_eq_cast
import Theorems.Thm_BookProof_ChapterPinOmega_qjC_eq_cast
import Theorems.Thm_BookProof_ChapterPinOmega_qkC_eq_cast
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : qjC * qiC = -qkC := by

  rw [qiC_eq_cast, qjC_eq_cast, qkC_eq_cast, ← map_mul, qj_qi, map_neg]
