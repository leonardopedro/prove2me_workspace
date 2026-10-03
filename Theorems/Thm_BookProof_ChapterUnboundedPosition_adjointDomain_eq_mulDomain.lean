-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.adjointDomain_eq_mulDomain
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.adjointDomain_eq_mulDomain (f : ℤ → ℝ) :
    adjointDomain f = ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by sorry
