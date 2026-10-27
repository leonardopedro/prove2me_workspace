-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.invCLMAt_sub
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_eq_of_mem
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) (h : F) :
    invCLMAt hT ha h - invCLMAt hT hb h
      = ((b : ℂ) - (a : ℂ)) • invCLMAt hT ha (invCLMAt hT hb h) := by

  have hb1 := invCLMAt_mem hT hb h
  set x := invCLMAt hT hb h with hxdef
  have hmem : (x, (h + ((a : ℂ) - (b : ℂ)) • x) - (a : ℂ) • x) ∈ T := by
    have hsimp : (h + ((a : ℂ) - (b : ℂ)) • x) - (a : ℂ) • x = h - (b : ℂ) • x := by
      module
    rw [hsimp]
    exact hb1
  have hxa : invCLMAt hT ha (h + ((a : ℂ) - (b : ℂ)) • x) = x :=
    invCLMAt_eq_of_mem hT ha hmem
  rw [map_add, map_smul] at hxa
  have hrw : invCLMAt hT ha h = x - ((a : ℂ) - (b : ℂ)) • invCLMAt hT ha x :=
    eq_sub_of_add_eq hxa
  rw [hrw]
  module
