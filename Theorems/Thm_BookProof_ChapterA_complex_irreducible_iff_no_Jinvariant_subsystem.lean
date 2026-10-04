-- Generated from ChapterA1d.lean — theorem BookProof.ChapterA.complex_irreducible_iff_no_Jinvariant_subsystem
import Mathlib
import Definitions.Def_ChapterA1d
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.complex_irreducible_iff_no_Jinvariant_subsystem [CompleteSpace V] (M : System ℂ V) :
    M.IsIrreducible ↔
      ∀ Y : Submodule ℝ V, (rxSystem M).IsSubsystem Y →
        (∀ y ∈ Y, Jmap y ∈ Y) → Y = ⊥ ∨ Y = ⊤ := by sorry
