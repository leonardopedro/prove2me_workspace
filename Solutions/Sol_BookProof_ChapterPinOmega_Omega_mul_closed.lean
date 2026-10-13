-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.Omega_mul_closed
import Mathlib
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinDoubleCover
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : ∀ x ∈ Omega, ∀ y ∈ Omega, x * y ∈ Omega := by
 decide
