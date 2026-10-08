-- Generated from ChapterA1.lean — theorem BookProof.ChapterA.AntiUnitary.comp_inner
import Mathlib
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

theorem BookProof.ChapterA.AntiUnitary.comp_inner (θ θ' : AntiUnitary V) (x y : V) :
    inner ℂ (θ' (θ x)) (θ' (θ y)) = inner ℂ x y := by sorry
