-- Generated from ChapterDeterministic.lean — solution of BookProof.ChapterDeterministic.commute_proj_measOp_iff_isDeterministic
import Mathlib
import Definitions.Def_ChapterDeterministic
import Theorems.Thm_BookProof_ChapterDeterministic_commute_proj_measOp_iff_isDeterministicCol
open BookProof.ChapterDeterministic



open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution
    (U : Matrix (Fin n) (Fin n) ℂ) :
    (∀ a b : Fin n, Commute (proj a) (measOp U b)) ↔ IsDeterministic U := by

  constructor;
  · exact fun h => fun b => ( commute_proj_measOp_iff_isDeterministicCol U b ).mp fun a => h a b;
  · intro h a b; specialize h b; exact (commute_proj_measOp_iff_isDeterministicCol U b).mpr h a;
