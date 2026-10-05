-- Generated from ChapterFreeFieldBornFiberTwo.lean — solution of BookProof.ChapterFreeFieldBornFiberTwo.bornMapSphere_not_injective
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberTwo
import Theorems.Thm_BookProof_ChapterFreeFieldBorn_bornMap_mem_stdSimplex
open BookProof.ChapterFreeFieldBornFiberTwo



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hn : 0 < n) :
    ¬ Function.Injective (bornMapSphere n) := by

  unfold bornMapSphere; intro h; simp_all only [Function.Injective, Subtype.mk.injEq,
      Subtype.forall, mem_sphere_iff_norm, sub_zero]
  contrapose! h
  refine ⟨EuclideanSpace.single ⟨0, hn⟩ 1, ?_, -EuclideanSpace.single ⟨0, hn⟩ 1, ?_, ?_, ?_⟩ <;>
    norm_num [EuclideanSpace.norm_eq]
  · ext; simp [bornMap]
  · exact ne_of_apply_ne (fun x => x ⟨0, hn⟩) (by norm_num)
