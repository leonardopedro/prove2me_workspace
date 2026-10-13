-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.noncomm
import Mathlib
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinDoubleCover
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : qi * qj ≠ qj * qi := by
 decide
