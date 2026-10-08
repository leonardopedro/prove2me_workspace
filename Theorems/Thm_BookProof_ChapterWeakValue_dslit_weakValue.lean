-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.dslit_weakValue
import Mathlib
import Definitions.Def_ChapterWeakValue
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.dslit_weakValue :
    weakValue (H *ᵥ psi0) psi0 (projMat 0) = 1 ∧
      weakValue (H *ᵥ psi0) psi0 (projMat 1) = 0 := by sorry
