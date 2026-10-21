-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.noncommC
import Mathlib
import Definitions.Def_ChapterPinOmega
import Theorems.Thm_BookProof_ChapterPinOmega_qkC_eq_cast
import Theorems.Thm_BookProof_ChapterPinOmega_qiC_qjC
import Theorems.Thm_BookProof_ChapterPinOmega_qjC_qiC
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : qiC * qjC ≠ qjC * qiC := by

  rw [qiC_qjC, qjC_qiC]
  intro h
  have h01 := congrFun (congrFun h 0) 1
  rw [qkC_eq_cast, qk] at h01
  simp [Matrix.neg_apply, RingHom.mapMatrix_apply, Matrix.map_apply, mgamma5Z] at h01
  norm_num at h01
