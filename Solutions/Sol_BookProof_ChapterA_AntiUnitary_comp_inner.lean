-- Generated from ChapterA1.lean — solution of BookProof.ChapterA.AntiUnitary.comp_inner
import Mathlib
import Definitions.Def_ChapterA1
import Theorems.Thm_BookProof_ChapterA_AntiUnitary_inner_map_map
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution (θ θ' : AntiUnitary V) (x y : V) :
    inner ℂ (θ' (θ x)) (θ' (θ y)) = inner ℂ x y := by

  rw [inner_map_map, inner_map_map]; simp
