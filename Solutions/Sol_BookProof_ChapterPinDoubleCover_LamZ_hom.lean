-- Generated from ChapterPinDoubleCover.lean — solution of BookProof.ChapterPinDoubleCover.LamZ_hom
import Mathlib
import Definitions.Def_ChapterPinDoubleCover
open BookProof.ChapterPinDoubleCover



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : ∀ S ∈ Omega, ∀ T ∈ Omega, LamZ (S * T) = LamZ S * LamZ T := by
 decide
