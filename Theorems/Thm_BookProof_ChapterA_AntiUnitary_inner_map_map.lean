-- Generated from ChapterA1.lean — theorem BookProof.ChapterA.AntiUnitary.inner_map_map
import Mathlib
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

theorem BookProof.ChapterA.AntiUnitary.inner_map_map (θ : AntiUnitary V) (x y : V) :
    inner ℂ (θ x) (θ y) = conj (inner ℂ x y) := by sorry
