-- Generated from ChapterParity.lean — theorem BookProof.ChapterParity.fermionParity_order_four
import Mathlib
import Definitions.Def_ChapterParity
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterParity

variable {n : Type*}


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterParity.fermionParity_order_four :
    mgamma 0 * mgamma 0 ≠ 1 ∧
      mgamma 0 * mgamma 0 * (mgamma 0 * mgamma 0) = 1 := by sorry
