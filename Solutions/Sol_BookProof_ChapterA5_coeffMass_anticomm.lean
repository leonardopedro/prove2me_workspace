-- Generated from ChapterA5.lean — solution of BookProof.ChapterA5.coeffMass_anticomm
import Mathlib
import Definitions.Def_ChapterA5
open BookProof.ChapterA5



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    coeffMass1Z * coeffMass2Z + coeffMass2Z * coeffMass1Z = 0 := by
 decide
